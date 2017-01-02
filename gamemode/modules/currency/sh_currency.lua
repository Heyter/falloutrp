
local meta = FindMetaTable("Player")

function meta:getCaps()
	return self.playerData.bottlecaps or 0
end

function meta:canAfford(price)
	return self:getCaps() >= price
end
