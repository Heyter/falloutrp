
//Client
local meta = FindMetaTable("Player")

function meta:dropItem(uniqueId, classid)
	local itemType = classidToStringType(classid)
	self:setVguiDelay()
	print(uniqueId, classid)
	net.Start("dropItem")
		net.WriteInt(uniqueId, 32)
		net.WriteInt(classid, 16)
	net.SendToServer()
	
	// Remove the item from clienside, it's not guranteed it's removed from server though
	self.inventory[itemType][uniqueId] = nil
end

function meta:equipItem(uniqueId, classid)
	local itemType = classidToStringType(classid)
	
	self:setVguiDelay()
	
	net.Start("equipItem")
		net.WriteInt(uniqueId, 32)
		net.WriteInt(classid, 16)
	net.SendToServer()
	
	// Remove the item from clienside, it's not guranteed it's removed from server though
	self.inventory[itemType][uniqueId]["equipped"] = true
end

function meta:unequipItem(uniqueId, classid)
	local itemType = classidToStringType(classid)
	
	self:setVguiDelay()
	
	net.Start("unequipItem")
		net.WriteInt(uniqueId, 32)
		net.WriteInt(classid, 16)
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