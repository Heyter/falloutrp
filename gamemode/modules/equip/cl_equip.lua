
//Client
local meta = FindMetaTable("Player")

net.Receive("updateEquipment", function(len, ply)
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