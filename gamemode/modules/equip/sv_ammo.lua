
util.AddNetworkString("equipAmmo")

// Server
local meta = FindMetaTable("Player")

function meta:wieldWeapon(classid)
	local weaponClass = getWeaponEntity(classid)
	self:Give(weaponClass)
	self:SelectWeapon(weaponClass)
end

function meta:equipAmmo(uniqueid, classid, quantity)
	print(classid)
	local ammoType = getAmmoEntity(classid)
	local ammoQuantity = self:getAmmoQuantity(uniqueid)

	if ammoQuantity >= quantity then
		if ammoQuantity == quantity then // If they used up all the ammo that was in their inventory
			self.inventory.ammo[uniqueid] = nil
			MySQLite.query("DELETE FROM ammo WHERE uniqueid = " ..uniqueid)
		else // Deduct how much ammo they equipped
			self.inventory.ammo[uniqueid]["quantity"] = self.inventory.ammo[uniqueid]["quantity"] - quantity
			MySQLite.query("UPDATE ammo SET quantity = " ..self.inventory.ammo[uniqueid]["quantity"] .." WHERE uniqueid = " ..uniqueid)
		end
		print(quantity, ammoType)
		// Give the ammo
		self:GiveAmmo(quantity, ammoType)
				
		//Update client
		net.Start("equipAmmo")
			net.WriteInt(uniqueid, 32)
			net.WriteInt(classid, 16)
			net.WriteInt(quantity, 16)
		net.Send(self)
	else
		// Client tried to equip more quantity than is actually there
	end
end