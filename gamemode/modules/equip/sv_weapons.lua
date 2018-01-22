
util.AddNetworkString("unequipWeapon")
util.AddNetworkString("equipWeapon")

// Server
local meta = FindMetaTable("Player")

function meta:hasCurrentWeapon(type)
	return self:getCurrentWeapon(type) != nil
end

function meta:getCurrentWeaponClass(type)
	return self:getCurrentWeapon(type).classid
end

function meta:getCurrentWeaponId(type)
	return self:getCurrentWeapon(type).uniqueid
end

function meta:getCurrentWeapon(type)
	return self.equipped.weapons[type]
end

function meta:canEquipWeapon(classid)
	local weapon = findWeapon(classid)
	return self:getLevel() >= weapon:getLevel()
end

function meta:wieldWeapon(classid)
	local weapon = findWeapon(classid)
	local weaponClass = weapon:getEntity()

	self:Give(weaponClass)
	self:SelectWeapon(weaponClass)
	self:GetActiveWeapon().slot = weapon:getSlot()
end

function meta:unequipWeapon(uniqueid, classid)
	local weapon = findWeapon(classid)

	// Strip weapon
	self:StripWeapon(weapon:getEntity())

	// Remove from tables
	self.equipped.weapons[weapon:getSlot()] = nil
	self.inventory.weapons[uniqueid]["equipped"] = false

	// Remove from MySQL
	DB:RunQuery("UPDATE weapons SET equipped = 0 WHERE uniqueid = " ..uniqueid)

	self:updateClientEquipment()

	net.Start("unequipWeapon")
		net.WriteInt(uniqueid, 32)
	net.Send(self)
end

function meta:equipWeapon(uniqueid, classid)
	local weapon = findWeapon(classid)

	if self:canEquipWeapon(classid) then
		local weaponType = weapon:getSlot()

		// Remove current weapon
		if self:hasCurrentWeapon(weaponType) then
			local currentId = self:getCurrentWeaponId(weaponType)
			local currentClass = self:getCurrentWeaponClass(weaponType)

			self:unequipWeapon(currentId, currentClass)
		else

		end

		// Give and select weapon
		self:wieldWeapon(classid)

		self.inventory.weapons[uniqueid]["equipped"] = true
		self.equipped.weapons[weaponType] = self.inventory.weapons[uniqueid]

		self:updateClientEquipment()

		DB:RunQuery("UPDATE weapons SET equipped = 1 WHERE uniqueid = " ..uniqueid)

		net.Start("equipWeapon")
			net.WriteInt(uniqueid, 32)
		net.Send(self)
	else
		// Not enough level
		self:notify("Must be level " ..weapon:getLevel() .." to equip that", NOTIFY_ERROR)
	end
end
