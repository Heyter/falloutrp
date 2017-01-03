
// Client

net.Receive("unequipWeapon", function()
	local uniqueid = net.ReadInt(8)
	local classid = net.ReadInt(8)
	
	local weaponType = getWeaponType(classid)
	
	LocalPlayer().equipped[weaponType] = nil
	
	openPepboyMiddle(1)
end)