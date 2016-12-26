
util.AddNetworkString("addExperience")

local meta = FindMetaTable("Player")

function meta:levelUp()
	self:addSkillPoints()
	
	hook.Call("LeveledUp", GAMEMODE, self, self:currentLevel())
end

function meta:addExp(skill, exp)
	local exp = math.ceil(exp)

	self.playerData.experience = self:getExp() + exp
	
	net.Start("addExperience")
		net.WriteInt(self:getExp(), 8)
		net.WriteEntity(self)
	net.Broadcast()
	
	local xpLevel = expToLevel(exp) 
	if xpLevel > self:currentLevel() then
		self:levelUp()
	end
	
	hook.Call("ExperienceGained", GAMEMODE, self, exp)
end