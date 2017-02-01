
// These net messages are broadcasted because all players need to know what a player has equipped (ie: to calculate max health)

net.Receive("equipApparel", function()
	local uniqueid = net.ReadInt(32)
	
	LocalPlayer().inventory.apparel[uniqueid]["equipped"] = true
	
	openPepboyMiddle()
end)

net.Receive("unequipApparel", function()
	local uniqueid = net.ReadInt(32)
	
	LocalPlayer().inventory.apparel[uniqueid].equipped = false
	
	openPepboyMiddle()
end)