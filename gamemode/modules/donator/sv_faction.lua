
// Token shop
util.AddNetworkString("updateFactionChanges")
// Functional
util.AddNetworkString("factionChange")

local meta = FindMetaTable("Player")

function meta:addFactionChange()
	self.playerData.factionchanges = self:getFactionChanges() + 1
	
	local changes = self:getFactionChanges()
	
	MySQLite.query("UPDATE playerdata SET factionchanges = " ..changes .." WHERE steamid = '" ..self:SteamID() .."'")	
		
	net.Start("updateFactionChanges")
		net.WriteInt(changes, 8)
	net.Send(self)
end

function meta:removeFactionChange()
	self.playerData.factionchanges = self:getFactionChanges() - 1
	
	local changes = self:getFactionChanges()
	
	MySQLite.query("UPDATE playerdata SET factionchanges = " ..changes .." WHERE steamid = '" ..self:SteamID() .."'")	
	
	self:notify("You have " ..changes .." faction changes remaining.", NOTIFY_GENERIC)
	
	// No need to update client side because we reload players when they change faction anyway
end

function meta:changeFaction(id)
	MySQLite.query("UPDATE playerdata SET faction = " ..id .." WHERE steamid = '" ..self:SteamID() .."'")
	
	self:notify("You have changed your faction to " ..team.GetName(id), NOTIFY_GENERIC)
	
	// Reload the player
	timer.Simple(2, function()
		self:load()
	end)
end

net.Receive("factionChange", function(len, ply)
	local team = net.ReadInt(8)
	
	ply:changeFaction(team)
	ply:removeFactionChange()
end)