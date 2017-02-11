
//Client
local meta = FindMetaTable("Player")

// Called when a player drops their whole inventory (they die)
net.Receive("clearEquipped", function()
	local ply = net.ReadEntity()
	
	ply.equipped = {
		weapons = {},
		apparel = {}
	}
end)

net.Receive("updateEquipment", function()
	local equipped = net.ReadTable()
	local ent = net.ReadEntity()
	
	ent.equipped = equipped
end)

function meta:equipItem(uniqueid, classid, quantity)
	self:setVguiDelay()
	
	net.Start("equipItem")
		net.WriteInt(uniqueid, 32)
		net.WriteInt(classid, 16)
		net.WriteInt(quantity, 16)
	net.SendToServer()
end

function meta:unequipItem(uniqueid, classid)
	local itemType = classidToStringType(classid)
	
	self:setVguiDelay()
	
	net.Start("unequipItem")
		net.WriteInt(uniqueid, 32)
		net.WriteInt(classid, 16)
	net.SendToServer()
end