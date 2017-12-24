
util.AddNetworkString("pickUpAid")

local meta = FindMetaTable("Player")

function meta:loadInvAid()
	// Get aid
	DB:RunQuery("SELECT * FROM aid WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(query, status, data)
		if data and data[1] then
			for k,v in pairs(data) do
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

	query = query .."; SELECT LAST_INSERT_ID();"

	DB:RunQuery(query, function(query, status, data)
		if sameItem then
			self.inventory.aid[sameItem.uniqueid]["quantity"] = amount

			net.Start("pickUpAid")
				net.WriteInt(sameItem.uniqueid, 32)
				net.WriteTable(aid)
			net.Send(self)
		else
			// Get the last inserted id so we can store that in lua
			local uniqueid = query:getNextResults()[1]["LAST_INSERT_ID()"]
			aid.uniqueid = uniqueid
			self.inventory.aid[uniqueid] = aid

			net.Start("pickUpAid")
				net.WriteInt(uniqueid, 32)
				net.WriteTable(aid)
			net.Send(self)
		end
	end)
end
