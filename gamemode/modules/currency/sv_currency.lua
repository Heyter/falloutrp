
util.AddNetworkString("addCaps")

local meta = FindMetaTable("Player")

function meta:addCaps(amount)
	self.playerData.bottlecaps = self:getCaps() + amount

	net.Start("addCaps")
		net.WriteInt(self:getCaps(), 8)
	net.Send(self)
end