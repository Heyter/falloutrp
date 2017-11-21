
local meta = FindMetaTable("Player")

// Get the max space the player can hold in inventory
function meta:getMaxBank()
	return BANK_WEIGHT + self:getVipBankIncrease()
end

function meta:hasBankItem(type, classid)
	if isAmmo(classid) or isAid(classid) or isMisc(classid) then // The item has quantity and is stackable
		for uniqueid, item in pairs(self.bank[type]) do
			if item.classid == classid then
				return uniqueid
			end
		end
	end

	return false
end

function meta:getBankWeight()
	local weight = 0

	// Total weight of weapon items
	for type, item in pairs(self.bank) do
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

function meta:getMaxBankQuantity(classid, quantity)
	local singleWeight = getItemWeight(classid)
	local totalWeight = 0
	local itemCount = 0

	for i = 1, quantity do
		totalWeight = totalWeight + singleWeight

		if self:getBankWeight() + totalWeight <= self:getMaxBank() then
			itemCount = itemCount + 1
		else
			return itemCount
		end
	end

	return itemCount
end

function meta:canBankFit(classid, quantity)
	local addedWeight = getItemWeight(classid)
	if util.positive(quantity) then
		addedWeight = quantity * addedWeight
	end

	if self:getBankWeight() + addedWeight <= self:getMaxBank() then // If the item (and/or specificied quantity) can fit
		return true
	elseif util.positive(quantity) then // If it's multiple items and can't fit them all, return the max amount of items that can fit
		return self:getMaxBankQuantity(classid, quantity)
	end

	return false
end
