util.AddNetworkString("damagePopup")

local meta = FindMetaTable("Player")

hook.Add("EntityTakeDamage", "ModifyDamage", function(target, dmgInfo)
	local inflictor = dmgInfo:GetInflictor()
	local attacker = dmgInfo:GetAttacker()
	local damageType = dmgInfo:GetDamageType()
	local damage = dmgInfo:GetDamage()

	local crit, drawMarker = false, false

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
					local itemMeta = findItem(item.classid)
					local uniqueid = item.uniqueid

					damageType = itemMeta:getType()
					local critChance = itemMeta:getCriticalChance()
					damage = attacker:getWeaponDamage(uniqueid)

					if util.roll(critChance + (critChance * attacker:getAgilityCriticalHitChance())) then
						crit = true

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

				if attacker:IsPlayer() then
					// Head bob
					if damageType == DMG_CLUB then
						target:headBob()
					end

					if damageType == DMG_SLASH then
						attacker:bleedAttack(target, damage)
					end

					drawMarker = true
				end
			elseif target:IsNPC() then
				// Increase damage against NPCs by 25%
				damage = damage * 1.25

				if npcOutOfRange(target, attacker) then
					attacker:sendDmg(target, -99, damageType, dmgInfo)
					damage = 0
				end

				drawMarker = true
			end
		elseif attacker:IsNPC() then
			attacker.lastHit = CurTime()
		end

		if attacker:IsPlayer() and !attacker.spawnProtected and drawMarker then
			attacker:sendDmg(target, damage, damageType, dmgInfo, crit)
		end

		dmgInfo:SetDamage(damage)
	end
end)

function meta:headBob()
    if util.roll(1, 3) then
        self:ViewPunch(Angle(math.random(10, 70), math.random(-5, -5), math.random(-170, 170)))
    end
end

function meta:bleedAttack(ent, damage)
    if util.roll(1, 3) and !ent.bleedTime and !ent.pvpProtected then
        ent.bleedTime = 5
        ent.bleedDamage = math.floor(damage / 5)
        ent.bleedAttacker = self

        timer.Simple(1, function()
            if IsValid(ent) then
                ent:bleed()
            end
        end)
    end
end

function meta:bleed()
    if IsValid(self) and self:Health() > 0 then
        self:TakeDamage(self.bleedDamage)
        self:EmitSound("player/pl_pain7.wav")

        self.bleedTime = self.bleedTime - 1

        if self.bleedTime > 0 then
            timer.Simple(1, function()
                self:bleed()
            end)
        else
            self.bleedTime = nil
        end
    end
end

function meta:sendDmg(ent, dmg, dmgType, dmgInfo, crit)
    local pos = nil
    if dmgInfo:IsBulletDamage() then
        pos = dmgInfo:GetDamagePosition()
    elseif (dmgType == DMG_CLUB or dmgType == DMG_SLASH) then
        pos = util.TraceHull({
            start  = self:GetShootPos(),
            endpos = self:GetShootPos() + (self:GetAimVector() * 100),
            filter = self,
            mins   = Vector(-10,-10,-10),
            maxs   = Vector( 10, 10, 10),
            mask   = MASK_SHOT_HULL,
        }).HitPos
    end

    if pos == nil then
        pos = ent:LocalToWorld(ent:OBBCenter())
    end

    local force = nil
    if dmgInfo:IsExplosionDamage() then
        force = dmgInfo:GetDamageForce() / 4000
    else
        force = -dmgInfo:GetDamageForce() / 1000
    end
    force.x = math.Clamp(force.x, -1, 1)
    force.y = math.Clamp(force.y, -1, 1)
    force.z = math.Clamp(force.z, -1, 1)


    net.Start("damagePopup")
        net.WriteEntity(ent)
        net.WriteInt(dmg, 16)
        net.WriteVector(pos)
        net.WriteVector(force)
        net.WriteBool(crit)
    net.Send(self)
end
