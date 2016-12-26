
local meta = FindMetaTable("Player")

function meta:getSkillPoints()
	return self.playerData.skillpoints
end