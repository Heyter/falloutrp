
local meta = FindMetaTable("Player")

function meta:getFactionChanges()
	return self.playerData.factionchanges or 0
end