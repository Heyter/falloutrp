
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
	net.Send(self)
end

function meta:pickUpItem(item)
	PrintTable(item)
	if isWeapon(item.classid) then
		PrintTable(item)
		self:pickUpWeapon(item)
	elseif isApparel(item.classid) then
	
	end
end

function meta:dropItem(uniqueId, itemType)
	if uniqueId and itemType then
		// Store the item temp so we can drop it
		local item = self.inventory[itemType][uniqueId]
		
		// Delete from lua
		self.inventory[itemType][uniqueId] = nil
		
		// Update the client
		net.Start("dropItem")
		
		net.Send(self)
		
		// Delete from MySQL
		MySQLite.query("DELETE FROM " ..itemType .." WHERE uniqueid = " ..uniqueId)
		
		// Drop the item on the ground
		createLoot(self:GetPos(), {item})
	end
end

function meta:equipItem(uniqueId, itemType)
	if uniqueId and itemType then
		//Update in lua
		self.inventory[itemType][uniqueId]["equipped"] = true
		
		//Update client
		net.Start("equipItem")
		
		net.Send(self)
		
		//Update MySQL
		MySQLite.query("UPDATE " ..itemType .." SET equipped = 1 WHERE uniqueid = " ..uniqueId)
	end
end

function meta:unequipItem(uniqueId, itemType)
	if uniqueId and itemType then
		//Update in lua
		self.inventory[itemType][uniqueId]["equipped"] = false
		
		//Update client
		net.Start("unequipItem")
		
		net.Send(self)
		
		//Update MySQL
		MySQLite.query("UPDATE " ..itemType .." SET equipped = 0 WHERE uniqueid = " ..uniqueId)
	end
end

net.Receive("dropItem", function(len, ply)
	local itemId = net.ReadInt(8)
	local itemType = net.ReadString()
	
	ply:dropItem(itemId, itemType)
end)

net.Receive("equipItem", function(len, ply)
	local itemId = net.ReadInt(8)
	local itemType = net.ReadString()
	
	ply:equipItem(itemId, itemType)
end)

net.Receive("unequipItem", function(len, ply)
	local itemId = net.ReadInt(8)
	local itemType = net.ReadString()
	
	ply:unequipItem(itemId, itemType)
end)
	