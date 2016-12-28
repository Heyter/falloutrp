
util.AddNetworkString("loadInventory")

local meta = FindMetaTable("Player")

// Get data from all item tables for specific player
function meta:loadInventory()
	self.inventory = {
		weapons = {},
		apparel = {},
		aid = {},
		misc = {},
		ammo = {}
	}
	
	// Get weapons (check if it's equipped)
	MySQLite.query("SELECT * FROM weapons WHERE steamid = '" ..self:SteamID() .."'", function(results)
	
	end)	
	// Get apparel (check if it's equipped)
	MySQLite.query("SELECT * FROM apparel WHERE steamid = '" ..self:SteamID() .."'", function(results)
	
	end)	
	// Get aid
	MySQLite.query("SELECT * FROM aid WHERE steamid = '" ..self:SteamID() .."'", function(results)
	
	end)	
	// Get misc
	MySQLite.query("SELECT * FROM misc WHERE steamid = '" ..self:SteamID() .."'", function(results)
	
	end)	
	// Get ammo
	MySQLite.query("SELECT * FROM ammo WHERE steamid = '" ..self:SteamID() .."'", function(results)
		self:sendInventory()
	end)
	
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
	