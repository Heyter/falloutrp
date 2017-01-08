
//Server
util.AddNetworkString("loot")
util.AddNetworkString("lootItem")

local meta = FindMetaTable("Player")

function meta:loot(ent)
	print(3)
	if self:inLootRange(ent) then
		print(4)
		if ent:GetClass() == "factory" then
			print(5)
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
			
			print("Printing item:")
			PrintTable(item)
			print("Quantity: " ..quantity)
			print("---")
			
			// Remove the item
			ent:removeItem(itemId, quantity, self)
				
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
		print(v)
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