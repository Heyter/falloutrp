
// Client

net.Receive("equipApparel", function()
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	
	local apparelType = getApparelType(classid)
	
	LocalPlayer().inventory.apparel[uniqueid]["equipped"] = true
	LocalPlayer().equipped.apparel[apparelType] = LocalPlayer().inventory.apparel[uniqueid]
	
	openPepboyMiddle()
end)

net.Receive("unequipApparel", function()
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	
	local apparelType = getApparelType(classid)
	
	LocalPlayer().inventory.apparel[uniqueid].equipped = false
	LocalPlayer().equipped.apparel[apparelType] = nil
	
	openPepboyMiddle()
end)