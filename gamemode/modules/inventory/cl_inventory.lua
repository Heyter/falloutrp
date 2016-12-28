
//Client
net.Receive("loadInventory", function()
	local inventory = net.ReadTable()
	
	LocalPlayer().inventory = inventory
end)