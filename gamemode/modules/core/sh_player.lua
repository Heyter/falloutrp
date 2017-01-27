
local defaultRun = RUN_SPEED
local defaultWalk = WALK_SPEED
local defaultSprint = SPRINT_LENGTH

local MOVEMENT_SPEED_AGILITY = MOVEMENT_SPEED_AGILITY
local SPRINT_AMOUNT_ENDURANCE = SPRINT_AMOUNT_ENDURANCE

function plyDataExists(ply)
	return ply and ply.playerData and ply.equipped
end

local meta = FindMetaTable("Player")

function meta:getName()
	return (self.playerData and self.playerData.name) or self:getNick()
end

function meta:getMaxRunSpeed()
	return defaultRun + (self:getSkill("agility") * MOVEMENT_SPEED_AGILITY)
end

function meta:getMaxWalkSpeed()
	return defaultWalk + (self:getSkill("agility") * MOVEMENT_SPEED_AGILITY)
end

function meta:getMaxSprintLength()
	return defaultSprint + (self:getSkill("endurance") * SPRINT_AMOUNT_ENDURANCE)
end

function meta:getMaxHealth()
	return MAX_HEALTH + self:getItemHealth() + self:getStrengthHealth() + self:getFactionHitpoints()
end