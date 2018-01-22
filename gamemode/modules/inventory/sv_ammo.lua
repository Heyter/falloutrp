
util.AddNetworkString("pickUpAmmo")

local meta = FindMetaTable("Player")

function meta:loadInvAmmo()
	// Get ammo
	DB:RunQuery("SELECT * FROM ammo WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(query, status, data)
		if data and data[1] then
			for k,v in pairs(data) do
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
		query = "UPDATE ammo SET quantity = " ..amount .." WHERE uniqueid = " ..sameItem.uniqueid

		// Add this information because it's how the clientside is updated
		ammo.quantity = amount
		ammo.uniqueid = sameItem.uniqueid
	else
		ammo.quantity = amount
		query = "INSERT INTO ammo (steamid, classid, quantity) VALUES ('" ..self:SteamID() .."', " ..ammo.classid ..", " ..amount ..")"
	end

	query = query .."; SELECT LAST_INSERT_ID();"

	DB:RunQuery(query, function(query, status, data)
		if sameItem then
			self.inventory.ammo[sameItem.uniqueid]["quantity"] = amount

			net.Start("pickUpAmmo")
				net.WriteInt(sameItem.uniqueid, 32)
				net.WriteTable(ammo)
			net.Send(self)
		else
			// Get the last inserted id so we can store that in lua
			local uniqueid = query:getNextResults()[1]["LAST_INSERT_ID()"]
			ammo.uniqueid = uniqueid
			self.inventory.ammo[uniqueid] = ammo

			net.Start("pickUpAmmo")
				net.WriteInt(uniqueid, 32)
				net.WriteTable(ammo)
			net.Send(self)
		end
	end)
end
