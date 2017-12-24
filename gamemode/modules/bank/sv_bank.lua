
util.AddNetworkString("loadBank")
util.AddNetworkString("openBank")
util.AddNetworkString("closeBank")
util.AddNetworkString("depositItem")
util.AddNetworkString("withdrawItem")

local meta = FindMetaTable("Player")

function meta:withdrawItem(uniqueid, classid, quantity)
	local quantity = quantity
	local itemType = classidToStringType(classid)

	local bankItem = table.Copy(self.bank[itemType][uniqueid])
	local sameItem = self:hasInventoryItem(itemType, classid)

	local canFit = self:canInventoryFit(bankItem, quantity)

	if util.positive(canFit) then
		quantity = canFit
	end

	if canFit then
		// Remove from bank
		if !util.positive(bankItem.quantity) or (quantity == bankItem.quantity) then
			// Remove item from bank and add item to inventory
			self.bank[itemType][uniqueid] = nil

			if sameItem then
				// Add the quantity to the current inventory item
				self.inventory[itemType][sameItem].quantity = self.inventory[itemType][sameItem].quantity + quantity

				DB:RunQuery("UPDATE " ..itemType .." SET quantity = " ..self.inventory[itemType][sameItem].quantity .." WHERE uniqueid = " ..sameItem)
				DB:RunQuery("DELETE FROM " ..itemType .." WHERE uniqueid = " ..uniqueid)
			else
				self.inventory[itemType][uniqueid] = bankItem

				// Switch the banked column to NULL
				DB:RunQuery("UPDATE " ..itemType .." SET banked = NULL WHERE uniqueid = " ..uniqueid)
			end

			// Update the client
			net.Start("withdrawItem")
				net.WriteString(itemType)
				net.WriteTable(self.inventory[itemType])
				net.WriteTable(self.bank[itemType])
			net.Send(self)
		else

			self.bank[itemType][uniqueid]["quantity"] = self.bank[itemType][uniqueid]["quantity"] - quantity
			DB:RunQuery("UPDATE " ..itemType .." SET quantity = " ..self.bank[itemType][uniqueid]["quantity"] .." WHERE uniqueid = " ..uniqueid)

			if sameItem then
				// Add quantity to the current item already in the inventory
				self.inventory[itemType][sameItem]["quantity"] = self.inventory[itemType][sameItem]["quantity"] + quantity
				DB:RunQuery("UPDATE " ..itemType .." SET quantity = " ..self.inventory[itemType][sameItem]["quantity"] .." WHERE uniqueid = " ..sameItem)

				// Update the client
				net.Start("withdrawItem")
					net.WriteString(itemType)
					net.WriteTable(self.inventory[itemType])
					net.WriteTable(self.bank[itemType])
				net.Send(self)
			else
				// Create a duplicate item, but mark it as not banked
				DB:RunQuery("INSERT INTO " ..itemType .." (steamid, classid, quantity) VALUES ('" ..self:SteamID() .."', " ..classid ..", " ..quantity .."); SELECT LAST_INSERT_ID();", function(query, status, data)
					local uniqueid = query:getNextResults()[1]["LAST_INSERT_ID()"]
					bankItem.uniqueid = uniqueid
					bankItem.quantity = quantity
					self.inventory[itemType][uniqueid] = bankItem

					// Update the client
					net.Start("withdrawItem")
						net.WriteString(itemType)
						net.WriteTable(self.inventory[itemType])
						net.WriteTable(self.bank[itemType])
					net.Send(self)
				end)
			end
		end
	elseif canFit != true then
		// The player can't fit any amount of item into the bank
	end
end

net.Receive("withdrawItem", function(len, ply)
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	local quantity = net.ReadInt(16)

	ply:withdrawItem(uniqueid, classid, quantity)
end)

