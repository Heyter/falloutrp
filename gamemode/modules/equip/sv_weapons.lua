
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
	return self:getLevel() >= getWeaponLevel(classid)
end

function meta:wieldWeapon(classid)
	local weaponClass = getWeaponEntity(classid)
	self:Give(weaponClass)
	self:SelectWeapon(weaponClass)
	self:GetActiveWeapon().slot = getWeaponSlot(classid)
end

function meta:unequipWeapon(uniqueid, classid)
	// Strip weapon
	self:StripWeapon(getWeaponEntity(classid))
		
	// Remove from tables
	self.equipped.weapons[getWeaponSlot(classid)] = nil
	self.inventory.weapons[uniqueid]["equipped"] = false
			
	// Remove from MySQL
	MySQLite.query("UPDATE weapons SET equipped = 0 WHERE uniqueid = " ..uniqueid)
	
	self:updateClientEquipment()
end

function meta:equipWeapon(uniqueid, classid)
	if self:canEquipWeapon(classid) then
		local weaponType = getWeaponSlot(classid)
	
		// Remove current weapon
		if self:hasCurrentWeapon(weaponType) then
			local currentId = self:getCurrentWeaponId(weaponType)
			local currentClass = self:getCurrentWeaponClass(weaponType)
			
			self:unequipWeapon(currentId, currentClass)
		else

		end
		
		// Give and select weapon
		self:wieldWeapon(classid)
		
		//Update in lua
		self.inventory.weapons[uniqueid]["equipped"] = true
		self.equipped.weapons[weaponType] = self.inventory.weapons[uniqueid]
		
		self:updateClientEquipment()
		
		//Update MySQL
		MySQLite.query("UPDATE weapons SET equipped = 1 WHERE uniqueid = " ..uniqueid)
	else
		// Not enough level
		self:notify("Level not high enough to equip that.", NOTIFY_ERROR)
	end
end