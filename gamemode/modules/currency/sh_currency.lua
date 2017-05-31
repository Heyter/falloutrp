
local meta = FindMetaTable("Player")

function meta:getCaps()
	return self.playerData.bottlecaps or 0
end

function meta:getReadableCaps()
	return string.Comma(self:getCaps())
end

function meta:canAfford(price)
	return self:getCaps() >= price
end
