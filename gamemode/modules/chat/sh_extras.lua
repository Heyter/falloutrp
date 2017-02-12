
// Functions and variables that are needed for DarkRP chat to work
// Instead of just adding all the files, just pull them out individually

local plyMeta = FindMetaTable("Player")

// CLIENT
if CLIENT then
	// AddNonParsedText
	local function safeText(text)
		return string.match(text, "^#([a-zA-Z_]+)$") and text .. " " or text
	end
	
	function chat.AddNonParsedText(...)
		local tbl = {...}
		for i = 2, #tbl, 2 do
			tbl[i] = safeText(tbl[i])
		end
		return chat.AddText(unpack(tbl))
	end
	
	// Voice Chat
	function GM:PlayerStartVoice(ply)
		if ply == LocalPlayer() then
			ply.DRPIsTalking = true
			return -- Not the original rectangle for yourself! ugh!
		end
	end

	function GM:PlayerEndVoice(ply)
		if ply == LocalPlayer() then
			ply.DRPIsTalking = false
			return
		end
	end
end

// SERVER
if SERVER then
	// talkToPerson
	util.AddNetworkString("DarkRP_Chat")
	
	function DarkRP.talkToRange(ply, PlayerName, Message, size)
		local ents = ents.FindInSphere(ply:EyePos(), size)
		local col = team.GetColor(ply:Team())
		local filter = {}

		for k, v in pairs(ents) do
			if v:IsPlayer() then
				table.insert(filter, v)
			end
		end

		if PlayerName == ply:getName() then PlayerName = "" end -- If it's just normal chat, why not cut down on networking and get the name on the client

		net.Start("DarkRP_Chat")
			net.WriteUInt(col.r, 8)
			net.WriteUInt(col.g, 8)
			net.WriteUInt(col.b, 8)
			net.WriteString(PlayerName)
			net.WriteEntity(ply)
			net.WriteUInt(255, 8)
			net.WriteUInt(255, 8)
			net.WriteUInt(255, 8)
			net.WriteString(Message)
		net.Send(filter)
	end	
	
	function DarkRP.talkToPerson(receiver, col1, text1, col2, text2, sender)
		net.Start("DarkRP_Chat")
			net.WriteUInt(col1.r, 8)
			net.WriteUInt(col1.g, 8)
			net.WriteUInt(col1.b, 8)
			net.WriteString(text1)

			sender = sender or Entity(0)
			net.WriteEntity(sender)

			col2 = col2 or Color(0, 0, 0)
			net.WriteUInt(col2.r, 8)
			net.WriteUInt(col2.g, 8)
			net.WriteUInt(col2.b, 8)
			net.WriteString(text2 or "")
		net.Send(receiver)
	end
	
	// Player Voice
	local function IsInRoom(listener, talker) -- IsInRoom function to see if the player is in the same room.
		local tracedata = {}
		tracedata.start = talker:GetShootPos()
		tracedata.endpos = listener:GetShootPos()
		local trace = util.TraceLine(tracedata)

		return not trace.HitWorld
	end
	
	local function calcPlyCanHearPlayerVoice(listener)
		if not IsValid(listener) then return end
		listener.DrpCanHear = listener.DrpCanHear or {}
		for _, talker in pairs(player.GetAll()) do
			listener.DrpCanHear[talker] = not true or -- Voiceradius is off, everyone can hear everyone
				(listener:GetShootPos():DistToSqr(talker:GetShootPos()) < 302500 and -- voiceradius is on and the two are within hearing distance
					(not true or IsInRoom(listener, talker))) -- Dynamic voice is on and players are in the same room
		end
	end
	hook.Add("PlayerInitialSpawn", "DarkRPCanHearVoice", function(ply)
		timer.Create(ply:UserID() .. "DarkRPCanHearPlayersVoice", 0.5, 0, fn.Curry(calcPlyCanHearPlayerVoice, 2)(ply))
	end)
	hook.Add("PlayerDisconnected", "DarkRPCanHearVoice", function(ply)
		if not ply.DrpCanHear then return end
		for k,v in pairs(player.GetAll()) do
			if not v.DrpCanHear then continue end
			v.DrpCanHear[ply] = nil
		end
		timer.Remove(ply:UserID() .. "DarkRPCanHearPlayersVoice")
	end)
	function GM:PlayerCanHearPlayersVoice(listener, talker)
		local canHear = listener.DrpCanHear and listener.DrpCanHear[talker]
		return canHear, true
	end
