
util.AddNetworkString("teamSelection")
util.AddNetworkString("nameValidation")
util.AddNetworkString("createCharacter")

local meta = FindMetaTable("Player")

function meta:selectTeam()
	net.Start("teamSelection")
	
	net.Send(self)
end

local function createCharacter(ply, name, teamId)
	print(ply, name, teamId)
	
	net.Start("createCharacter")
		// Don't need to send anything, just close the menu
	net.Send(ply)
	
	// Insert the new player into SQL
	MySQLite.query("INSERT INTO playerdata (steamid, name, bottlecaps, faction, experience, skillpoints, strength, perception, medicine, repair, crafting, science, sneak, farming) VALUES ('" ..ply:SteamID() .."', '" ..name .."', 0, " ..teamId ..", 0, 0, 0, 1, 1, 1, 1, 1, 1, 1)")
	
	ply:SetTeam(teamId)
end

local function hasInvalidChars(name)
	for k, char in pairs(NAME_INVALID) do
		local start, finish = string.find(name, char, 1, true)
		if start then
			return char
		end
	end
end

local function validateName(ply, name, teamId)
	local errorId
	local extra = "" // Extra info about the validation that needs to be sent back, ie: which char is bad
	
	if !name or #name < NAME_MIN then
		// Error with not enough characters
		errorId = 1
		return
	elseif #name > NAME_MAX then
		// Error with too many characters
		errorId = 2
		return
	end
	
	local badChar = hasInvalidChars(name)
	if badChar then
		// Error with bad character
		errorId = 3
		extra = badChar
		return
	else
		MySQLite.query("SELECT * FROM playerdata WHERE 'name' = '" ..name .."'", function(results)
			if results then
				errorId = 0
				net.Start("nameValidation")
					net.WriteInt(errorId, 8)
					net.WriteString(name)
					net.WriteString(extra)
				net.Send(ply)
			else
				createCharacter(ply, name, teamId)
			end
		end)
	end
	
	if errorId then
		net.Start("nameValidation")
			net.WriteInt(teamId, 8)
			net.WriteInt(errorId, 8)
			net.WriteString(name)
			net.WriteString(extra)
		net.Send(ply)
	end
end

net.Receive("nameValidation", function(len, ply)
	local name = net.ReadString()
	local teamId = net.ReadInt(8)

	validateName(ply, name, teamId)
end)