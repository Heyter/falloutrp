
local meta = FindMetaTable("Player")

function meta:getPrimary()
	return self.equipped.weapons.primary
end

function meta:getSecondary()
	return self.equipped.weapons.secondary
end

function meta:getItemHealth()
	local bonus = 0

	// Bots don't load into the server so do this check for easier testing
	if self.equipped then
		for type, info in pairs(self.equipped.apparel) do
			bonus = bonus + (info.bonusHp or 0)
		end
	else
		return 0
	end

	return bonus
end

function meta:getDamageThreshold()
	local damageThreshold = 0

	for type, info in pairs(self.equipped.apparel) do
		damageThreshold = damageThreshold + (info.damageThreshold or 0)
	end

	return damageThreshold
end

function meta:getDamageReflection()
	local damageReflect = 0

	for type, info in pairs(self.equipped) do
		damageReflect = damageReflect + (info.damageReflection or 0)
	end

	return damageReflect
end
