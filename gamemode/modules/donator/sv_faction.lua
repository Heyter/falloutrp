
util.AddNetworkString("updateNameChanges")

local meta = FindMetaTable("Player")

function meta:addFactionChange()
	self.playerData.factionchanges = self:getFactionChanges() + 1
	
	local changes = self:getFactionChanges()
	
	MySQLite.query("UDPATE SET factionchanges = " ..changes .." WHERE steamid = '" ..self:SteamID() .."'")	
		
	net.Start("updateFactionChanges")
		net.WriteInt(changes, 8)
	net.Send(self)
end