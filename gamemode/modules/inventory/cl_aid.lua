
net.Receive("pickUpAid", function()
	local uniqueid = net.ReadInt(32)
	local aid = net.ReadTable()
	
	LocalPlayer().inventory.aid[uniqueid] = aid
end)