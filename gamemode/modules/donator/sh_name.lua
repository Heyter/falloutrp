
local meta = FindMetaTable("Player")

function meta:getNameChanges()
	return self.playerData.namechanges or 0
end