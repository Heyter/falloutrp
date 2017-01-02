
//Client
net.Receive("loadInventory", function()
	local inventory = net.ReadTable()
	local equipped = net.ReadTable()
	
	LocalPlayer().inventory = inventory
	LocalPlayer().equipped = equipped
end)