
local meta = FindMetaTable("Player")

function meta:getKills()
	return self.playerData.playerkills or 0
end

function meta:getRank()
	return (self.playerData and self.playerData.rank) or ""
end