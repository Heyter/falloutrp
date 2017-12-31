
//Server
util.AddNetworkString("equipItem")
util.AddNetworkString("unequipItem")

util.AddNetworkString("updateEquipment")

local meta = FindMetaTable("Player")

function meta:depleteEquipped(item)
	local itemMeta = findItem(item.classid)
	local type = classidToStringType(item.classid)

	self.equipped[type][slot] = nil

	if isWeapon(item.classid) then
		//Strip the weapon from the player
		self:StripWeapon(itemMeta:getEntity())
	end
end

function meta:equipItem(uniqueid, classid, quantity)
	if isWeapon(classid) then
		self:equipWeapon(uniqueid, classid)
	elseif isApparel(classid) then
		self:equipApparel(uniqueid, classid)
	elseif isAmmo(classid) then
		self:equipAmmo(uniqueid, classid, quantity)
	end
end

function meta:unequipItem(uniqueid, classid)
	if isWeapon(classid) then
		self:unequipWeapon(uniqueid, classid)
	elseif isApparel(classid) then
		self:unequipApparel(uniqueid, classid)
	end
end

function meta:updateClientEquipment()
	net.Start("updateEquipment")
		net.WriteTable(self.equipped)
		net.WriteEntity(self)
	net.Broadcast()
end

net.Receive("equipItem", function(len, ply)
	local itemId = net.ReadInt(32)
	local classid = net.ReadInt(16)
	local quantity = net.ReadInt(16)

	ply:equipItem(itemId, classid, quantity)
end)

net.Receive("unequipItem", function(len, ply)
	local itemId = net.ReadInt(32)
	local classid = net.ReadInt(16)

	ply:unequipItem(itemId, classid)
end)
