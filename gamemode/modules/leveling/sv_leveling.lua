
util.AddNetworkString("addExperience")

local meta = FindMetaTable("Player")

function meta:levelUp()
	self:addSkillPoints()
	
	hook.Call("LeveledUp", GAMEMODE, self, self:getLevel())
end

function meta:addExp(exp)
	local exp = math.ceil(exp)

	self.playerData.experience = self:getExp() + exp
	
	// Update in SQL
	MySQLite.query("UPDATE playerdata SET experience = " ..self:getExp())
	
	net.Start("addExperience")
		net.WriteInt(self:getExp(), 32)
		net.WriteEntity(self)
	net.Broadcast()
	
	local xpLevel = expToLevel(exp) 
	if xpLevel > self:getLevel() then
		self:levelUp()
	end
	
	hook.Call("ExperienceGained", GAMEMODE, self, exp)
end