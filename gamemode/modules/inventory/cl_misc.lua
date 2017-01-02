
net.Receive("pickUpMisc", function()
	local uniqueId = net.ReadInt(8)
	local misc = net.ReadTable()
	
	LocalPlayer().inventory.misc[uniqueId] = misc
end)