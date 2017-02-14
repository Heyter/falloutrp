
local meta = FindMetaTable("Player")

local maxHunger = HUNGER_MAX or 0
local maxThirst = THIRST_MAX or 0

function meta:getHunger()
	return self.playerData.hunger or 0
end

function meta:getThirst()
	return self.playerData.thirst or 0
end

function meta:getHungerStatus()
	local hunger = self:getHunger()
	
	if hunger <= .2 * maxHunger then // Below 20%
		return "Starving", Color(255, 0, 0, 255)	
	elseif hunger <= .4 * maxHunger then // Below 40%
		return "Famished", Color(125, 95, 0, 255)		
	elseif hunger <= .6 * maxHunger then // Below 60%
		return "Hungry", Color(100, 120, 0, 255)
	elseif hunger <= .8 * maxHunger then // Below 80%
		return "Peckish", Color(65, 175, 0, 255)
	else // Above 80%
		return "Well fed", Color(0, 255, 0, 255)
	end
end
 
function meta:getThirstStatus()
	local thirst = self:getThirst()
	
	if thirst <= .2 * maxThirst then // Below 20%
		return "Severely Dehydrated", Color(255, 0, 0, 255)
	elseif thirst <= .4 * maxThirst then // Below 40%
		return "Dehydrated", Color(125, 95, 0, 255)	
	elseif thirst <= .6 * maxThirst then // Below 60%
		return "Thirsty", Color(100, 120, 0, 255)		
	elseif thirst <= .8 * maxThirst then // Below 80%
		return "Parched", Color(65, 175, 0, 255)
	else // Above 80%
		return "Well hydrated", Color(0, 255, 0, 255)
	end
end