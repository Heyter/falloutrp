
//Client
net.Receive("loadInventory", function()
	local inventory = net.ReadTable()
	local equipped = net.ReadTable()
	
	LocalPlayer().inventory = inventory
	LocalPlayer().equipped = equipped
end)

net.Receive("depleteInventoryItem", function()
	local type = net.ReadString()
	local uniqueid = net.ReadInt(32)
	local deletedItem = net.ReadBool()
	local quantity = net.ReadInt(16)
	
	if !deletedItem then
		LocalPlayer().inventory[type][uniqueid]["quantity"] = quantity
	else
		LocalPlayer().inventory[type][uniqueid] = nil
	end
end)
