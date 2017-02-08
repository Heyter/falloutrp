
net.Receive("pickUpWeapon", function()
	local uniqueid = net.ReadInt(32)
	local weapon = net.ReadTable()
	
	LocalPlayer().inventory.weapons[uniqueid] = weapon
end)