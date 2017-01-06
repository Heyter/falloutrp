
//Client
local meta = FindMetaTable("Player")

function meta:dropItem(uniqueId, classid, quantity)
	local itemType = classidToStringType(classid)
	self:setVguiDelay()

	net.Start("dropItem")
		net.WriteInt(uniqueId, 32)
		net.WriteInt(classid, 16)
		if quantity then
			net.WriteInt(quantity, 16)
		end
	net.SendToServer()
	
	// Remove the item from clienside, it's not guranteed it's removed from server though
	self.inventory[itemType][uniqueId] = nil
end

function meta:equipItem(uniqueId, classid)
	self:setVguiDelay()
	
	net.Start("equipItem")
		net.WriteInt(uniqueId, 32)
		net.WriteInt(classid, 16)
	net.SendToServer()
end

function meta:unequipItem(uniqueId, classid)
	local itemType = classidToStringType(classid)
	
	self:setVguiDelay()
	
	net.Start("unequipItem")
		net.WriteInt(uniqueId, 32)
		net.WriteInt(classid, 16)
	net.SendToServer()
end

net.Receive("dropItem", function()
	local itemType = net.ReadString()
	local uniqueid = net.ReadInt(16)
	local quantity = net.ReadInt(16)
	
	if util.positive(quantity) then
		LocalPlayer().inventory[itemType][uniqueId].quantity = quantity
	else
		LocalPlayer().inventory[itemType][uniqueid] = nil
	end

	//Item was dropped, reenable vgui
	LocalPlayer():removeVguiDelay()
	
	openPepboyMiddle()
end)

/*
	net.Receive("equipItem", function()
		//Item was dropped, reenable vgui
		LocalPlayer():removeVguiDelay()
	end)

	net.Receive("unequipItem", function()
		//Item was dropped, reenable vgui
		LocalPlayer():removeVguiDelay()
	end)
*/