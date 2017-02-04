
local differential = 10 // How much the random lockpick level can be above the max level (to encourage players to increase the lockpicking level)
local function generateLevel()
	local maxLockpicking = 1
	
	for k,v in pairs(player.GetAll()) do
		if v.loaded then
			local skillLvl = v:getSkill("lockpick")
			if skillLvl and skillLvl > maxLockpicking then
				maxLockpicking = skillLvl
			end
		end
	end
	
	if maxLockpicking + differential > 100 then
		maxLockpicking = 100
	else
		maxLockpicking = maxLockpicking + differential
	end
	
	return math.random(1, maxLockpicking)
end

function generateLootLevel(level)
	local lvl
	
	if level <= 33 then
		lvl = 15
	elseif level <= 66 then
		lvl = 30
	else
		lvl = 50
	end
	
	return lvl
end

function spawnChest(inactiveChests)
	local randomLocation = table.Random(inactiveChests)
	local location = CHEST_LOCATIONS[randomLocation]
	
	local chest = ents.Create("chest")
	chest:SetPos(location["Position"])
	chest:SetAngles(location["Angles"])
	
	CHEST_LOCATIONS[randomLocation]["Active"] = true // Set the location to active
	chest.key = randomLocation // So we know which location to set inactive when the chest is gone
	
	local randomLocked = util.roll(75, 100) // 75% chance to be locked
	local lvl = 1
	if randomLocked then
		// Make the chest locked
		lvl = generateLevel()
		chest:lock(lvl) // Lock the chest and make it require level 1 lockpicking
	end
	
	chest:Spawn()
	
	lvl = generateLootLevel(lvl)

	local loot = generateRandomLoot(lvl, true)
	for k,v in pairs(loot) do
		chest:addItem(v)
	end
	
	// Add a stimpack by default
	chest:addItem(createItem(4001, 1))
	
	print(chest:GetPos())
end

function getActiveChests()
	local active = 0
	local inactive = {}
	
	for k, v in pairs(CHEST_LOCATIONS) do
		if v.Active then
			active = active + 1
		else
			table.insert(inactive, k)
		end
	end
	
	return active, inactive
end

function addChest()
	local numActive, inactiveChests = getActiveChests()
		
	if numActive < CHEST_LIMIT then
		// If we haven't hit the limit for amount of chests on the map
		spawnChest(inactiveChests)
	end
end

function beginChestTimer()
	timer.Create("chestSpawn", CHEST_TIMER, 0, function()
		addChest()
	end)
end

hook.Add("InitPostEntity", "startChestTimer", function()
	timer.Simple(1, function()
		beginChestTimer()
	end)
end)	

/*
function teleKenny(ent)
	for k,v in pairs(CHEST_LOCATIONS) do
		timer.Simple(k * 15, function()
			ent:SetPos(v.Position)
		end)
	end
end
function spawnAllChests()
	for k,v in pairs(CHEST_LOCATIONS) do
		local chest = ents.Create("chest")
		chest:SetPos(v.Position)
		chest:SetAngles(v.Angles)
		chest:Spawn()
	end
end	
*/