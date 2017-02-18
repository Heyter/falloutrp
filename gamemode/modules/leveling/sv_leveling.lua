
util.AddNetworkString("addExperience")

local meta = FindMetaTable("Player")

function meta:levelUp()
	if self.pvpProtected and (self:getLevel() >= PVP_PROTECTION_LEVEL) then
		self.pvpProtected = false
		self:notify("You're pvp protection has been disabled because you are no longer lower than level " ..PVP_PROTECTION_LEVEL .."!", NOTIFY_ERROR, 15)
	end

	self:addSkillPoints()
	
	hook.Call("LeveledUp", GAMEMODE, self, self:getLevel())
end

function meta:addExp(exp)
	local exp = math.ceil(exp)
	exp = exp * 2 // Double exp weekend
	local currentLevel = self:getLevel()

	self.playerData.experience = self:getExp() + exp
	
	// Update in SQL
	MySQLite.query("UPDATE playerdata SET experience = " ..self:getExp() .." WHERE steamid = '" ..self:SteamID() .."'")
	
	net.Start("addExperience")
		net.WriteInt(self:getExp(), 32)
		net.WriteEntity(self)
	net.Broadcast()
	
	if self:getLevel() > currentLevel then
		self:levelUp()
	end
	
	hook.Call("ExperienceGained", GAMEMODE, self, exp)
end