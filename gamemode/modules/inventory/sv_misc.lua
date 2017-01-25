
util.AddNetworkString("pickUpMisc")

local meta = FindMetaTable("Player")

function meta:loadInvMisc()
	// Get misc
	MySQLite.query("SELECT * FROM misc WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(results)
		if results then
			for k,v in pairs(results) do
				self.inventory["misc"][v.uniqueid] = {
					classid = v.classid,
					uniqueid = v.uniqueid,
					quantity = v.quantity
				}
			end
		end
		
		self:loadInventoryCount()
	end)	
end

function meta:pickUpMisc(misc, quantity)
	local amount = quantity or 0
	local sameItem = self:hasMiscItem(misc.classid)

	local query = ""
	
	if sameItem then 
		amount = sameItem.quantity + quantity
		misc.quantity = amount
		misc.uniqueid = sameItem.uniqueid
		query = "UPDATE misc SET quantity = " ..amount .." WHERE uniqueid = " ..sameItem.uniqueid
	else
		misc.quantity = amount
		query = "INSERT INTO misc (steamid, classid, quantity) VALUES ('" ..self:SteamID() .."', " ..misc.classid ..", " ..amount ..")"
	end
	
	MySQLite.query(query, function()
		if sameItem then
			net.Start("pickUpMisc")
				net.WriteInt(sameItem.uniqueid, 32)
				net.WriteTable(misc)
			net.Send(self)
		else
			// Get the last inserted id so we can store that in lua
			MySQLite.query("SELECT uniqueid FROM misc WHERE classid = " ..misc.classid .." ORDER BY uniqueid DESC LIMIT 1", function(results)
				local itemId = 0
				if results and results[1] then
					itemId = results[1]["uniqueid"]
				end
				
				// Do the inventory logic for inserting below here
				misc.uniqueid = itemId
				self.inventory.misc[itemId] = misc
				
				net.Start("pickUpMisc")
					net.WriteInt(itemId, 32)
					net.WriteTable(misc)
				net.Send(self)
			end)
		end
	end)
end