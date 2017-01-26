
function plyDataExists(ply)
	return ply and ply.playerData
end

local meta = FindMetaTable("Player")

function meta:getName()
	return (self.playerData and self.playerData.name) or self:getNick()
end

function meta:getMaxHealth()
	return MAX_HEALTH + self:getItemHealth() + self:getStrengthHealth() + self:getFactionHitpoints()
end