function meta:depositItem(uniqueid, classid, quantity)
	local quantity = quantity
	local itemType = classidToStringType(classid)

	local canFit = self:canBankFit(classid, quantity)

	if util.positive(canFit) then
		quantity = canFit
	end

	if canFit then
		local invItem = table.Copy(self.inventory[itemType][uniqueid])
		local sameItem = self:hasBankItem(itemType, classid)

		// Remove from inventory
		if !util.positive(invItem.quantity) or (quantity == invItem.quantity) then
			// Remove item from inventory and add item to bank
			self.inventory[itemType][uniqueid] = nil

			if sameItem then
				// Add the quantity to the current banked item
				self.bank[itemType][sameItem].quantity = self.bank[itemType][sameItem].quantity + quantity

				DB:RunQuery("UPDATE " ..itemType .." SET quantity = " ..self.bank[itemType][sameItem].quantity .." WHERE uniqueid = " ..sameItem)
				DB:RunQuery("DELETE FROM " ..itemType .." WHERE uniqueid = " ..uniqueid)
			else
				self.bank[itemType][uniqueid] = invItem

				// Switch the banked column to true
				DB:RunQuery("UPDATE " ..itemType .." SET banked = 1 WHERE uniqueid = " ..uniqueid)
			end

			// Update the client
			net.Start("depositItem")
				net.WriteString(itemType)
				net.WriteTable(self.inventory[itemType])
				net.WriteTable(self.bank[itemType])
			net.Send(self)
		else
			self.inventory[itemType][uniqueid]["quantity"] = self.inventory[itemType][uniqueid]["quantity"] - quantity
			DB:RunQuery("UPDATE " ..itemType .." SET quantity = " ..self.inventory[itemType][uniqueid]["quantity"] .." WHERE uniqueid = " ..uniqueid)

			if sameItem then
				// Add quantity to the current item already in the bank
				self.bank[itemType][sameItem]["quantity"] = self.bank[itemType][sameItem]["quantity"] + quantity
				DB:RunQuery("UPDATE " ..itemType .." SET quantity = " ..self.bank[itemType][sameItem]["quantity"] .." WHERE uniqueid = " ..sameItem)

				// Update the client
				net.Start("depositItem")
					net.WriteString(itemType)
					net.WriteTable(self.inventory[itemType])
					net.WriteTable(self.bank[itemType])
				net.Send(self)
			else
				// Create a duplicate item, but mark it as banked
				DB:RunQuery("INSERT INTO " ..itemType .." (steamid, classid, quantity, banked) VALUES ('" ..self:SteamID() .."', " ..classid ..", " ..quantity ..", 1); SELECT LAST_INSERT_ID();", function(query, status, data)
					local uniqueid = query:getNextResults()[1]["LAST_INSERT_ID()"]
					invItem.uniqueid = uniqueid
					invItem.quantity = quantity
					self.bank[itemType][uniqueid] = invItem

					// Update the client
					net.Start("depositItem")
						net.WriteString(itemType)
						net.WriteTable(self.inventory[itemType])
						net.WriteTable(self.bank[itemType])
					net.Send(self)
				end)
			end
		end
	elseif canFit != true then
		// The player can't fit any amount of item into the bank
	end
end

net.Receive("depositItem", function(len, ply)
	local uniqueid = net.ReadInt(32)
	local classid = net.ReadInt(16)
	local quantity = net.ReadInt(16)

	ply:depositItem(uniqueid, classid, quantity)
end)

function meta:openBank()
	self:SetMoveType(MOVETYPE_NONE)

	net.Start("openBank")

	net.Send(self)
end

// Freeze the player
net.Receive("closeBank", function(len, ply)
	ply:SetMoveType(MOVETYPE_WALK)
end)

function meta:loadBankCount()
	self.loadBankedCount = self.loadBankedCount + 1

	if self.loadBankedCount == 5 then // weapons, apparel, aid, misc, and ammo were all loaded
		self:sendBank()
	end
end

// Get data from all item tables for specific player
function meta:loadBank()
	self.loadBankedCount = 0

	self.bank = {
		weapons = {},
		apparel = {},
		aid = {},
		misc = {},
		ammo = {}
	}

	self:loadBankWeapons()
	self:loadBankApparel()
	self:loadBankAid()
	self:loadBankMisc()
	self:loadBankAmmo()
end

// Run this in the last query you run when loading the bank
function meta:sendBank()
	net.Start("loadBank")
		net.WriteTable(self.bank)
	net.Send(self)
end

function meta:loadBankWeapons()
	DB:RunQuery("SELECT * FROM weapons WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(query, status, data)
		if data and data[1] then
			for k, v in pairs(data) do
				self.bank["weapons"][v.uniqueid] = {
					classid = v.classid,
					damage = v.damage,
					durability = v.durability,
					uniqueid = v.uniqueid
				}
			end
		end

		self:loadBankCount()
	end)
end

function meta:loadBankApparel()
	DB:RunQuery("SELECT * FROM apparel WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(query, status, data)
		if data and data[1] then
			for k, v in pairs(data) do
				self.bank["apparel"][v.uniqueid] = {
					classid = v.classid,
					damageThreshold = v.damageThreshold,
					damageReflection = v.damageReflection,
					bonusHp = v.bonusHp,
					durability = v.durability,
					equipped = tobool(v.equipped),
					uniqueid = v.uniqueid
				}
			end
		end

		self:loadBankCount()
	end)
end

function meta:loadBankAid()
	// Get aid
	DB:RunQuery("SELECT * FROM aid WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(query, status, data)
		if data and data[1] then
			for k,v in pairs(data) do
				self.inventory["aid"][v.uniqueid] = {
					classid = v.classid,
					uniqueid = v.uniqueid,
					quantity = v.quantity
				}
			end
		end

		self:loadBankCount()
	end)
end

function meta:loadBankAmmo()
	// Get ammo
	DB:RunQuery("SELECT * FROM ammo WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(query, status, data)
		if data and data[1] then
			for k,v in pairs(data) do
				self.bank["ammo"][v.uniqueid] = {
					classid = v.classid,
					uniqueid = v.uniqueid,
					quantity = v.quantity
				}
			end
		end

		self:loadBankCount()
	end)
end

function meta:loadBankMisc()
	// Get misc
	DB:RunQuery("SELECT * FROM misc WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(query, status, data)
		if data and data[1] then
			for k,v in pairs(data) do
				self.bank["misc"][v.uniqueid] = {
					classid = v.classid,
					uniqueid = v.uniqueid,
					quantity = v.quantity
				}
			end
		end

		self:loadBankCount()
	end)
end
