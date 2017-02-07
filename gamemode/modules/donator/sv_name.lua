
util.AddNetworkString("updateNameChanges")

local meta = FindMetaTable("Player")

function meta:addNameChange()
	self.playerData.namechanges = self:getNameChanges() + 1
	
	local changes = self:getNameChanges()
	
	MySQLite.query("UDPATE SET namechanges = " ..changes .." WHERE steamid = '" ..self:SteamID() .."'")	
		
	net.Start("updateNameChanges")
		net.WriteInt(changes, 8)
	net.Send(self)
end