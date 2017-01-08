
net.Receive("pickUpApparel", function()
	local uniqueid = net.ReadInt(32)
	local apparel = net.ReadTable()
	
	LocalPlayer().inventory.apparel[uniqueid] = apparel
end)