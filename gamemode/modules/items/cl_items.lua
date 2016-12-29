
//Client
local meta = FindMetaTable("Player")

function meta:dropItem(uniqueId, itemType)
	self:setVguiDelay()
	
	net.Start("dropItem")
		net.WriteInt(uniqueId, 8)
		net.WriteString(itemType)
	net.SendToServer()
	
	// Remove the item from clienside, it's not guranteed it's removed from server though
	self.inventory[itemType][uniqueId] = nil
end

function meta:equipItem(uniqueId, itemType)
	self:setVguiDelay()
	
	net.Start("equipItem")
		net.WriteInt(uniqueId, 8)
		net.WriteString(itemType)
	net.SendToServer()
	
	// Remove the item from clienside, it's not guranteed it's removed from server though
	self.inventory[itemType][uniqueId]["equipped"] = true
end

function meta:unequipItem(uniqueId, itemType)
	self:setVguiDelay()
	
	net.Start("unequipItem")
		net.WriteInt(uniqueId, 8)
		net.WriteString(itemType)
	net.SendToServer()
	
	// Remove the item from clienside, it's not guranteed it's removed from server though
	self.inventory[itemType][uniqueId]["equipped"] = false
end

net.Receive("dropItem", function()
	//Item was dropped, reenable vgui
	LocalPlayer():removeVguiDelay()
end)

net.Receive("equipItem", function()
	//Item was dropped, reenable vgui
	LocalPlayer():removeVguiDelay()
end)

net.Receive("unequipItem", function()
	//Item was dropped, reenable vgui
	LocalPlayer():removeVguiDelay()
end)