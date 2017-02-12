--[[---------------------------------------------------------
Talking
 ---------------------------------------------------------]]
local function PM(ply, args)
    local namepos = string.find(args, " ")
    if not namepos then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
        return ""
    end

    local name = string.sub(args, 1, namepos - 1)
    local msg = string.sub(args, namepos + 1)

    if msg == "" then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
        return ""
    end

    local target = DarkRP.findPlayer(name)

    if target then
        local col = team.GetColor(ply:Team())
        DarkRP.talkToPerson(target, col, "(PM) " .. ply:getName(), Color(255, 255, 255, 255), msg, ply)
        DarkRP.talkToPerson(ply, col, "(PM) " .. ply:getName(), Color(255, 255, 255, 255), msg, ply)
    else
		ply:notify(DarkRP.getPhrase("could_not_find", tostring(name)), NOTIFY_ERROR)
    end

    return ""
end
DarkRP.defineChatCommand("pm", PM, 1.5)

local function Whisper(ply, args)
    local DoSay = function(text)
        if text == "" then
			ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
            return ""
        end
        DarkRP.talkToRange(ply, "(" .. DarkRP.getPhrase("whisper") .. ") " .. ply:getName(), text, 90)
    end
    return args, DoSay
end
DarkRP.defineChatCommand("w", Whisper, 1.5)

local function Yell(ply, args)
    local DoSay = function(text)
        if text == "" then
			ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
            return ""
        end
        DarkRP.talkToRange(ply, "(" .. DarkRP.getPhrase("yell") .. ") " .. ply:getName(), text, 550)
    end
    return args, DoSay
end
DarkRP.defineChatCommand("y", Yell, 1.5)

local function Me(ply, args)
    if args == "" then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
        return ""
    end

    local DoSay = function(text)
        if text == "" then
			ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
            return ""
        end
        if GAMEMODE.Config.alltalk then
            for _, target in pairs(player.GetAll()) do
                DarkRP.talkToPerson(target, team.GetColor(ply:Team()), ply:getName() .. " " .. text)
            end
        else
            DarkRP.talkToRange(ply, ply:getName() .. " " .. text, "", 250)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("me", Me, 1.5)

local function OOC(ply, args)

    local DoSay = function(text)
        if text == "" then
			ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
            return ""
        end
        local col = team.GetColor(ply:Team())
        local col2 = Color(255,255,255,255)
        if not ply:Alive() then
            col2 = Color(255,200,200,255)
            col = col2
        end
        for k,v in pairs(player.GetAll()) do
            DarkRP.talkToPerson(v, col, "(" .. DarkRP.getPhrase("ooc") .. ") " .. ply:Name(), col2, text, ply)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("/", OOC, true, 1.5)
DarkRP.defineChatCommand("a", OOC, true, 1.5)
DarkRP.defineChatCommand("ooc", OOC, true, 1.5)

local function MayorBroadcast(ply, args)
    if args == "" then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
        return ""
    end
    if not RPExtraTeams[ply:Team()] or not RPExtraTeams[ply:Team()].mayor then DarkRP.notify(ply, 1, 4, "You have to be mayor") return "" end
    local DoSay = function(text)
        if text == "" then
			ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
            return
        end
        for k,v in pairs(player.GetAll()) do
            local col = team.GetColor(ply:Team())
            DarkRP.talkToPerson(v, col, DarkRP.getPhrase("broadcast") .. " " .. ply:getName(), Color(170, 0, 0, 255), text, ply)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("broadcast", MayorBroadcast, 1.5)

local function SetRadioChannel(ply,args)
    if tonumber(args) == nil or tonumber(args) < 0 or tonumber(args) > 100 then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", "0<channel<100"), NOTIFY_ERROR)
        return ""
    end
	ply:notify(DarkRP.getPhrase("channel_set_to_x", args), NOTIFY_ERROR)
	
    ply.RadioChannel = tonumber(args)
    return ""
end
DarkRP.defineChatCommand("channel", SetRadioChannel)

local function SayThroughRadio(ply,args)
    if not ply.RadioChannel then ply.RadioChannel = 1 end
    if not args or args == "" then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
        return ""
    end
    local DoSay = function(text)
        if text == "" then
			ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
            return
        end
        for k,v in pairs(player.GetAll()) do
            if v.RadioChannel == ply.RadioChannel then
                DarkRP.talkToPerson(v, Color(180,180,180,255), DarkRP.getPhrase("radio_x", ply.RadioChannel), Color(180,180,180,255), text, ply)
            end
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("radio", SayThroughRadio, 1.5)

local function GroupMsg(ply, args)
    local DoSay = function(text)
        if text == "" then
			ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""), NOTIFY_ERROR)
            return
        end

        local col = team.GetColor(ply:Team())

        for _, v in pairs(team.GetPlayers(ply:Team())) do
			DarkRP.talkToPerson(v, col, DarkRP.getPhrase("group") .. " " .. ply:getName(), Color(255,255,255,255), text, ply)
			break
        end

    end
    return args, DoSay
end
DarkRP.defineChatCommand("g", GroupMsg, 0)
