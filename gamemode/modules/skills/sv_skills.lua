
util.AddNetworkString("addSkillPoints")
util.AddNetworkString("validateSkills")
util.AddNetworkString("updateSkills")

local meta = FindMetaTable("Player")

hook.Add("ShowSpare1", "openSkillPoints", function(ply)
	if ply:getSkillPoints() > 0 then
		// Open the menu
		ply:openSkillPoints()
	else
		ply:notify("You don't have any skill points to allot.", NOTIFY_ERROR)
	end
end)

function meta:openSkillPoints()
	net.Start("addSkillPoints")
		net.WriteInt(self:getLevel(), 8)
		net.WriteInt(self:getSkillPoints(), 16)
	net.Send(self)
end

function meta:addSkillPoints()
	self.playerData.skillpoints = self:getSkillPoints() + SKILLPOINTS_LEVEL

	MySQLite.query("UPDATE playerdata SET skillpoints = " ..self:getSkillPoints() .." WHERE steamid = '" ..self:SteamID() .. "'")

	// Notify player that they leveld up
	self:notify("LEVELED UP! Press F3 to use Skill Points!", NOTIFY_GENERIC, 10)
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

function updateSkillPoints(ply, values, remainingPoints)
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

	// Set the remaining skill points
	ply.playerData.skillpoints = remainingPoints
	MySQLite.query("UPDATE playerdata SET skillpoints = " ..ply:getSkillPoints() .." WHERE steamid = '" ..ply:SteamID() .. "'")

	// Update the player with their new skills
	MySQLite.query("UPDATE playerdata SET " ..records .." WHERE steamid = '" ..ply:SteamID() .. "'")

	net.Start("updateSkills")
		net.WriteTable(newSkills) // Send the updated skill values
	net.Send(ply)
end

function validateSkills(ply, values)
	local beginningTotal, beginningValues = calcBeginningSkills(ply)
	local total = 0
	local errorId
	local currentSkillPoints = ply:getSkillPoints()

	for k,v in ipairs(values) do
		total = total + v

		if v < beginningValues[k] then
			// The new value for the skill is less than the existing value of the skill
		end
	end

	// How many skill points the player now has left
	local remainingPoints = currentSkillPoints - (total - beginningTotal)

	if total > beginningTotal + currentSkillPoints then
		// Used more points than allowed for each level
		errorId = 1
	else
		// Used exact amount of points, GOOD
		updateSkillPoints(ply, values, remainingPoints)
	end

	if errorId then
		net.Start("validateSkills")
			net.WriteInt(errorId, 8)
		net.Send(ply)
	end
end
