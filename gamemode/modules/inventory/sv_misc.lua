
util.AddNetworkString("pickUpMisc")

local meta = FindMetaTable("Player")

function meta:loadInvMisc()
	// Get misc
	MySQLite.query("SELECT * FROM misc WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(results)
		for k,v in pairs(results) do
			self.inventory["misc"][v.uniqueid] = {
				classid = v.classid,
				uniqueid = v.uniqueid
			}
		end
		
		self:loadInventoryCount()
	end)	
end

function meta:pickUpMisc(misc)
	MySQLite.query("INSERT INTO misc (steamid, classid) VALUES ('" ..Entity(1):SteamID() .."', " ..misc.classid ..")", function()
		// Get the last inserted id so we can store that in lua
		MySQLite.query("SELECT uniqueid FROM misc ORDER BY uniqueid DESC LIMIT 1", function(results)
			local itemId = 0
			if results and results[1] then
				itemId = results[1]["uniqueid"]
			end
			
			// Do the inventory logic for inserting below here
			misc.uniqueid = itemId
			self.inventory.misc[itemId] = misc
			
			net.Start("pickUpMisc")
				net.WriteInt(itemId, 8)
				net.WriteTable(misc)
			net.Send(self)
		end)
	end)
end