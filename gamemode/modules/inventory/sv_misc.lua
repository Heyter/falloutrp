
util.AddNetworkString("pickUpMisc")

local meta = FindMetaTable("Player")

function meta:loadInvMisc()
	// Get misc
	DB:RunQuery("SELECT * FROM misc WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(query, status, data)
		if data and data[1] then
			for k,v in pairs(data) do
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
		query = "UPDATE misc SET quantity = " ..amount .." WHERE uniqueid = " ..sameItem.uniqueid

		// Add this information because it's how the clientside is updated
		misc.quantity = amount
		misc.uniqueid = sameItem.uniqueid
	else
		misc.quantity = amount
		query = "INSERT INTO misc (steamid, classid, quantity) VALUES ('" ..self:SteamID() .."', " ..misc.classid ..", " ..amount ..")"
	end

	query = query .."; SELECT LAST_INSERT_ID();"

	DB:RunQuery(query, function(query, status, data)
		if sameItem then
			self.inventory.misc[sameItem.uniqueid]["quantity"] = amount

			net.Start("pickUpMisc")
				net.WriteInt(sameItem.uniqueid, 32)
				net.WriteTable(misc)
			net.Send(self)
		else
			// Get the last inserted id so we can store that in lua
			local uniqueid = query:getNextResults()[1]["LAST_INSERT_ID()"]
			misc.uniqueid = uniqueid
			self.inventory.misc[uniqueid] = misc

			net.Start("pickUpMisc")
				net.WriteInt(uniqueid, 32)
				net.WriteTable(misc)
			net.Send(self)
		end
	end)
end
