
util.AddNetworkString("addCaps")

local meta = FindMetaTable("Player")

function meta:addCaps(amount)
	self.playerData.bottlecaps = self:getCaps() + amount

	net.Start("addCaps")
		net.WriteInt(self:getCaps(), 32)
	net.Send(self)
	
	MySQLite.query("UPDATE playerdata SET bottlecaps = " ..self:getCaps() .." WHERE steamid = '" ..self:SteamID() .."'")
end