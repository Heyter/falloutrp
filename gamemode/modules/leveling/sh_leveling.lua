


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

function meta:getCraftingUnlockables(level)
	local output = "RECIPES\n"
	local defaultLength = #output
	
	local extra = ""
	local line = 0
	
	for type, recipe in pairs(RECIPES) do
		for k, info in pairs(recipe) do
			if info.level == level then
				if line > 2 then
					extra = extra .."\n" ..getItemName(info.classid)
					line = 0
				else
					extra = extra ..", " ..getItemName(info.classid)
				end
				line = line + 1
			end
		end
	end
	
	extra = string.Trim(extra, ",")
	output = output ..extra
	// Dont return the recipes header if there weren't any recipes unlocked at this level
	if #output > defaultLength then
		return output .."\n\n"
	else
		return ""
	end
end

function meta:getWeaponUnlockables(level)
	local output = "WEAPONS\n"
	local defaultLength = #output

	local extra = ""
	local line = 0
	
	for id, weapon in pairs(getWeapons()) do
		if weapon.level == level then
			if line > 2 then
				extra = extra .."\n" ..weapon.name
				line = 0
			else
				extra = extra ..", " ..weapon.name
			end
			line = line + 1
		end
	end
	
	extra = string.Trim(extra, ",")
	output = output ..extra
	// Dont return the weapons header if there weren't any weapons unlocked at this level
	if #output > defaultLength then
		return output .."\n\n"
	else
		return ""
	end
end

function meta:getApparelUnlockables(level)
	local output = "APPAREL\n"
	local defaultLength = #output

	local extra = ""
	local line = 0
	
	for id, apparel in pairs(getApparel()) do
		if apparel.level == level then
			if line > 2 then
				extra = extra .."\n" ..apparel.name
				line = 0
			else
				extra = extra ..", " ..apparel.name
			end
			line = line + 1
		end
	end
	
	extra = string.Trim(extra, ",")
	output = output ..extra
	// Dont return the apparel header if there weren't any apparel unlocked at this level
	if #output > defaultLength then
		return output .."\n\n"
	else
		return ""
	end
end

function meta:getUnlockables(level)
	local output = "" ..self:getWeaponUnlockables(level) ..self:getApparelUnlockables(level) ..self:getCraftingUnlockables(level)
	
	if #output > 0 then
		output = "UNLOCKED\n\n" ..output
	end
	
	return output
end

// Levels and Experience creation
local minLevel = 2
local points = 0
local output = 0
for i = 1, MAX_LEVEL do
	points = ((25 * (3 * i + 2) * (i - 1)) + (LEVELS[i-1] or 0))
	
	LEVELS[i] = points
end

function expToLevel(exp)
	local highestLevel

	for level, xp in pairs(LEVELS) do
		if exp >= xp then
			highestLevel = level
		else
			return highestLevel
		end
	end
	
	return highestLevel //Return here incase you are max level
end

