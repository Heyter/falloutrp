
util.AddNetworkString("openTokenShop")

local meta = FindMetaTable("Player")

function meta:openTokenShop()
	net.Start("openTokenShop")
	
	net.Send(self)
end