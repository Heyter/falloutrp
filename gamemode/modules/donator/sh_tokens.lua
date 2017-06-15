
local meta = FindMetaTable("Player")

function meta:getTokens()
	return self.playerData.tokens or 0
end
