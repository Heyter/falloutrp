
util.AddNetworkString("addSkillPoints")
util.AddNetworkString("validateSkills")
util.AddNetworkString("updateSkills")

local meta = FindMetaTable("Player")

function meta:addSkillPoints()

	net.Start("addSkillPoints")
		net.WriteInt(self:getLevel(), 8)
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

function setSkillPoints(ply, skill, points)
	ply.playerData[skill] = points
end

function updateSkillPoints(ply, values)
	local newSkills = {}
	local records = ""
	
	for k, points in ipairs(values) do
		local skill = string.lower(string.Replace(SKILLS[k].Name, " ", ""))
		records = records ..skill .." = " ..points ..", "
		setSkillPoints(ply, skill, points)
		
		newSkills[skill] = points
	end
	
	
	records = string.TrimRight(records, " ")
	records = string.TrimRight(records, ",")
	
	print(records)
	MySQLite.query("UPDATE playerdata SET " ..records .." WHERE steamid = '" ..ply:SteamID() .. "'")
	
	net.Start("updateSkills")
		net.WriteTable(newSkills) // Send the updated skill values
	net.Send(ply)
end

function validateSkills(ply, values)
	local beginningTotal, beginningValues = calcBeginningSkills(ply)
	local total = 0
	local errorId

	for k,v in ipairs(values) do
		total = total + v
		
		if v < beginningValues[k] then
			// The new value for the skill is less than the existing value of the skill
		end
	end
	
	if total > beginningTotal + SKILLPOINTS_LEVEL then
		// Used more points than allowed for each level
		errorId = 1
	elseif total < beginningTotal + SKILLPOINTS_LEVEL then
		// Used less points than allowed for each level
		errorId = 2
	else
		// Used exact amount of points, GOOD
		updateSkillPoints(ply, values)
	end
	
	if errorId then
		net.Start("validateSkills")
			net.WriteInt(errorId, 8)
		net.Send(ply)
	end
end