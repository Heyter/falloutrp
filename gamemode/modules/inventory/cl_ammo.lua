
net.Receive("pickUpAmmo", function()
	local uniqueid = net.ReadInt(32)
	local ammo = net.ReadTable()
	
	LocalPlayer().inventory.ammo[uniqueid] = ammo
end)