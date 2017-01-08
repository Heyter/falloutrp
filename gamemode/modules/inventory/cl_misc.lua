
net.Receive("pickUpMisc", function()
	local uniqueid = net.ReadInt(32)
	local misc = net.ReadTable()
	
	LocalPlayer().inventory.misc[uniqueid] = misc
end)