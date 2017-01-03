
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

function meta:pickUpItem(item)
	if isWeapon(item.classid) then
		PrintTable(item)
		self:pickUpWeapon(item)
	elseif isApparel(item.classid) then
	
	elseif isAmmo(item.classid) then
	
	elseif isAid(item.classid) then
	
	elseif isMisc(item.classid) then
		self:pickUpMisc(item)
	end
end

function meta:dropItem(uniqueid, classid)
	local itemType = classidToStringType(classid)

	// Store the item temp so we can drop it
	local item = self.inventory[itemType][uniqueid]
		
	// Delete from lua
	self.inventory[itemType][uniqueid] = nil
		
	// Update the client
	net.Start("dropItem")
		
	net.Send(self)
		
	// Delete from MySQL
	MySQLite.query("DELETE FROM " ..itemType .." WHERE uniqueid = " ..uniqueid)
		
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
	
	print(itemId, classid)
	
	ply:dropItem(itemId, classid)
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
	