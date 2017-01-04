
//Server
util.AddNetworkString("loot")
util.AddNetworkString("lootItem")

local meta = FindMetaTable("Player")

function meta:loot(ent)
	if self:inLootRange(ent) and ent:hasLoot() then
		net.Start("loot")
			net.WriteEntity(ent)
			net.WriteTable(ent:getLoot())
		net.Send(self)
	end
end

function meta:lootItem(ent, itemId, quantity)
	if self:Alive() and self:inLootRange(ent) then
		if ent:hasItem(itemId) then
			local item = ent:getItem(itemId)

			local canFit = self:canInventoryFit(item, quantity)
			
			if isnumber(canFit) and util.positive(canFit) then 
				quantity = canFit
			elseif canFit != true then // Can't fit any amount of the item into inventory
				return
			end
			
			print(quantity)
			
			// Remove the item
			ent:removeItem(itemId, quantity)
				
			// Add the item to the player
			self:pickUpItem(item, quantity)
				
			// Go back to looting
			self:loot(ent)
		end
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
	local quantity = net.ReadInt(8)
	
	ply:lootItem(ent, itemId, quantity)
end)