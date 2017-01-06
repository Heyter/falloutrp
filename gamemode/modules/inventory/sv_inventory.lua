
util.AddNetworkString("loadInventory")
util.AddNetworkString("dropItem")
util.AddNetworkString("equipItem")
util.AddNetworkString("unequipItem")

local meta = FindMetaTable("Player")

function meta:loadInventoryCount()
	self.loadInvCount = self.loadInvCount + 1
	
	if self.loadInvCount == 5 then // weapons, apparel, aid, misc, and ammo were all loaded
		self:sendInventory()
	end
end

// Get data from all item tables for specific player
function meta:loadInventory()
	self.loadInvCount = 0
	
	self.inventory = {
		weapons = {},
		apparel = {},
		aid = {},
		misc = {},
		ammo = {}
	}
	
	self.equipped = {
		weapons = {},
		apparel = {}
	}
	
	self:loadInvWeapons()
	self:loadInvApparel()
	self:loadInvAid()
	self:loadInvMisc()
	self:loadInvAmmo()
end

// Run this in the last query you run when loading the inventory
function meta:sendInventory()
	net.Start("loadInventory")
		net.WriteTable(self.inventory)
		net.WriteTable(self.equipped)
	net.Send(self)
end

function meta:pickUpItem(item, quantity)
	if isWeapon(item.classid) then
		self:pickUpWeapon(item)
	elseif isApparel(item.classid) then
	
	elseif isAmmo(item.classid) then
	
	elseif isAid(item.classid) then
	
	elseif isMisc(item.classid) then
		self:pickUpMisc(item, quantity)
	end
end

function meta:dropItem(uniqueid, classid, quantity)
	local itemType = classidToStringType(classid)

	// Store the item temp so we can drop it
	local item = self.inventory[itemType][uniqueid]
		
	print(quantity)
	print(util.positive(quantity))
	print(item.quantity)
	print(quantity)
	if util.positive(quantity) and (item.quantity >= quantity) then
		if quantity == item.quantity then
			// Delete from lua
			self.inventory[itemType][uniqueid] = nil
			// Delete from MySQL
			MySQLite.query("DELETE FROM " ..itemType .." WHERE uniqueid = " ..uniqueid)
		else
			self.inventory[itemType][uniqueid].quantity = self.inventory[itemType][uniqueid].quantity - quantity
			item.quantity = quantity
			
			MySQLite.query("UPDATE " ..itemType .." SET quantity = " ..self.inventory[itemType][uniqueid].quantity .." WHERE uniqueid = " ..uniqueid)
		end
	else
		// Delete from lua
		self.inventory[itemType][uniqueid] = nil
		// Delete from MySQL
		MySQLite.query("DELETE FROM " ..itemType .." WHERE uniqueid = " ..uniqueid)
	end
		
	// Update the client
	net.Start("dropItem")
		net.WriteString(itemType)
		net.WriteInt(uniqueid, 32)
		if util.positive(self.inventory[itemType][uniqueid].quantity) then
			net.WriteInt(self.inventory[itemType][uniqueid].quantity, 16)
		end
	net.Send(self)
		
	// Drop the item on the ground
	createLoot(self:GetPos(), {item})
end

function meta:equipItem(uniqueid, classid)
	if isWeapon(classid) then
		self:equipWeapon(uniqueid, classid)
	elseif isApparel(classid) then
	
	end
end

function meta:unequipItem(uniqueid, classid)
	if isWeapon(classid) then
		self:unequipWeapon(uniqueid, classid)
	elseif isApparel(classid) then
	
	end
end

net.Receive("dropItem", function(len, ply)
	local itemId = net.ReadInt(32)
	local classid = net.ReadInt(16)
	local quantity = net.ReadInt(16)
	
	ply:dropItem(itemId, classid, quantity)
end)

net.Receive("equipItem", function(len, ply)
	local itemId = net.ReadInt(32)
	local classid = net.ReadInt(16)
	
	ply:equipItem(itemId, classid)
end)

net.Receive("unequipItem", function(len, ply)
	local itemId = net.ReadInt(32)
	local classid = net.ReadInt(16)
	
	ply:unequipItem(itemId, classid)
end)
	