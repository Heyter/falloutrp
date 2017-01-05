
//Shared

local meta = FindMetaTable("Player")

function meta:getInventoryWeight()
	local weight = 0
	
	// Total weight of weapon items
	for k,items in pairs(self.inventory.weapons) do
		weight = weight + getWeaponWeight(items.classid)
	end
	// Total weight of misc items
	weight = weight + self:getMiscWeightTotal()
	
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