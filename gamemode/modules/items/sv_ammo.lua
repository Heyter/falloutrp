
local meta = FindMetaTable("Player")

function createAmmo(item, quantity)
	item.quantity = quantity or 1
	
	return item
end