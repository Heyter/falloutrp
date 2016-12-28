
util.AddNetworkString("addSkillPoints")

local meta = FindMetaTable("Player")

function meta:addSkillPoints()
	self.playerData.skillpoints = self:getSkillPoints() + SKILLPOINTS_ON_LEVEL
	
	net.Start("addSkillPoints")
		net.WriteInt(self:getSkillPoints(), 8)
		net.WriteEntity(self)
	net.Send(self)
end