end

// Load custom
hook.Add("InitPostEntity", "LoadDarkRPChatItems", function()
	hook.Call("loadCustomDarkRPItems", GAMEMODE)
end)

// findPlayer
function DarkRP.findPlayer(info)
    if not info or info == "" then return nil end
    local pls = player.GetAll()

    for k = 1, #pls do -- Proven to be faster than pairs loop.
        local v = pls[k]
        if tonumber(info) == v:UserID() then
            return v
        end

        if info == v:SteamID() then
            return v
        end

        if string.find(string.lower(v:getName()), string.lower(tostring(info)), 1, true) ~= nil then
            return v
        end

        if string.find(string.lower(v:SteamID()), string.lower(tostring(info)), 1, true) ~= nil then
            return v
        end
    end
    return nil
end

// isInRoom
function plyMeta:isInRoom()
    local tracedata = {}
    tracedata.start = LocalPlayer():GetShootPos()
    tracedata.endpos = self:GetShootPos()
    local trace = util.TraceLine(tracedata)

    return not trace.HitWorld
end

// getPhrase
local rp_languages = {}
local selectedLanguage = GetConVar("gmod_language"):GetString() -- Switch language by setting gmod_language to another language

function DarkRP.addLanguage(name, tbl)
    local old = rp_languages[name] or {}
    rp_languages[name] = tbl

    -- Merge the language with the translations added by DarkRP.addPhrase
    for k,v in pairs(old) do
        if rp_languages[name][k] then continue end
        rp_languages[name][k] = v
    end
    LANGUAGE = rp_languages[name] -- backwards compatibility
end

function DarkRP.addPhrase(lang, name, phrase)
    rp_languages[lang] = rp_languages[lang]  or {}
    rp_languages[lang][name] = phrase
end

function DarkRP.getPhrase(name, ...)
    local langTable = rp_languages[selectedLanguage] or rp_languages.en

    return (langTable[name] or rp_languages.en[name]) and string.format(langTable[name] or rp_languages.en[name], ...) or nil
end

local my_language = {

    -- Talking
    hear_noone = "No-one can hear you %s!",
    hear_everyone = "Everyone can hear you!",
    hear_certain_persons = "Players who can hear you %s: ",

    whisper = "whisper",
    yell = "yell",
    broadcast = "[Broadcast!]",
    radio = "radio",
    request = "(REQUEST!)",
    group = "(group)",
    demote = "(DEMOTE)",
    ooc = "OOC",
    radio_x = "Radio %d",

    talk = "talk",
    speak = "speak",

    speak_in_ooc = "speak in OOC",
    perform_your_action = "perform your action",
    talk_to_your_group = "talk to your group",

    unable = "You are unable to %s. %s",

    cmd_cant_be_run_server_console = "This command cannot be run from the server console.",

    -- Animations
    custom_animation = "Custom animation!",
    bow = "Bow",
    sexy_dance = "Sexy dance",
    follow_me = "Follow me!",
    laugh = "Laugh",
    lion_pose = "Lion pose",
    nonverbal_no = "Non-verbal no",
    thumbs_up = "Thumbs up",
    wave = "Wave",
    dance = "Dance",

    x_options = "%s options",
    sell_x = "Sell %s",
    set_x_title = "Set %s title",
    set_x_title_long = "Set the title of the %s you are looking at.",
    jobs = "Jobs",
    buy_x = "Buy %s",
	
    drop_money = "Drop money",
}
DarkRP.addLanguage("en", my_language)