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
Vector(-10205, 1304, 127),
Angle(0, 70, 0),
"models/atp/fonv/securitron_clean.mdl",
{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
)

// Add Quests Below Here
addQuest(
1,
"To The Sanctuary",
"Escape the vault and venture out to find The Sanctuary. Once you find it, look for the man named Governor Dave",
{npc = "npc_x"},
{quests = {}, level = 1},
{experience = 100, caps = 81},
nil,
1,
"Find the Sanctuary"
)

addQuest(
2,
"Exploring the Town",
"Welcome! I am Governor Dave. This is The Sanctuary! Here you will find a variety of merchants and tool stations you will need on your adventures. Please go explore this town! Go talk to each merchant and then return back to me.",
{npc = "npc_x"},
{quests = {1}, level = 1},
{experience = 100, caps = 122},
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

addQuest(
3,
"My First Crafted Weapon",
"Hello again! I hope you enjoyed meeting all the faces around the city! However, it's time you get a weapon to defend yourself while you are adventuring the wasteland. For now, try to sneak around them and gather the materials for a Silence .22 Pistol.",
{npc = "Governor Dave"},
{quests = {2}, level = 1},
{experience = 275, caps = 163},
nil,
1,
"Craft the Silence .22 pistol"
)

addQuest(
4,
"Mr. Fuzzypants",
"Hello again! Glad to see you have the ability to defend yourself! Now, I need to ask you for a favor. You see, the other day I was venturing out with my teddybear Mr. Fuzzypants. We went into a cave when a gecko came out of nowhere and I dropped Mr. Fuzzypants. Can you please go retrieve him!",
{npc = "Governor Dave"},
{quests = {3}, level = 1},
{experience = 275, caps = 204},
{[5047] = {1, 1}},
1,
"Retrieve Mr. Fuzzypants from the cave"
)

addQuest(
5,
"Protecting Yourself",
"Hello there again! Now that you have ventured out in the wastelands, you definitely know the dangers out there. It’s time for you to protect yourself from them other than just a weapon. Go out and collect cotton and craft a Green Rag Helmet.",
{npc = "Governor Dave"},
{quests = {4}, level = 1},
{experience = 525, caps = 245},
nil,
1,
"Craft a Green Rag Helmet"
)

addQuest(
6,
"Factory Expert",
"Hello there again wanderer! Now that you have weapons and protection, it's time for you to learn about factories. Factories litter the wasteland continuously creating supplies like ammo, weapons, or materials. These are on your map and can be captured depending on your faction. You should go out to one and retrieve a few items from it.",
{npc = "Governor Dave"},
{quests = {5}, level = 5},
{experience = 1250, caps = 130},
nil,
1,
"Visit the Materials Factory",
1,
"Visit the Apparel Factory",
1,
"Visit the Caps Factory",
 1,
"Visit the Ammo Factory"
)

addQuest(
7,
"Bank Robber",
"Good you're here! I need help! I was on my way to the bank when a man came from behind me and robber me of everything I had! Please chase after him! I saw him going towards the vault. It should be on your map. Please go find my valuables! If you get my stuff back I will give you a great reward for my gratitude.",
{npc = "Governor Dave"},
{quests = {6}, level = 5},
{experience = 1250, caps = 195},
{[5048] = {1, 1}},
1,
"Return valuables"
)

addQuest(
8,
"Ghoul Invasion",
"Hey wanderer! I got a message that a nearby northern settlement was invaded by a pack of feral ghouls. Please go help them if you can. While you’re there you can capture the Apparel Factory for a bonus reward!",
{npc = "Governor Dave"},
{quests = {7}, level = 5},
{experience = 1725, caps = 260},
nil,
5,
"Kill 5 Feral Gouls"
)

addQuest(
9,
"Low On Ammunition",
"Hello again! We could really use some help! Our armory is low on bullets from all the nearby mutated animals. If you could please craft 120 bullets of 9mm and .22 ammo.",
{npc = "Governor Dave"},
{quests = {8}, level = 5},
{experience = 1725, caps = 325},
nil,
120,
"Craft 120 Bullets of 9mm",
120,
"Craft 120 bullets of .22"
)

addQuest(
10,
"Medical Supplies",
"Hello traveler! By now you are somewhat experienced out there in the Wasteland. You have probably been injured and would like to know how to stay out venturing for longer periods of time! Go out and collect 4 sage and craft 1 pipe. Then go craft a syringe. If you manage to do this I will give you a few extra to help you out.",
{npc = "Governor Dave"},
{quests = {9}, level = 5},
{experience = 2275, caps = 390},
nil,
1,
"Craft 1 Stimpack"
)
