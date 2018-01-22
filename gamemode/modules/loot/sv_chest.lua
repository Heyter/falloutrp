
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

function spawnChest(chest, model, inactiveChests)
	local randomLocation = table.Random(inactiveChests)
	local location = chest.locations[randomLocation]

	local newChest = ents.Create("chest")
	newChest:SetPos(location["Position"])
	newChest:SetAngles(location["Angles"])
	newChest:SetModel(model)

	chest.locations[randomLocation]["Active"] = true
	newChest.key = randomLocation // So we know which location to set inactive when the chest is gone

	local lvl = 1

	if chest.lockable then
		local randomLocked = util.roll(50, 100) // 50% chance to be locked
		if randomLocked then
			lvl = generateLevel()
			newChest:lock(lvl)
		end
	end

	newChest:Spawn()

	lvl = generateLootLevel(lvl)

	local loot = generateRandomLoot(math.random(chest.minItems, chest.maxItems), lvl, chest.modifier)
	for k, v in pairs(loot) do
		newChest:addItem(v)
	end
end

function spawnDummyChest()
	local chest = ents.Create("chest")
	chest:SetPos(Vector(-9376, 1363, 139))
	chest:SetAngles(Angle(0, 90, 0))
	chest:SetModel("models/props/cs_militia/footlocker01_closed.mdl")
	chest:lock(1)
	chest.isFake = true

	chest:Spawn()
end

function getActiveChests(locations)
	local active = 0
	local inactive = {}

	for k, v in pairs(locations) do
		if v.Active then
			active = active + 1
		else
			table.insert(inactive, k)
		end
	end

	return active, inactive
end

function addChest(chest, model)
	local limit = chest.limit
	local numActive, inactiveChests = getActiveChests(chest.locations)

	if numActive < limit then
		// If we haven't hit the limit for amount of chests on the map
		spawnChest(chest, model, inactiveChests)
	end
end

function beginChestTimer()
	for model, v in pairs(CHESTS) do
		timer.Create(model .."_chestSpawn", v.timer, 0, function()
			addChest(v, model)
		end)
	end
end

hook.Add("InitPostEntity", "startChestTimer", function()
	timer.Simple(1, function()
		beginChestTimer()
		spawnDummyChest()
	end)
end)
