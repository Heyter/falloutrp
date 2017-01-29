
util.AddNetworkString("teamSelection")
util.AddNetworkString("registrationValidation")
util.AddNetworkString("createCharacter")
util.AddNetworkString("sendClientside")

local meta = FindMetaTable("Player")

function meta:selectTeam()
	net.Start("teamSelection")
	
	net.Send(self)
end

local function giveStartingWeapons(ply)
	ply:pickUpItem(createItem(1015, 1, true), 1)
	ply:pickUpItem(createItem(1044, 1, true), 1)
	ply:pickUpItem(createItem(3017, 1, true), 20)
	ply:pickUpItem(createItem(5014, 1, true), 10)
	ply:pickUpItem(createItem(5033, 1, true), 10)
end

local function createCharacter(ply, name, teamId, values)
	
	// Insert the new player into SQL
	MySQLite.query("INSERT INTO playerdata (steamid, name, bottlecaps, faction, experience, skillpoints, strength, perception, endurance, charisma, intelligence, agility, luck) VALUES ('" ..ply:SteamID() .."', '" ..name .."', 0, " ..teamId ..", 0, " ..0 ..", " ..values[1] ..", " ..values[2] ..", " ..values[3] ..", " ..values[4] ..", " ..values[5] ..", " ..values[6] ..", " ..values[7] ..")")
	
	ply.playerData = {
		["steamid"] = steamid,
		["name"] = name,
		["bottlecaps"] = 0,
		["faction"] = teamId,
		["experience"] = 0,
		["skillpoints"] = 0,
		["strength"] = values[1],
		["perception"] = values[2],
		["endurance"] = values[3],
		["charisma"] = values[4],
		["intelligence"] = values[5],
		["agility"] = values[6],
		["luck"] = values[7],
		["barter"] = 1,
		["energyweapons"] = 1,
		["explosives"] = 1,
		["guns"] = 1,
		["lockpick"] = 1,
		["medicine"] = 1,
		["meleeweapons"] = 1,
		["repair"] = 1,
		["science"] = 1,
		["sneak"] = 1,
		["speech"] = 1,
		["survival"] = 1,
		["unarmed"] = 1
	}
	ply.inventory = {
		weapons = {},
		apparel = {},
		aid = {},
		misc = {},
		ammo = {}
	}
	ply.equipped = {
		weapons = {},
		apparel = {}
	}
	
	net.Start("createCharacter")
		// Don't need to send anything, just close the menu
		net.WriteTable(ply.playerData)
	net.Send(ply)
	
	timer.Simple(5, function()
		giveStartingWeapons(ply)
	end)
end

local function hasInvalidChars(name)
	if name then
		for k, char in pairs(NAME_INVALID) do
			local start, finish = string.find(name, char, 1, true)
			if start then
				return char
			end
		end
	end
end

local function usedAllPoints(values)
	local total = 0

	for k,v in pairs(values) do
		total = total + v
	end
	
	return total == REGISTRATION_POINTS + #SPECIAL // Number of given points plus 1 extra point each for each skill
end

local function validateRegistration(ply, name, teamId, values)
	local errorId
	local extra = "" // Extra info about the validation that needs to be sent back, ie: which char is bad
	local badChar = hasInvalidChars(name)
	
	if !name or #name < NAME_MIN then
		// Error with not enough characters
		errorId = 1
	elseif #name > NAME_MAX then
		// Error with too many characters
		errorId = 2
	elseif badChar then
		// Error with bad character
		errorId = 3
		extra = badChar
	elseif !usedAllPoints(values) then
		errorId = 4
	else
		MySQLite.query("SELECT * FROM playerdata WHERE name = '" ..name .."'", function(results)
			if results then // There already exists a player with this name
				errorId = 5
				net.Start("registrationValidation")
					net.WriteInt(errorId, 8)
					net.WriteString(name)
					net.WriteString(extra)
				net.Send(ply)
			else
				createCharacter(ply, name, teamId, values)
			end
		end)
	end
	
	if errorId then
		net.Start("registrationValidation")
			net.WriteInt(errorId, 8)
			net.WriteString(name)
			net.WriteString(extra)
		net.Send(ply)
	end
end

net.Receive("registrationValidation", function(len, ply)
	local name = net.ReadString()
	local teamId = net.ReadInt(8)
	local values = net.ReadTable()

	validateRegistration(ply, name, teamId, values)
end)

net.Receive("createCharacter", function(len, ply)
	ply:postLoadPlayer()
end)