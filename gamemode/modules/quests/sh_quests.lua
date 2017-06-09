QUESTS = QUESTS or {}
QUESTS.quests = QUESTS.quests or {}
QUESTS.questGivers = QUESTS.questGivers or {}

local meta = FindMetaTable("Player")

function meta:hasQuest(id)
    return self.quests and self.quests[id] != nil
end

function meta:isQuestComplete(id)
    return self.quests and self.quests[id] and self.quests[id].completed
end

function meta:getTaskProgress(questId, taskId)
	return self.quests[questId].tasks[taskId]
end

function meta:metQuestPreconditions(id)
    local conditions = QUESTS:getPreconditions(id)

    if self:getLevel() < conditions.level then
        return false
    end

    for k,v in pairs(conditions.quests) do
        if !self:isQuestComplete(v) then
            return false
        end
    end

    return true
end

function meta:isQuestTaskComplete(questId, taskId)
    local needed = QUESTS:getTaskProgressNeeded(questId, taskId)

    return self.quests and self.quests[questId] and (self.quests[questId].tasks[taskId] >= needed)
end

function meta:finishedQuestTasks(questId)
    for k,v in pairs(QUESTS:getTasks(questId)) do
        if !self:isQuestTaskComplete(questId, k) then
            return false
        end
    end

    return true
end

function addQuest(id, name, description, starter, preconditions, rewards, removals, ...)
	local args = {...}
	local tasks = {}

	local count = 1
	local temp = 0
	tasks[1] = {}

	for i = 1, #args do
		if temp == 2 then
			count = count + 1
			temp = 0

			tasks[count] = {}
		end
		temp = temp + 1

		if i % 2 == 0 then
			tasks[count]["taskDescription"] = args[i]
		else
			tasks[count]["task"] = args[i]
		end

		QUESTS.quests[id] = {
			id = id,
			name = name,
			description = description,
			start = start,
			preconditions = preconditions,
			rewards = rewards,
            removals = removals,
			tasks = tasks
		}
	end
end

function addQuestGiver(name, position, angles, model, quests)
    QUESTS.questGivers[name] = {
        position = position,
        angles = angles,
        model = model,
        quests = quests,
        name = name
    }
end

function QUESTS:getName(id)
	return self.quests[id].name
end

function QUESTS:getPreconditions(id)
    return self.quests[id].preconditions
end

function QUESTS:getRewards(id)
    return self.quests[id].rewards
end

function QUESTS:getRemovals(id)
    return self.quests[id].removals
end

function QUESTS:getDescription(id)
	return self.quests[id].description
end

function QUESTS:getTasks(questId)
	return self.quests[questId].tasks
end

function QUESTS:getTaskProgressNeeded(questId, taskId)
	return self:getTasks(questId)[taskId].task
end

function QUESTS:getGiverQuests(name)
    return self.questGivers[name].quests
end

// Add Questgivers below Here
addQuestGiver(
"Governor Dave",
Vector(-9450.132813, 9965.731445, 0.031250),
Angle(0, -90, 0),
"models/humans/group01/male_04.mdl",
{1, 2}
)

// Add Quests Below Here
addQuest(
1,
"To The Sanctuary",
"Escape the vault and venture out to find The Sanctuary. Once you find it, look for the man named “Governor Dave“",
{npc = "npc_x"},
{quests = {}, level = 1},
{experience = 100, items = {[1001] = 5}},
nil,
1,
"Escape the Sanctuary"
)

addQuest(
2,
"Exploring the Town",
"Welcome! I am x. This is The Sanctuary! Here you will find a variety of merchants and tool stations you will need on your adventures. Please go explore this town! Go talk to each merchant and then return to x.",
{npc = "npc_x"},
{quests = {1}, level = 1},
{experience = 100, items = {[1001] = 1}, caps = 1000},
nil,
1,
"Talk to John",
1,
"Talk to Sky",
1,
"Talk to Samantha",
1,
"Talk to Billy"
)
