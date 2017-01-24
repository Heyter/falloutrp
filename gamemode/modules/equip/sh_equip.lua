
local meta = FindMetaTable("Player")

function meta:getPrimary()
	return self.equipped.weapons.primary
end

function meta:getSecondary()
	return self.equipped.weapons.secondary
end

function meta:getItemHealth()
	local bonus = 0
	
	for type, info in pairs(self.equipped) do
		bonus = bonus + (info.bonusHp or 0)
	end
	
	return bonus
end