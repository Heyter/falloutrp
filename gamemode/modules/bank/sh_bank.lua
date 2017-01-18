
local meta = FindMetaTable("Player")

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