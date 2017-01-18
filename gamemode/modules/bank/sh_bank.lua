
local meta = FindMetaTable("Player")

function meta:getBankWeight()
	local weight = 0
	
	// Total weight of weapon items
	for type, item in pairs(self.bank) do
		for uniqueid, itemInfo in pairs(item) do
			weight = weight + getItemWeight(itemInfo.classid)
		end
	end
	
	return weight
end