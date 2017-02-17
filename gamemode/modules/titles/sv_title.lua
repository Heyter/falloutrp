
// Token shop
util.AddNetworkString("updateTitleCreations")
// Functional
util.AddNetworkString("updateTitle")
util.AddNetworkString("updateTitles")
util.AddNetworkString("createTitle")
util.AddNetworkString("equipTitle")
util.AddNetworkString("unequipTitle")

local meta = FindMetaTable("Player")

// Get data from 'titles' for specific player
function meta:loadTitles()
	self.titles = {}

	MySQLite.query("SELECT * FROM titles WHERE steamid = '" ..self:SteamID() .."'", function(results)
		// The player has no titles
		if results then
			for k,v in pairs(results) do
				local tbl = {title = v.title, equipped = v.equipped, prefix = v.prefix}
				
				table.insert(self.titles, tbl)
				
				// Remember whether or not the title is currently equipped
				if tobool(v.equipped) then
					self:equipTitle(tbl)
				end
			end
		end
	end)
end

function meta:addTitleCreation()
	self.playerData.titlecreations = self:getTitleCreations() + 1
	
	local creations = self:getTitleCreations()
	
	MySQLite.query("UPDATE playerdata SET titlecreations = " ..creations .." WHERE steamid = '" ..self:SteamID() .."'")
	
	net.Start("updateTitleCreations")
		net.WriteInt(creations, 8)
	net.Send(self)
end

function meta:removeTitleCreation()
	self.playerData.titlecreations = self:getTitleCreations() - 1
	
	local creations = self:getTitleCreations()
	
	MySQLite.query("UPDATE playerdata SET titlecreations = " ..creations .." WHERE steamid = '" ..self:SteamID() .."'")
	
	net.Start("updateTitleCreations")
		net.WriteInt(creations, 8)
	net.Send(self)
end

function meta:equipTitle(title)
	// Unequip currently equipped title
	if self.title and self.title.title then
		for k,v in pairs(self:getTitles()) do
			if v.title == self.title.title then
				v.equipped = 0
				break
			end
		end
	end

	title.equipped = 1
	self.title = title
	
	MySQLite.query("UPDATE titles SET equipped = 1 WHERE steamid = '" ..self:SteamID() .."' and title = '" ..title.title .."'")
	
	self:updateTitle() // Broadcast update to all players
	self:updateTitles() // Update equipped for just this player
end

function meta:unequipTitle(title)
	title.equipped = 0
	self.title = {}
	
	MySQLite.query("UPDATE titles SET equipped = 0 WHERE steamid = '" ..self:SteamID() .."' and title = '" ..title.title .."'")
	
	self:updateTitle() // Broadcast update to all players
	self:updateTitles() // Update equipped for just this player
end

local function isValid(title)
	if #title < TITLE_MIN then
		return false, "Title must be atleast " ..TITLE_MIN .." characters."
	elseif #title > TITLE_MAX then
		return false, "Title must be less than " ..TITLE_MAX .." character."
	end
	
	for i = 1, #title do
		if table.HasValue(TITLE_INVALID, title[i]) then
			return false, "Title cannot have the character " ..title[i]
		end
	end
	
	return true
end

function meta:createTitle(title, prefix)
	// Check if title is valid
	local valid, errorMessage = isValid(title)
	if !valid then
		self:notify(errorMessage, NOTIFY_ERROR)
		return
	end
	
	// Remove title creation token
	self:removeTitleCreation()
	
	// Add title to player
	local tbl = {
		["title"] = title,
		["equipped"] = false,
		["prefix"] = prefix,
	}
	
	table.insert(self.titles, tbl)
	MySQLite.query("INSERT INTO titles (steamid, title, prefix) VALUES ('" ..self:SteamID() .."', '" ..title .."', " ..util.boolToNumber(prefix) ..")")
	
	self:updateTitles()
	
	// Notify player
	self:notify("You have created the title: " ..title, NOTIFY_GENERIC, 5)
	self:notify("You can find and equip it via your pipboy.", NOTIFY_GENERIC, 5)
end

function meta:updateTitles()
	net.Start("updateTitles")
		net.WriteTable(self:getTitles())
	net.Send(self)
end

function meta:updateTitle()
	net.Start("updateTitle")
		net.WriteEntity(self)
		net.WriteTable(self:getTitle())
	net.Broadcast()
end

net.Receive("createTitle", function(len, ply)
	local title = net.ReadString()
	local prefix = net.ReadBool()
	
	ply:createTitle(title, prefix)
end)

net.Receive("equipTitle", function(len, ply)
	local title = net.ReadString()
	
	for k,v in pairs(ply:getTitles()) do
		if v.title == title then
			ply:equipTitle(v)
			return
		end
	end
end)

net.Receive("unequipTitle", function(len, ply)
	local title = net.ReadString()
	
	for k,v in pairs(ply:getTitles()) do
		if v.title == title then
			ply:unequipTitle(v)
			return
		end
	end
end)