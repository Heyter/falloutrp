
function spawnChest(inactiveChests)
	PrintTable(inactiveChests)
	local randomLocation = table.Random(inactiveChests)
	local location = CHEST_LOCATIONS[randomLocation]
	
	local chest = ents.Create("chest")
	chest:SetPos(location["Position"])
	chest:SetAngles(location["Angles"])
	
	CHEST_LOCATIONS[randomLocation]["Active"] = true // Set the location to active
	chest.key = randomLocation // So we know which location to set inactive when the chest is gone
	
	local randomLocked = math.random(1, 3)
	if randomLocked == 1 then
		// Make the chest locked
		chest:lock(1) //Lock the chest and make it require level 1 lockpicking
	end
	
	for k,v in pairs(LOOT) do
		local roll = math.random(1, 100)
		
		if roll <= v.prob then
			chest:addItem(createItem(v.id, v.quantity))
		end
	end
	
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
	beginChestTimer()
end)	