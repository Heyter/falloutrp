
util.AddNetworkString("addSkillPoints")
util.AddNetworkString("validateSkills")

local meta = FindMetaTable("Player")

function meta:addSkillPoints()
	self.playerData.skillpoints = self:getSkillPoints() + SKILLPOINTS_ON_LEVEL
	
	net.Start("addSkillPoints")
		net.WriteInt(self:getSkillPoints(), 8)
		net.WriteEntity(self)
	net.Send(self)
end

net.Receive("validateSkills", function(len, ply)
	local values = net.ReadTable()
	
	validateSkills(ply, values)
end)

local function calcBeginningSkills(ply)
	local total = 0
	local values = {}

	for k, v in ipairs(SKILLS) do
		local value = ply.playerData[string.lower(string.Replace(v.Name, " ", ""))]
		
		total = total + value
		values[k] = value
	end
	
	return total, values
end	

function validateSkills(ply, values)
	local beginningTotal, beginningValues = calcBeginningSkills(ply)
	local total = 0

	for k,v in ipairs(values) do
		total = total + v
		
		if v < beginningValues[k] then
			// The new value for the skill is less than the existing value of the skill
		end
	end
	
	if total > beginningTotal + SKILLPOINTS_LEVEL then
		// Used more points than allowed for each level
	elseif total < beginningTotal + SKILLPOINS_LEVEL then
		// Used less points than allowed for each level
	else
		// Used exact amount of points, GOOD
		
	end
end