
LEVELS = {0}

local minLevel, maxLevel = 2, 50
local points = 0
local output = 0
for i = 1, maxLevel do
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