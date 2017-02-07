
local meta = FindMetaTable("Player")

function meta:hasVip()
	return tobool(self.playerData.vip) or false
end