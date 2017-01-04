
// Client

net.Receive("equipWeapon", function()
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	
	local weaponType = getWeaponType(classid)
	
	LocalPlayer().inventory.weapons[uniqueid]["equipped"] = true
	LocalPlayer().equipped.weapons[weaponType] = LocalPlayer().inventory.weapons[uniqueid]
	
	openPepboyMiddle(1)
end)

net.Receive("unequipWeapon", function()
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	
	local weaponType = getWeaponType(classid)
	
	LocalPlayer().inventory.weapons[uniqueid].equipped = false
	LocalPlayer().equipped.weapons[weaponType] = nil
	
	openPepboyMiddle(1)
end)