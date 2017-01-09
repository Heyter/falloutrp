
util.AddNetworkString("useAid")

local meta = FindMetaTable("Player")

function meta:loadInvAid()
	// Get aid
	MySQLite.query("SELECT * FROM aid WHERE steamid = '" ..self:SteamID() .."'", function(results)
		self:loadInventoryCount()
	end)	
end

function meta:useAid(uniqueid, classid, quantity)
	local ammoType = getAmmoEntity(classid)
	local aidQuantity = self:getAidQuantity(uniqueid)

	if aidQuantity >= quantity then
		if aidQuantity == quantity then // If they used up all the aid that was in their inventory
			self.inventory.aid[uniqueid] = nil
			MySQLite.query("DELETE FROM aid WHERE uniqueid = " ..uniqueid)
		else // Deduct how much aid they used
			self.inventory.aid[uniqueid]["quantity"] = self.inventory.aid[uniqueid]["quantity"] - quantity
			MySQLite.query("UPDATE aid SET quantity = " ..self.inventory.aid[uniqueid]["quantity"] .." WHERE uniqueid = " ..uniqueid)
		end

		// Do the function associated with the aid
		//self:GiveAmmo(quantity, ammoType)
				
		//Update client
		net.Start("useAid")
			net.WriteInt(uniqueid, 32)
			net.WriteInt(classid, 16)
			net.WriteInt(quantity, 16)
		net.Send(self)
	else
		// Client tried to use more quantity than is actually there
	end
end