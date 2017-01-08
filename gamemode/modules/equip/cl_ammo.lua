
net.Receive("equipAmmo", function()
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	local quantity = net.ReadInt(16)
	
	if quantity == LocalPlayer().inventory.ammo[uniqueid]["quantity"] then
		LocalPlayer().inventory.ammo[uniqueid] = nil
	else
		LocalPlayer().inventory.ammo[uniqueid]["quantity"] = LocalPlayer().inventory.ammo[uniqueid]["quantity"] - quantity
	end
	
	openPepboyMiddle()
end)
