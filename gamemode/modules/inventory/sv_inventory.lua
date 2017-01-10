
util.AddNetworkString("loadInventory")
util.AddNetworkString("dropItem")
util.AddNetworkString("dropAllInventory")

local meta = FindMetaTable("Player")

function meta:loadInventoryCount()
	self.loadInvCount = self.loadInvCount + 1
	
	if self.loadInvCount == 5 then // weapons, apparel, aid, misc, and ammo were all loaded
		self:sendInventory()
	end
end

function meta:dropAllInventory()
	local loot = {}
	
	// Remove all items the player had equipped
	for type, items in pairs(self.equipped) do
		for k, item in pairs(items) do		
			self.equipped[type][k] = nil
		end
	end
	
	// Insert all player's items into the loot and remove the item
	for type, items in pairs(self.inventory) do
		for uniqueid, item in pairs(items) do
			MySQLite.query("DELETE FROM " ..type .." WHERE uniqueid = " ..uniqueid)
			table.insert(loot, item)
			self.inventory[type][uniqueid] = nil
		end
	end
	
	// If the player had any items in the inventory then create the loot
	if loot and #loot > 0 then
		PrintTable(loot)
		createLoot(self:GetPos(), loot)
	end
	
	net.Start("loadInventory")
		net.WriteTable(self.inventory)
		net.WriteTable(self.equipped)
	net.Send(self)
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
		self:pickUpApparel(item)
	elseif isAmmo(item.classid) then
		self:pickUpAmmo(item, quantity)
	elseif isAid(item.classid) then
		self:pickUpAid(item, quantity)
	elseif isMisc(item.classid) then
		self:pickUpMisc(item, quantity)
	end
end

function meta:dropItem(uniqueid, classid, quantity)
	local itemType = classidToStringType(classid)

	// Store the item temp so we can drop it
	local item = table.Copy(self.inventory[itemType][uniqueid])
		
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
			print("New inventory quantity: " ..(self.inventory[itemType][uniqueid].quantity - quantity))
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
		if self.inventory[itemType][uniqueid] and util.positive(self.inventory[itemType][uniqueid].quantity) then
			net.WriteInt(self.inventory[itemType][uniqueid].quantity, 16)
		end
	net.Send(self)
		
	// Drop the item on the ground
	createLoot(self:GetPos(), {item})
end

net.Receive("dropItem", function(len, ply)
	local itemId = net.ReadInt(32)
	local classid = net.ReadInt(16)
	local quantity = net.ReadInt(16)
	
	ply:dropItem(itemId, classid, quantity)
end)
	