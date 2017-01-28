
//Client
net.Receive("loadInventory", function()
	local inventory = net.ReadTable()
	
	LocalPlayer().inventory = inventory
end)

net.Receive("loadEquipped", function()
	local ply = net.ReadEntity()
	local equipped = net.ReadTable()
	
	ply.equipped = equipped
	
	
	// We have finished loading playerData, inventory, and equipped. Now send it to all clients
	net.Start("loadPlayerData")
	
	net.SendToServer()
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
