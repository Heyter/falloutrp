
local meta = FindMetaTable("Player")

function createMisc(item, quantity)
	item.quantity = quantity or 1
	
	return item
end