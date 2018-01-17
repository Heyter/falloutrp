
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

	return math.random(1, maxLockpicking)
end

function generateLootLevel(level)
	if level <= 33 then
		return 15
	elseif level <= 66 then
		return 30
	else
		return 50
	end
end

function spawnChest(inactiveChests)
	local randomLocation = table.Random(inactiveChests)
	local location = CHEST_LOCATIONS[randomLocation]

	local chest = ents.Create("chest")
	chest:SetPos(location["Position"])
	// Offset for new chest model, need to later go back and chest chest angles
	chest:SetAngles(location["Angles"] + Angle(0, 90, 0))

	CHEST_LOCATIONS[randomLocation]["Active"] = true // Set the location to active
	chest.key = randomLocation // So we know which location to set inactive when the chest is gone

	local randomLocked = util.roll(50, 100) // 50% chance to be locked
	local lvl = 1
	if randomLocked then
		// Make the chest locked
		lvl = generateLevel()
		chest:lock(lvl)
	end

	chest:Spawn()

	lvl = generateLootLevel(lvl)

	local loot = generateRandomLoot(math.random(10, 20), lvl, true)
	for k,v in pairs(loot) do
		chest:addItem(v)
	end

	// Add a stimpack by default
	chest:addItem(createItem(4001, 1))
end

function spawnDummyChest()
	local chest = ents.Create("chest")
	chest:SetPos(Vector(-9376, 1363, 139))
	// Offset for new chest model, need to later go back and chest chest angles
	chest:SetAngles(Angle(0, 90, 0) + Angle(0, 90, 0))
	chest:lock(1)
	chest.isFake = true

	chest:Spawn()
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
		spawnDummyChest()
	end)
end)

/*
function spawnAllChests()
	for k,v in pairs(CHEST_LOCATIONS) do
		local chest = ents.Create("chest")
		chest:SetPos(v.Position)
		chest:SetAngles(v.Angles)
		chest:Spawn()
	end
end
*/
