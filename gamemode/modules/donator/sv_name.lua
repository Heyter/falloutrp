// Tokens
util.AddNetworkString("updateNameChanges")
// Functional name change
util.AddNetworkString("updateNameChange")
util.AddNetworkString("validateNameChange")

local meta = FindMetaTable("Player")

function meta:addNameChange()
	self.playerData.namechanges = self:getNameChanges() + 1
	
	local changes = self:getNameChanges()
	
	MySQLite.query("UPDATE playerdata SET namechanges = " ..changes .." WHERE steamid = '" ..self:SteamID() .."'")	
		
	net.Start("updateNameChanges")
		net.WriteInt(changes, 8)
	net.Send(self)
end

function meta:removeNameChange()
	self.playerData.namechanges = self:getNameChanges() - 1
	
	local changes = self:getNameChanges()
	
	MySQLite.query("UPDATE playerdata SET namechanges = " ..changes .." WHERE steamid = '" ..self:SteamID() .."'")	
	
	net.Start("updateNameChanges")
		net.WriteInt(changes, 8)
	net.Send(self)
end

function meta:changeName(name)
	// Remove a name change token
	self:removeNameChange()

	// Update in lua, broadcast to all
	self.playerData.name = name
	net.Start("updateNameChange")
		net.WriteEntity(self)
		net.WriteString(name)
	net.Broadcast()
	
	// Update in MySQL
	MySQLite.query("UPDATE playerdata SET name = '" ..name .."' WHERE steamid = '" ..self:SteamID() .."'")
end

local function validateNameChange(ply, name)
	if !name or (#name < NAME_MIN) then
		// Error with not enough characters
		ply:notify("Name must be atleast " ..NAME_MIN .." characters.", NOTIFY_ERROR, 3, true)
	elseif #name > NAME_MAX then
		// Error with too many characters
		ply:notify("Name must not exceed " ..NAME_MAX .." characters.", NOTIFY_ERROR, 3, true)
	elseif badChar then
		// Error with bad character
		ply:notify("Name must not contain the following: " ..badChar, NOTIFY_ERROR, 3, true)
	else
		MySQLite.query("SELECT * FROM playerdata WHERE name = '" ..name .."'", function(results)
			if results then // There already exists a player with this name
				ply:notify("Player with that name already exists.", NOTIFY_ERROR, 3, true)
			else
				ply:changeName(name)
			end
		end)
	end
end

net.Receive("validateNameChange", function(len, ply)
	local name = net.ReadString()
	
	validateNameChange(ply, name)
end)