
util.AddNetworkString("pickUpAmmo")

local meta = FindMetaTable("Player")

function meta:loadInvAmmo()
	// Get ammo
	MySQLite.query("SELECT * FROM ammo WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(results)
		if results then
			for k,v in pairs(results) do
				self.inventory["ammo"][v.uniqueid] = {
					classid = v.classid,
					uniqueid = v.uniqueid,
					quantity = v.quantity
				}
			end
		end
		
		self:loadInventoryCount()
	end)	
end

function meta:pickUpAmmo(ammo, quantity)
	local amount = quantity or 0
	local sameItem = self:hasAmmoItem(ammo.classid)

	local query = ""
	
	if sameItem then 
		amount = sameItem.quantity + quantity
		ammo.quantity = amount
		query = "UPDATE ammo SET quantity = " ..amount .." WHERE uniqueid = " ..sameItem.uniqueid
	else
		ammo.quantity = amount
		query = "INSERT INTO ammo (steamid, classid, quantity) VALUES ('" ..self:SteamID() .."', " ..ammo.classid ..", " ..amount ..")"
	end
	
	MySQLite.query(query, function()
		if sameItem then
			net.Start("pickUpMisc")
				net.WriteInt(sameItem.uniqueid, 32)
				net.WriteTable(ammo)
			net.Send(self)
		else
			// Get the last inserted id so we can store that in lua
			MySQLite.query("SELECT uniqueid FROM ammo WHERE classid = " ..ammo.classid .."  ORDER BY uniqueid DESC LIMIT 1", function(results)
				local itemId = 0
				if results and results[1] then
					itemId = results[1]["uniqueid"]
				end
				
				// Do the inventory logic for inserting below here
				ammo.uniqueid = itemId
				self.inventory.ammo[itemId] = ammo
				
				net.Start("pickUpAmmo")
					net.WriteInt(itemId, 32)
					net.WriteTable(ammo)
				net.Send(self)
			end)
		end
	end)
end