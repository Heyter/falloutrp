
//Server
util.AddNetworkString("loot")
util.AddNetworkString("lootItem")

local meta = FindMetaTable("Player")

function generateRandomLoot(chest)
	local loot = {}
	
	for k,v in pairs(LOOT) do
		if chest then
			prob = prob * 2
		end
		
		local prob = v.prob
		local quantity = v.quantity
		
		if util.roll(prob, 1000) then
			table.insert(loot, createItem(k, v.quantity))
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

			local canFit = self:canInventoryFit(item, quantity)
			
			if util.positive(canFit) then 
				quantity = canFit
			elseif canFit != true then // Can't fit any amount of the item into inventory
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
	local itemId = net.ReadInt(8)
	local quantity = net.ReadInt(16)
	
	ply:lootItem(ent, itemId, quantity)
end)