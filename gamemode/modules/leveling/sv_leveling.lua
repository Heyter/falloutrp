
local meta = FindMetaTable("Player")

function meta:addExp(skill, exp)
	local exp = math.ceil(exp)

	self:GetStats()[skill]["exp"] = self:GetStats()[skill]["exp"] + exp
	
	local xpLevel = ExpToLevel(self:GetStats()[skill]["exp"]) 
	
	/*
	if xpLevel > self:currentLevel() then
		self:levelUp()
	end
	*/
	
	hook.Call("ExperienceGained", GAMEMODE, self, exp)
end