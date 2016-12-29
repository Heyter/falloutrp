
util.AddNetworkString("loadInventory")

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

function meta:pickUpWeapon()
	MySQLite.query("INSERT INTO weapons (steamid, classid, stat1) VALUES ('" ..Entity(1):SteamID() .."', " ..1001 ..", " ..150 ..")", function()
		// Get the last inserted id so we can store that in lua
		MySQLite.query("SELECT uniqueid FROM weapons ORDER BY uniqueid DESC LIMIT 1", function(results)
			local itemId = 0
			if results and results[1] then
				itemId = results[1]["uniqueid"]
			end
			
			// Do the inventory logic for inserting below here
			print(itemId)
		end)
	end)
end
	