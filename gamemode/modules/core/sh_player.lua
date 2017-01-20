
function plyDataExists(ply)
	return ply and ply.playerData
end

local meta = FindMetaTable("Player")

function meta:getMaxHealth()
	return MAX_HEALTH + self:getItemHealth() + self:getStrengthHealth()
end