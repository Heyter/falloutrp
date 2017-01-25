
// These net messages are broadcasted because all players need to know what a player has equipped (ie: to calculate max health)

net.Receive("equipApparel", function()
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	local ply = net.ReadEntity()
	
	local apparelSlot = getApparelSlot(classid)
	
	ply.inventory.apparel[uniqueid]["equipped"] = true
	ply.equipped.apparel[apparelSlot] = LocalPlayer().inventory.apparel[uniqueid]
	
	openPepboyMiddle()
end)

net.Receive("unequipApparel", function()
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	local ply = net.ReadEntity()
	
	local apparelSlot = getApparelSlot(classid)
	
	ply.inventory.apparel[uniqueid].equipped = false
	ply.equipped.apparel[apparelSlot] = nil
	
	openPepboyMiddle()
end)