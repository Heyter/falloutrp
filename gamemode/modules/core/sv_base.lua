
hook.Add("EntityTakeDamage", "ModifyDamage", function(target, dmgInfo)
	local inflictor = dmgInfo:GetInflictor()
	local attacker = dmgInfo:GetAttacker()
	local damage = dmgInfo:GetDamage()
	local damageType = dmgInfo:GetDamageType()
	print(damage)
	if IsValid(attacker) and attacker:IsPlayer() then
		if IsValid(target) and target:IsPlayer() then
			// Add Damage
		
			local weapon = attacker:GetActiveWeapon()
			local weaponSlot = weapon.slot
			
			local item = attacker.equipped.weapons[weaponSlot] // The actual item that the player is equipping
			if item then
				local uniqueid = item.uniqueid
				local classid = item.classid
				
				local damageType = getWeaponType(classid)
				local critChance = getWeaponCriticalChance(classid)
				
				print("Printing new damage")
				damage = attacker:getWeaponDamage(uniqueid)
				print(damage)
				
				if util.roll(critChance + (critChance * attacker:getAgilityCriticalHitChance())) then
					damage = (damage * CRITICAL_MULTIPLIER)
					damage = damage + (damage * (attacker:getPerceptionCriticalHitDamage() + attacker:getFactionCriticalHitDamage()))
				end
				print("Printing damage type")
				print(damageType)
				print(damage)
				// Unarmed and Explosives will need to be handled seperately
				if damageType == DMG_BULLET then
					damage = damage + (damage * (attacker:getGunsDamage() + attacker:getFactionGunsDamage() * damage))
				elseif damageType == DMG_ENERGYBEAM then
					damage = damage + (damage * (attacker:getEnergyWeaponsDamage() + attacker:getFactionEnergyWeaponsDamage()))
				elseif damageType == DMG_SLASH then
					damage = damage + (damage * (attacker:getMeleeWeaponsDamage() + attacker:getFactionMeleeWeaponsDamage()))
				elseif damageType == DMG_PLASMA then
					damage = damage + (damage * attacker:getScienceDamage())
				end
			end
			
			// Reduce Damage
			print(damage)
			dmgInfo:SetDamage(damage)
		end
	end
end)

hook.Add("PlayerSpawn", "SetupPlayer", function(ply)
	if ply.loaded then
		timer.Simple(1, function()
			ply:SetHealth(ply:getMaxHealth())
			
			// Initialize hunger
			ply:setHunger(HUNGER_MAX)
			ply:startHungerTimer()
					
			// Initialize thirst
			ply:setThirst(THIRST_MAX)
			ply:startThirstTimer()
		end)
	end
end)

hook.Add("PlayerShouldTakeDamage", "SpawnTeamKill", function(victim, attacker)
	if victim.spawnProtected or attacker.spawnProtected then
		return false
	end
	
	if victim:IsPlayer() and attacker:IsPlayer() then
		return victim:Team() != attacker:Team()
	end
	
	return true
end)

hook.Add("InitPostEntity", "SpawnZoneChecker", function()
	local safeStart, safeEnd = SAFEZONE_START, SAFEZONE_END

	timer.Create("spawnZone", 0.5, 0, function()
		for k,v in pairs(ents.FindInBox(safeStart, safeEnd)) do
			if IsValid(v) and v:IsPlayer() then
				v.spawnProtected = true
				
				if !v.onSpawnTimer then
					v.onSpawnTimer = true
					
					timer.Simple(10, function()
						if IsValid(v) then
							v.spawnProtected = false
							v.onSpawnTimer = false
						end
					end)
				end
			end
		end
	end)
end)