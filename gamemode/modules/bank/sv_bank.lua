
util.AddNetworkString("loadBank")
util.AddNetworkString("openBank")
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
				
				MySQLite.query("UPDATE " ..itemType .." SET quantity = " ..self.inventory[itemType][sameItem].quantity .." WHERE uniqueid = " ..sameItem)
				MySQLite.query("DELETE FROM " ..itemType .." WHERE uniqueid = " ..uniqueid)
			else
				self.inventory[itemType][uniqueid] = bankItem
				
				// Switch the banked column to NULL
				MySQLite.query("UPDATE " ..itemType .." SET banked = NULL WHERE uniqueid = " ..uniqueid)
			end
			
			// Update the client
			net.Start("withdrawItem")
				net.WriteString(itemType)
				net.WriteTable(self.inventory[itemType])
				net.WriteTable(self.bank[itemType])
			net.Send(self)
		else
			
			self.bank[itemType][uniqueid]["quantity"] = self.bank[itemType][uniqueid]["quantity"] - quantity
			MySQLite.query("UPDATE " ..itemType .." SET quantity = " ..self.bank[itemType][uniqueid]["quantity"] .." WHERE uniqueid = " ..uniqueid)
			
			if sameItem then
				// Add quantity to the current item already in the inventory
				self.inventory[itemType][sameItem]["quantity"] = self.inventory[itemType][sameItem]["quantity"] + quantity
				MySQLite.query("UPDATE " ..itemType .." SET quantity = " ..self.inventory[itemType][sameItem]["quantity"] .." WHERE uniqueid = " ..sameItem)
				
				// Update the client
				net.Start("withdrawItem")
					net.WriteString(itemType)
					net.WriteTable(self.inventory[itemType])
					net.WriteTable(self.bank[itemType])
				net.Send(self)
			else
				// Create a duplicate item, but mark it as not banked
				MySQLite.query("INSERT INTO " ..itemType .." (steamid, classid, quantity) VALUES ('" ..self:SteamID() .."', " ..classid ..", " ..quantity ..")", function()
					MySQLite.query("SELECT uniqueid FROM " ..itemType .." WHERE banked IS NULL ORDER BY uniqueid DESC LIMIT 1", function(results)
						local itemId = 0
						if results and results[1] then
							itemId = results[1]["uniqueid"]
						end
						
						bankItem.uniqueid = itemId
						bankItem.quantity = bankItem.quantity - quantity
						self.inventory[itemType][itemId] = bankItem
						
						// Update the client
						net.Start("withdrawItem")
							net.WriteString(itemType)
							net.WriteTable(self.inventory[itemType])
							net.WriteTable(self.bank[itemType])
						net.Send(self)
					end)
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
				
				MySQLite.query("UPDATE " ..itemType .." SET quantity = " ..self.bank[itemType][sameItem].quantity .." WHERE uniqueid = " ..sameItem)
				MySQLite.query("DELETE FROM " ..itemType .." WHERE uniqueid = " ..uniqueid)
			else
				self.bank[itemType][uniqueid] = invItem
			
				// Switch the banked column to true
				MySQLite.query("UPDATE " ..itemType .." SET banked = 1 WHERE uniqueid = " ..uniqueid)
			end
			
			// Update the client
			net.Start("depositItem")
				net.WriteString(itemType)
				net.WriteTable(self.inventory[itemType])
				net.WriteTable(self.bank[itemType])
			net.Send(self)
		else
			self.inventory[itemType][uniqueid]["quantity"] = self.inventory[itemType][uniqueid]["quantity"] - quantity
			MySQLite.query("UPDATE " ..itemType .." SET quantity = " ..self.inventory[itemType][uniqueid]["quantity"] .." WHERE uniqueid = " ..uniqueid)
			
			if sameItem then
				// Add quantity to the current item already in the bank
				print("SAME ITEM")
				print(sameItem, quantity)
				self.bank[itemType][sameItem]["quantity"] = self.bank[itemType][sameItem]["quantity"] + quantity
				MySQLite.query("UPDATE " ..itemType .." SET quantity = " ..self.bank[itemType][sameItem]["quantity"] .." WHERE uniqueid = " ..sameItem)
				
			else
				// Create a duplicate item, but mark it as banked
				MySQLite.query("INSERT INTO " ..itemType .." (steamid, classid, quantity, banked) VALUES ('" ..self:SteamID() .."', " ..classid ..", " ..quantity ..", 1)", function()
					MySQLite.query("SELECT uniqueid FROM " ..itemType .." WHERE banked = 1 ORDER BY uniqueid DESC LIMIT 1", function(results)
						local itemId = 0
						if results and results[1] then
							itemId = results[1]["uniqueid"]
						end
						
						invItem.uniqueid = itemId
						invItem.quantity = invItem.quantity - quantity 
						self.bank[itemType][itemId] = invItem
						
						// Update the client
						net.Start("depositItem")
							net.WriteString(itemType)
							net.WriteTable(self.inventory[itemType])
							net.WriteTable(self.bank[itemType])
						net.Send(self)
					end)
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
	net.Start("openBank")
	
	net.Send(self)
end

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
	MySQLite.query("SELECT * FROM weapons WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k, v in pairs(results) do
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
	MySQLite.query("SELECT * FROM apparel WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k, v in pairs(results) do
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
	MySQLite.query("SELECT * FROM aid WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k,v in pairs(results) do
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
	MySQLite.query("SELECT * FROM ammo WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k,v in pairs(results) do
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
	MySQLite.query("SELECT * FROM misc WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k,v in pairs(results) do
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