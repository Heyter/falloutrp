
local meta = FindMetaTable("Player")

function meta:getStrength()
	return self.playerData.strength or 0
end