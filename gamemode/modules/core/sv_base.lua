
hook.Add("EntityTakeDamage", "ModifyDamage", function(target, dmgInfo)
	local inflictor = dmgInfo:GetInflictor()
	local attacker = dmgInfo:GetAttacker()
	local damage = dmgInfo:GetDamage()
	local damageType = dmgInfo:GetDamageType()
	
	if IsValid(attacker) and attacker:IsPlayer() then
		local weapon = attacker:GetActiveWeapon()
		local weaponSlot = weapon.slot
		
		local item = attacker.equipped.weapons[weaponSlot] // The actual item that the player is equipping
		if item then
			local uniqueid = item.uniqueid
			local classid = item.classid
			
			local damageType = getWeaponType(classid)
			local critChance = getWeaponCriticalChance(classid)
			
			damage = attacker:getWeaponDamage(uniqueid)
			
			if util.roll(critChance + (critChance * attacker:getAgilityCriticalHitChance())) then
				damage = (damage * CRITICAL_MULTIPLIER)
				damage = damage + (damage * attacker:getPerceptionCriticalHitDamage())
			end
			
			// Unarmed and Explosives will need to be handled seperately
			if damageType == DMG_BULLET then
				damage = damage + (damage * attacker:getGunsDamage())
			elseif damageType == DMG_ENERGYBEAM then
				damage = damage + (damage * attacker:getEnergyWeaponsDamage())
			elseif damageType == DMG_SLASH then
				damage = damage + (damage * attacker:getMeleeWeaponsDamage())
			elseif damageType == DMG_PLASMA then
				damage = damage + (damage * attacker:getScienceDamage())
			end
		end

		dmgInfo:SetDamage(damage)
	end
end)

hook.Add("PlayerSpawn", "SetupPlayer", function(ply)
	timer.Simple(1, function()
		ply:SetHealth(ply:getMaxHealth())
	end)
end)