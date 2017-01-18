
//Shared

local meta = FindMetaTable("Player")

function meta:getInventoryWeight()
	local weight = 0
	
	// Total weight of weapon items
	for type, item in pairs(self.inventory) do
		for uniqueid, itemInfo in pairs(item) do
			weight = weight + getItemWeight(itemInfo.classid)
		end
	end
	
	return weight
end

function meta:getMaxQuantity(item)
	local singleWeight = self:getItemWeight(item.classid)
	local totalWeight = 0
	local itemCount = 0

	for i = 1, item.quantity do
		totalWeight = totalWeight + singleWeight
		
		if self:getInventoryWeight() + totalWeight <= INVENTORY_WEIGHT then
			itemCount = itemCount + 1
		else
			return itemCount
		end
	end
	
	return itemCount
end

function meta:canInventoryFit(item, quantity)
	local addedWeight = getItemWeight(item.classid)
	if util.positive(quantity) then
		addedWeight = quantity * addedWeight
	end

	if self:getInventoryWeight() + addedWeight <= INVENTORY_WEIGHT then // If the item (and/or specificied quantity) can fit
		return true
	elseif util.positive(quantity) then // If it's multiple items and can't fit them all, return the max amount of items that can fit
		return self:getMaxQuantity(item)
	end
	
	return false
end

// Get the amount of specific item that a player has
function meta:getInventoryCount(id)
	local type = classidToStringType(id)

	for k,v in pairs(self.inventory[type]) do
		if v.classid == id then
			PrintTable(v)
			return (v.quantity or 1), v.uniqueid
		end
	end
	
	return 0
end