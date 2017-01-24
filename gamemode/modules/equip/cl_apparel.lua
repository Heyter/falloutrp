
// Client

net.Receive("equipApparel", function()
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	
	local apparelSlot = getApparelSlot(classid)
	
	LocalPlayer().inventory.apparel[uniqueid]["equipped"] = true
	LocalPlayer().equipped.apparel[apparelSlot] = LocalPlayer().inventory.apparel[uniqueid]
	
	openPepboyMiddle()
end)

net.Receive("unequipApparel", function()
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	
	local apparelSlot = getApparelSlot(classid)
	
	LocalPlayer().inventory.apparel[uniqueid].equipped = false
	LocalPlayer().equipped.apparel[apparelSlot] = nil
	
	openPepboyMiddle()
end)