
hook.Add("EntityTakeDamage", "ModifyDamage", function(target, dmgInfo)
	local inflictor = dmgInfo:GetInflictor()
	local attacker = dmgInfo:GetAttacker()
	local damageType = dmgInfo:GetDamageType()
	local damage = dmgInfo:GetDamage()
	if IsValid(attacker) and IsValid(target) then
		if attacker:IsPlayer() then
			if attacker.spawnProtected then
				damage = 0

				if !attacker.lastSpawnProtectionNotify || (attacker.lastSpawnProtectionNotify < CurTime()) then
					attacker:notify("You can't damage others while spawn protected.", NOTIFY_ERROR)

					attacker.lastSpawnProtectionNotify = CurTime() + 3
				end
			else
				// Add Damage
				local weapon = attacker:GetActiveWeapon()
				local weaponSlot = weapon.slot

				local item = attacker.equipped.weapons[weaponSlot] // The actual item that the player is equipping
				if item then
					local uniqueid = item.uniqueid
					local classid = item.classid

					damageType = getWeaponType(classid)
					local critChance = getWeaponCriticalChance(classid)

					damage = attacker:getWeaponDamage(uniqueid)

					if util.roll(critChance + (critChance * attacker:getAgilityCriticalHitChance())) then
						damage = (damage * CRITICAL_MULTIPLIER)
						damage = damage + (damage * (attacker:getPerceptionCriticalHitDamage() + attacker:getFactionCriticalHitDamage()))
					end

					// Unarmed and Explosives will need to be handled seperately
					if damageType == DMG_BULLET then
						damage = damage + (damage * (attacker:getGunsDamage() + attacker:getFactionGunsDamage()))
					elseif damageType == DMG_ENERGYBEAM then
						damage = damage + (damage * (attacker:getEnergyWeaponsDamage() + attacker:getFactionEnergyWeaponsDamage()))
					elseif (damageType == DMG_SLASH) or (damageType == DMG_CLUB) then
						damage = damage + (damage * (attacker:getMeleeWeaponsDamage() + attacker:getFactionMeleeWeaponsDamage()))
					elseif damageType == DMG_PLASMA then
						damage = damage + (damage * attacker:getScienceDamage())
					end
				end
			end

			if target:IsPlayer() then
				// Reduce Damage
				damage = damage + (damage * (target:getDamageThreshold() / 100))

				// Reflect Damage
				local damageReflect = damage * (target:getDamageReflection() / 100)
				// Make the inflictor worldspawn, so damage reflection isn't a stack overflow
				if (damageReflect > 0) and (inflictor != Entity(0)) then
					attacker:TakeDamage(damageReflect, target, Entity(0))
				end

				// Head bob
				if damageType == DMG_CLUB then
					target:headBob()
				end

				if damageType == DMG_SLASH then
					attacker:bleedAttack(target, damage)
				end
			elseif target:IsNPC() then
				npcOutOfRange(target, attacker)
			end
		elseif attacker:IsNPC() then
			attacker.lastHit = CurTime()
		end

		dmgInfo:SetDamage(damage)
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

			// Initialize health regen
			ply:startHealthRegen()

			// Ask Pvp protection
			ply:pvpProtection()

			if ply:Team() == TEAM_BOS then
				ply:SetModel("models/player/nikout/fallout/wintercombatarmormale.mdl")
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
	return true
end)
