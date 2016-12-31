
//Shared

local meta = FindMetaTable("Player")

function meta:getInventoryWeight()
	local weight = 0
	
	for k,items in pairs(self.inventory.weapons) do
		weight = weight + getWeaponWeight(items.classid)
	end
	
	return weight
end

function meta:canInventoryFit(item)
	return self:getInventoryWeight() + getItemWeight(item.classid) <= INVENTORY_WEIGHT
end