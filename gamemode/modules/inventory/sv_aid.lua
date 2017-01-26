
util.AddNetworkString("pickUpAid")

local meta = FindMetaTable("Player")

function meta:loadInvAid()
	// Get aid
	MySQLite.query("SELECT * FROM aid WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(results)
		if results then
			for k,v in pairs(results) do
				self.inventory["aid"][v.uniqueid] = {
					classid = v.classid,
					uniqueid = v.uniqueid,
					quantity = v.quantity
				}
			end
		end
		
		self:loadInventoryCount()
	end)	
end

function meta:pickUpAid(aid, quantity)
	local amount = quantity or 0
	local sameItem = self:hasAidItem(aid.classid)

	local query = ""
	
	if sameItem then 
		amount = sameItem.quantity + quantity
		query = "UPDATE aid SET quantity = " ..amount .." WHERE uniqueid = " ..sameItem.uniqueid
		
		// Add this information because it's how the clientside is updated
		aid.quantity = amount
		aid.uniqueid = sameItem.uniqueid
	else
		aid.quantity = amount
		query = "INSERT INTO aid (steamid, classid, quantity) VALUES ('" ..self:SteamID() .."', " ..aid.classid ..", " ..amount ..")"
	end
	
	MySQLite.query(query, function()
		if sameItem then
			self.inventory.aid[sameItem.uniqueid]["quantity"] = amount
		
			net.Start("pickUpAid")
				net.WriteInt(sameItem.uniqueid, 32)
				net.WriteTable(aid)
			net.Send(self)
		else
			// Get the last inserted id so we can store that in lua
			MySQLite.query("SELECT uniqueid FROM aid WHERE classid = " ..aid.classid .." ORDER BY uniqueid DESC LIMIT 1", function(results)
				local itemId = 0
				if results and results[1] then
					itemId = results[1]["uniqueid"]
				end
				
				// Do the inventory logic for inserting below here
				aid.uniqueid = itemId
				self.inventory.aid[itemId] = aid
				
				net.Start("pickUpAid")
					net.WriteInt(itemId, 32)
					net.WriteTable(aid)
				net.Send(self)
			end)
		end
	end)
end