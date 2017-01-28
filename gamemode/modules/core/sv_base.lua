
hook.Add("EntityTakeDamage", "ModifyDamage", function(target, dmgInfo)
	local inflictor = dmgInfo:GetInflictor()
	local attacker = dmgInfo:GetAttacker()
	local damageType = dmgInfo:GetDamageType()
	print(damage)
	if IsValid(attacker) and attacker:IsPlayer() then
		if IsValid(target) and target:IsPlayer() then
			// Add Damage
			local damage = dmgInfo:GetDamage()
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
					damage = damage + (damage * (attacker:getGunsDamage() + attacker:getFactionGunsDamage()))
				elseif damageType == DMG_ENERGYBEAM then
					damage = damage + (damage * (attacker:getEnergyWeaponsDamage() + attacker:getFactionEnergyWeaponsDamage()))
				elseif damageType == DMG_SLASH then
					damage = damage + (damage * (attacker:getMeleeWeaponsDamage() + attacker:getFactionMeleeWeaponsDamage()))
				elseif damageType == DMG_PLASMA then
					damage = damage + (damage * attacker:getScienceDamage())
				end
			end
			
			// Reduce Damage
				//Get Damage Threshold
				
			
			print(damage)
			dmgInfo:SetDamage(damage)
			
			// Reflect Damage
				// Get Damage Reflection
			
		end
	end
end)

hook.Add("PlayerSpawn", "SetupPlayer", function(ply)
	if ply.loaded then
		timer.Simple(1, function()
			// Set health
			ply:SetHealth(ply:getMaxHealth())
			
			// Initialize hunger
			ply:setHunger(HUNGER_MAX)
			ply:startHungerTimer()
					
			// Initialize thirst
			ply:setThirst(THIRST_MAX)
			ply:startThirstTimer()
			
			// Initialize stamina
			tcb_StaminaStart(ply)
			
			if ply:Team() == TEAM_BOS then
				ply:SetModel("models/player/fallout_3/tesla_power_armor.mdl")
			elseif ply:Team() == TEAM_NCR then
				ply:SetModel("models/player/ncr/desertranger.mdl")
			elseif ply:Team() == TEAM_LEGION then
				ply:SetModel("models/player/cl/military/legiondecanus.mdl")
			end
		end)
	end
end)

hook.Add("PlayerSpawn", "CustomCollision", function(ply)
	ply:SetAvoidPlayers(true)
end)

local spawns = {
	Vector(-9699.635742, 10491.600586, 0),
	Vector(-9714.706055, 10872.917969, 0),
	Vector(-9645.129883, 11391.000977, 0),
	Vector(-9629.105469, 11821.671875, 0),
	Vector(-9452.132813, 12256.891602, 0),
	Vector(-9008.140625, 12391.637695, 0),
	Vector(-8616.585938, 12189.718750, 0),
	Vector(-8152.212402, 12078.282227, 0),
	Vector(-7724.280273, 12205.328125, 0),
	Vector(-7329.865723, 12364.844727, 0),
	Vector(-7027.660645, 12109.272461, 0),
	Vector(-7041.941895, 11694.831055, 0),
	Vector(-7219.763184, 11266.451172, 0),
	Vector(-7118.461914, 10881.824219, 0),
	Vector(-7482.042480, 10680.794922, 0),
	Vector(-7657.836426, 10354.350586, 0),
	Vector(-7832.329590, 10004.724609, 0),
}
hook.Add("PlayerSpawn", "SpawnPoints", function(ply)
	timer.Simple(0.5, function()
		ply:SetPos(table.Random(spawns) + Vector(0, 0, 30))
	end)
end)

// Loadout
hook.Add("PlayerLoadout", "playerLoadout", function(ply)
	ply:Give("rphands")
	
	
	
	// No default loadout
	//return true
end)

hook.Add("PlayerSpawnProp", "disableProps", function(ply)
	if ply:SteamID() == "STEAM_0:1:20515109" then
		return true
	end
	
	return false
end)

hook.Add("CanTool", "disableToolgun", function(ply)
	if ply:SteamID() == "STEAM_0:1:20515109" then
		return true
	end
	
	return false
end)

hook.Add("PlayerShouldTakeDamage", "SpawnTeamKill", function(victim, attacker)
	if victim.spawnProtected then
		if IsValid(attacker) and attacker:IsPlayer() then
			attacker:notify("That player is spawn protected.", NOTIFY_ERROR)
		end
		return false
	elseif attacker.spawnProtected then
		attacker:notify("You are spawn protected.", NOTIFY_ERROR)
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
		for k,v in pairs(ents.FindInBox(SAFEZONE_START, SAFEZONE_END)) do
			if IsValid(v) and v:IsPlayer() then
				v.spawnProtected = true
				
				if !v.onSpawnTimer then
					v.onSpawnTimer = true
					
					timer.Simple(10, function()
						if IsValid(v) then
							if !table.HasValue(ents.FindInBox(SAFEZONE_START, SAFEZONE_END), v) then
								v.spawnProtected = false
							end
							v.onSpawnTimer = false
						end
					end)
				end
			end
		end
	end)
end)