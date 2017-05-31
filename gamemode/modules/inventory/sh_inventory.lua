
//Shared

local meta = FindMetaTable("Player")

// Get the max space the player can hold in inventory
function meta:getMaxInventory()
	return INVENTORY_WEIGHT + self:getStrengthInventory()
end

function meta:hasInventoryItem(type, classid)
	if isAmmo(classid) or isAid(classid) or isMisc(classid) then // The item has quantity and is stackable
		for uniqueid, item in pairs(self.inventory[type]) do
			if item.classid == classid then
				return uniqueid
			end
		end
	end

	return false
end

function meta:getInventoryItem(uniqueid, classid)
	for k,v in pairs(self.inventory[classidToStringType(classid)]) do
		if k == uniqueid then
			return v
		end
	end
end

function meta:getInventoryWeight()
	local weight = 0

	// Total weight of weapon items
	for type, item in pairs(self.inventory) do
		for uniqueid, itemInfo in pairs(item) do
			if util.greaterThanOne(itemInfo.quantity) then
				weight = weight + (getItemWeight(itemInfo.classid) * itemInfo.quantity)
			else
				weight = weight + getItemWeight(itemInfo.classid)
			end
		end
	end

	return weight
end

function meta:getMaxQuantity(item)
	local singleWeight = getItemWeight(item.classid)
	local totalWeight = 0
	local itemCount = 0

	for i = 1, item.quantity do
		totalWeight = totalWeight + singleWeight

		if self:getInventoryWeight() + totalWeight <= self:getMaxInventory() then
			itemCount = itemCount + 1
		else
			return itemCount
		end
	end

	return itemCount
end

function meta:canInventoryFit(item, quantity)
	// There is no limit to amount of caps one can carry
	if isCap(item.classid) then
		return true
	end

	local addedWeight = getItemWeight(item.classid)
	if util.positive(quantity) then
		addedWeight = quantity * addedWeight
	end

	if self:getInventoryWeight() + addedWeight <= self:getMaxInventory() then // If the item (and/or specificied quantity) can fit
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
			return (v.quantity or 1), v.uniqueid
		end
	end

	return 0
end
