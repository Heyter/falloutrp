
local meta = FindMetaTable("Player")

function meta:loadInvWeapons()
	// Get weapons (get NOT equipped)
	MySQLite.query("SELECT * FROM weapons WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(results)
		for k, v in pairs(results) do
			self.inventory["weapons"][v.uniqueid] = {
				classid = v.classid,
				damage = v.damage,
				equipped = tobool(v.equipped),
				uniqueid = v.uniqueid
			}
		end
		
		self:loadInventoryCount()
	end)	
end

function meta:pickUpWeapon(weapon)
	MySQLite.query("INSERT INTO weapons (steamid, classid, damage) VALUES ('" ..Entity(1):SteamID() .."', " ..1001 ..", " ..150 ..")", function()
		// Get the last inserted id so we can store that in lua
		MySQLite.query("SELECT uniqueid FROM weapons ORDER BY uniqueid DESC LIMIT 1", function(results)
			local itemId = 0
			if results and results[1] then
				itemId = results[1]["uniqueid"]
			end
			
			// Do the inventory logic for inserting below here
			weapon.uniqueid = itemId
			self.inventory.weapons[itemId] = weapon
			print(itemId)
		end)
	end)
end