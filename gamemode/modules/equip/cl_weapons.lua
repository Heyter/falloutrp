
net.Receive("equipWeapon", function()
	local uniqueid = net.ReadInt(32)
	
	LocalPlayer().inventory.weapons[uniqueid]["equipped"] = true
	
	openPepboyMiddle()
end)

net.Receive("unequipWeapon", function()
	local uniqueid = net.ReadInt(32)
	
	LocalPlayer().inventory.weapons[uniqueid].equipped = false
	
	openPepboyMiddle()
end)