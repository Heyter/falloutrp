
local meta = FindMetaTable("Player")

function meta:getSkillPoints()
	return self.playerData.skillpoints
end

// -----Registration Skills-----
function meta:getSkill(skill)
	return self.playerData[skill]
end


// Stength
function meta:getStrengthHealth()
	local strength = self:getSkill("strength")
	local bonus = 0
	
	return bonus + (strength * HEALTH_PER_STRENGTH)
end

function meta:getStrengthInventory()
	local strength = self:getSkill("strength")
	local bonus = 0
	
	return bonus + (strength * INVENTORY_PER_STRENGTH)
end

// Perception
function meta:getPerceptionRecoil()
	local perception = self:getSkill("perception")
	local reduced = 0
	
	return reduced + (perception * RECOIL_PER_PERCEPTION)
end

function meta:getPerceptionCriticalHitDamage()
	local perception = self:getSkill("perception")
	local bonus = 0
	
	return bonus + (perception * CRITICALHITDAMAGE_MULTIPLIER_PERCEPTION)
end

// Endurance
function meta:getEnduranceHealthRegen()
	local endurance = self:getSkill("endurance")
	local bonus = 0
	
	return bonus + (endurance * HEALTHREGEN_MULTIPLIER_ENDURANCE)
end

// Charisma
function meta:getCharismaPriceScale()
	local charisma = self:getSkill("charisma")
	local bonus = 0
	
	return bonus + (perception * PRICE_MULTIPLIER_CHARISMA)
end

// Intelligence
function meta:getIntelligenceRestore()
	local intelligence = self:getSkill("intelligence")
	local bonus = 0
	
	return bonus + (intelligence * RESTORE_EFFECTS_INTELLIGENCE)
end

// Agility
function meta:getAgilityCriticalHitChance()
	local agility = self:getSkill("agility")
	local bonus = 0
	
	return bonus + (agility * CRITICALHITCHANCE_MULTIPLIER_AGILITY)
end

function meta:getAgilityMovementSpeed()
	local agility = self:getSkill("agility")
	local bonus = 0
	
	return bonus + (agility * CRITICALHITCHANCE_MULTIPLIER_AGILITY)
end

// Luck
function meta:getLuckModifier()
	local luck = self:getSkill("luck")
	local bonus = 0
	
	return bonus + (luck * PROBABILITY_MULTIPLIER_LUCK)
end

// -----Skills-----

// Barter
function meta:getBarterPriceScale()
	local barter = self:getSkill("barter")
	local bonus = 0
	
	return bonus + (barter * PRICE_MULTIPLIER_BARTER)
end

// Energy Weapons
function meta:getEnergyWeaponsDamage()
	local energyweapons = self:getSkill("energyweapons")
	local bonus = 0
	
	return bonus + (barter * DAMAGE_MULTIPLIER_ENERGYWEAPONS)
end

// Explosives
function meta:getExplosivesDamage()
	local explosives = self:getSkill("explosives")
	local bonus = 0
	
	return bonus + (explosives * DAMAGE_MULTIPLIER_EXPLOSIVES)
end

// Guns
function meta:getGunsDamage()
	local guns = self:getSkill("guns")
	local bonus = 0
	
	return bonus + (guns * DAMAGE_MULTIPLIER_GUNS)
end

// Lockpick

// Medicine
function meta:getMedicineHealth()
	local medicine = self:getSkill("medicine")
	local bonus = 0
	
	return bonus + (medicine * HEALTH_MULTIPLIER_MEDICINE)
end

// Melee Weapons
function meta:getMeleeWeaponsDamage()
	local meleeweapons = self:getSkill("meleeweapons")
	local bonus = 0
	
	return bonus + (meleeweapons * DAMAGE_MULTIPLIER_MELEEWEAPONS)
end

// Repair

// Science
function meta:getScienceDamage()
	local science = self:getSkill("science")
	local bonus = 0
	
	return bonus + (science * DAMAGE_MULTIPLIER_SCIENCE)
end

// Sneak

// Speech

// Survival
function meta:getSurvivalNpcDamage()
	local survival = self:getSkill("survival")
	local bonus = 0
	
	return bonus + (survival * NPCDAMAGE_MULTIPLIER_SURVIVAL)
end

// Unarmed
function meta:getUnarmedDamage()
	local unarmed = self:getSkill("unarmed")
	local bonus = 0
	
	return bonus + (unarmed * DAMAGE_MULTIPLIER_UNARMED)
end
