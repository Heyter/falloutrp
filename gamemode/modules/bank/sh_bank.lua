
local meta = FindMetaTable("Player")

function meta:hasBankItem(type, classid)
	if isAmmo(classid) or isAid(classid) or isMisc(classid) then // The item has quantity and is stackable
		for uniqueid, item in pairs(self.inventory[type]) do
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

function meta:getMaxQuantity(classid, quantity)
	local singleWeight = self:getItemWeight(classid)
	local totalWeight = 0
	local itemCount = 0

	for i = 1, quantity do
		totalWeight = totalWeight + singleWeight
		
		if self:getBankWeight() + totalWeight <= BANK_WEIGHT then
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

	if self:getBankWeight() + addedWeight <= BANK_WEIGHT then // If the item (and/or specificied quantity) can fit
		return true
	elseif util.positive(quantity) then // If it's multiple items and can't fit them all, return the max amount of items that can fit
		return self:getMaxQuantity(classid, quantity)
	end
	
	return false
end