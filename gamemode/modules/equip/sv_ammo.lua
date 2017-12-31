
util.AddNetworkString("equipAmmo")

// Server
local meta = FindMetaTable("Player")

function meta:equipAmmo(uniqueid, classid, quantity)
	local ammoType = findAmmo(classid):getType()
	local ammoQuantity = self:getAmmoQuantity(uniqueid)

	if ammoQuantity >= quantity then
		if ammoQuantity == quantity then // If they used up all the ammo that was in their inventory
			self.inventory.ammo[uniqueid] = nil
			DB:RunQuery("DELETE FROM ammo WHERE uniqueid = " ..uniqueid)
		else // Deduct how much ammo they equipped
			self.inventory.ammo[uniqueid]["quantity"] = self.inventory.ammo[uniqueid]["quantity"] - quantity
			DB:RunQuery("UPDATE ammo SET quantity = " ..self.inventory.ammo[uniqueid]["quantity"] .." WHERE uniqueid = " ..uniqueid)
		end

		self:GiveAmmo(quantity, ammoType)

		net.Start("equipAmmo")
			net.WriteInt(uniqueid, 32)
			net.WriteInt(classid, 16)
			net.WriteInt(quantity, 16)
		net.Send(self)
	else
		// Client tried to equip more quantity than is actually there
	end
end
