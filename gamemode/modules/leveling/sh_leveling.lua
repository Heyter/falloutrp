


LEVELS = {0}

local meta = FindMetaTable("Player")

function meta:getExp()
	return self.playerData.experience
end

function meta:getLevel()
	return expToLevel(self:getExp())
end

function meta:getCurrentLevelExp()
	return LEVELS[self:getLevel()]
end	

function meta:getNextLevelExp()
	local currentLevel = self:getLevel()

	if currentLevel == MAX_LEVEL then
		return LEVELS[currentLevel] // Return exp of current level since there are no more levels above you
	else
		return LEVELS[currentLevel + 1]
	end
end

// Levels and Experience creation
local minLevel = 2
local points = 0
local output = 0
for i = 1, MAX_LEVEL do
	points = points + math.floor(i + 300 * math.pow(2, i/7))
	
	if i >= minLevel then
		LEVELS[i] = output
	end
	
	output = math.floor(points/4)
end

function expToLevel(exp)
	local highestLevel

	for level, xp in pairs(LEVELS) do
		if exp >= xp then
			highestLevel = level
		else
			return  highestLevel
		end
	end
	
	return highestLevel //Return here incase you are max level
end

