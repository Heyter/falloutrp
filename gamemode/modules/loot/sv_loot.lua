
//Server
util.AddNetworkString("loot")
util.AddNetworkString("lootItem")

local meta = FindMetaTable("Player")

// Beginning new implemntation
function generateRandomLoot(possibleItems, lvl, chest, luckModifier)
	local loot = {}
	local rarities = getRarityWorld()
	luckModifier = luckModifier or 0
	if chest then
		luckModifier = luckModifier + .75
	end

	for k = 0, possibleItems do
		local roll = math.random(1, 6000)

		for i = RARITY_ORANGE, RARITY_WHITE, -1 do
			local chance = rarities[i]

			// Only increase rarity of non-white items
			if i != RARITY_WHITE then
				chance = math.ceil(chance + (chance * luckModifier))
			end

			if roll <= chance then
				local lootTable = LOOT_STRUCTURE[lvl][i]
				local item = createItem(lootTable[math.random(1, #lootTable)])

				table.insert(loot, #loot + 1, item)
				break
			end
		end
	end


	return loot
end

function meta:loot(ent)
	if self:inLootRange(ent) then
		if ent:GetClass() == "factory" then
			if ent:hasLoot(self) then
				net.Start("loot")
					net.WriteEntity(ent)
					net.WriteTable(ent:getLoot(self))
				net.Send(self)
			else
				self:notify("This factory has no items available for you yet.", NOTIFY_ERROR, 5)
			end
		else
			if ent:hasLoot() then
				net.Start("loot")
					net.WriteEntity(ent)
					net.WriteTable(ent:getLoot())
				net.Send(self)
			end
		end
	end
end

function meta:lootItem(ent, itemId, quantity)
	if self:Alive() and self:inLootRange(ent) then
		if ent:hasItem(itemId, quantity, self) then
			local item = table.Copy(ent:getItem(itemId, self))
			local itemMeta = findItem(item.classid)

			// Handle quest items seperately
			if itemMeta:getQuest() then
				local looted = self:lootQuestItem(item.classid, quantity)
				if looted then
					ent:removeItem(itemId, looted, self)
				elseif looted == false then
					self:notify("You have no use for this now.", NOTIFY_ERROR)
				end

				return
			end

			local canFit = self:canInventoryFit(item, quantity)

			if util.positive(canFit) then
				quantity = canFit
			elseif canFit != true then // Can't fit any amount of the item into inventory
				self:notify("You cannot fit anymore items in your inventory!", NOTIFY_ERROR)
				return
			end

			// Remove the item
			ent:removeItem(itemId, quantity, self)

			// Add the item to the player
			self:pickUpItem(item, quantity)

			// Go back to looting
			self:loot(ent)
		else
			self:notify("That item is no longer available.", NOTIFY_ERROR)
			self:loot(ent)
		end
	else
		self:notify("Loot is no longer available.", NOTIFY_ERROR)
	end
end

function meta:inLootRange(ent)
	return IsValid(ent) and self:GetPos():Distance(ent:GetPos()) <= LOOT_RANGE
end

function createLoot(position, items)
	local loot = ents.Create("loot")
	loot:SetPos(position + Vector(0, 0, 25))
	loot:Spawn()
	for k,v in pairs(items) do
		loot:addItem(v)
	end
	loot:DropToFloor()
end

net.Receive("lootItem", function(len, ply)
	local ent = net.ReadEntity()
	local itemId = net.ReadInt(16)
	local quantity = net.ReadInt(16)

	ply:lootItem(ent, itemId, quantity)
end)
