
net.Receive("pickUpWeapon", function()
	local uniqueId = net.ReadInt(32)
	local weapon = net.ReadTable()
	
	LocalPlayer().inventory.weapons[uniqueId] = weapon
end)