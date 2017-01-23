
TEAM_BOS = 1
TEAM_NCR = 2
TEAM_LEGION = 3
TEAM_FACTIONLESS = 4

team.SetUp(TEAM_BOS, "Brotherhood of Steel", Color(255, 0, 0, 255))
team.SetUp(TEAM_NCR, "New California Republic", Color(0, 255, 0, 255))
team.SetUp(TEAM_LEGION, "Legion", Color(0, 0, 255, 255))
team.SetUp(TEAM_FACTIONLESS, "Factionless", Color(255, 255, 255, 255))

local meta = FindMetaTable("Player")

// -----Faction Bonuses-----

// Brotherhood of Steel
function meta:getFactionEnergyWeaponsDamage()
	local bonus = 0

	if self:Team() == TEAM_BOS then
		bonus = ENERGYWEAPONS_MULTIPLIER_FACTION
	end
	
	return bonus
end

function meta:getFactionDamageReduction()
	local bonus = 0
	
	if self:Team() == TEAM_BOS then
		bonus = DAMAGEREDUCTION_MULTIPLIER_FACTION
	end
	
	return bonus
end

// NCR
function meta:getFactionGunsDamage()
	local bonus = 0
	
	if self:Team() == TEAM_NCR then
		bonus = GUNS_MULTIPLIER_FACTION
	end
	
	return bonus
end

function meta:getFactionHitpoints()
	local bonus = 0
	
	if self:Team() == TEAM_NCR then
		bonus = HITPOINTS_AMOUNT_FACTION
	end
	
	return bonus
end

// Legion
function meta:getFactionMeleeWeaponsDamage()
	local bonus = 0
	
	if self:Team() == TEAM_LEGION then
		bonus = MELEEWEAPONS_MULTIPLIER_FACTION
	end
	
	return bonus
end

function meta:getFactionCriticalHitDamage()
	local bonus = 0
	
	if self:Team() == TEAM_LEGION then
		bonus = CRITICALHITDAMAGE_MULTIPLIER_FACTION
	end
	
	return bonus
end

function meta:getFactionCriticalHitChance()
	local bonus = 0
	
	if self:Team() == TEAM_LEGION then
		bonus = CRITICALHITCHANCE_MULTIPLIER_FACTION
	end
	
	return bonus
end
