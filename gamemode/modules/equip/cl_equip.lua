
//Client
local meta = FindMetaTable("Player")

net.Receive("updateEquipment", function(len, ply)
	local equipped = net.ReadTable()
	local ent = net.ReadEntity()
	
	ent.equipped = equipped
	
	// Reopen the pipboy for the player who just had their equipment change
	if LocalPlayer() == ent then
		openPepboyMiddle()
	end
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