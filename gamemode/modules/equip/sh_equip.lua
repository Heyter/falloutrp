
local meta = FindMetaTable("Player")

function meta:getItemHealth()
	local bonus = 0
	
	for type, info in pairs(self.equipped) do
		bonus = bonus + (info.bonusHp or 0)
	end
	
	return bonus
end