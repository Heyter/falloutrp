
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
	return self:getStrength() >= getWeaponStrength(classid)
end

function meta:equipWeapon(uniqueid, classid)
	if self:canEquipWeapon(classid) then
		local weaponType = getWeaponType(classid)
	
		// Remove current weapon
		if self:hasCurrentWeapon(weaponType) then
			local currentId = self:getCurrentWeaponId(weaponType)
			local currentClass = self:getCurrentWeaponClass(weaponType)
		
			// Strip weapon
			self:StripWeapon(getWeaponEntity(currentClass))
		
			// Remove from tables
			self.equipped.weapons[weaponType] = nil
			self.inventory.weapons[currentId]["equipped"] = false
			
			// Remove from MySQL
			MySQLite.query("UPDATE weapons SET equipped = 0 WHERE uniqueid = " ..currentId)
		end
		
		// Give and select weapon
		local weaponClass = getWeaponEntity(classid)
		self:Give(weaponClass)
		self:SelectWeapon(weaponClass)
		
		//Update in lua
		self.inventory.weapons[uniqueid]["equipped"] = true
		self.equipped.weapons[weaponType] = self.inventory.weapons[uniqueid]
			
		//Update client
		net.Start("equipItem")
			
		net.Send(self)
			
		//Update MySQL
		MySQLite.query("UPDATE weapons SET equipped = 1 WHERE uniqueid = " ..uniqueid)
	else
		// Not enough strength
	end
end