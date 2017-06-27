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
{1, 2, 3, 4, 5, 6, 7, 8}
)

addQuestGiver(
"Brutus, Master of Crafting",
Vector(-10574, 1595, 127),
Angle(0, 20, 0),
"models/ncr/ncr_06.mdl",
{9, 10, 11, 12}
)

addQuestGiver(
"Kenneth",
Vector(-9489, 1380, 200),
Angle(0, 100, 0),
"models/ncr/ncr_03.mdl",
{13, 14, 15, 16}
)


addQuestGiver(
"Lily",
Vector(4588, 10060, 224),
Angle(0, -90, 0),
"models/player/korka007/clementine.mdl",
{17}
)

addQuestGiver(
"Wasteland Biologist",
Vector(-8539, 11707, 54),
Angle(0, -130, 0),
"models/kleiner.mdl",
{18, 19, 20, 21}
)

// Add Quests Below Here
addQuest(
1,
"To The Sanctuary",
"Escape the vault and venture out to find The Sanctuary. Once you find it, look for the man named Governor Dave",
{npc = "Governor Dave"},
{quests = {}, level = 1},
{experience = 224, caps = 150},
nil,
1,
"Find the Sanctuary"
)

addQuest(
2,
"Exploring the Sanctuary",
"Howdy there, I am Governor Dave. As you can see I am not a man, but a robot. I will delve more into this later, but for now welcome to Sanctuary! No, we will not being flying in the sky later if that's what you thought but this is the only safe place out here in this wasteland. Why don’t you go on and meet some of the towns folk, they’d be happy to meet you and may even have some work for you! Once your done meetin everyone make sure you pass by me because I got some tasks for you to help me with.",
{npc = "Governor Dave"},
{quests = {1}, level = 1},
{experience = 298, caps = 300},
nil,
1,
"Meet John",
1,
"Meet Sky",
1,
"Meet Samantha",
1,
"Meet Billy"
)

addQuest(
3,
"Fixing the old generator",
"Hello once again! As a member of my Sanctuary I have a few things that you could help me with in order to keep this bucket of bolts working in top notch status. You see, this Sanctuary runs off of that generator over yonder. It’s running low on fuel and the damn old engine is starting to fall apart. I need some replacement parts. If you could head over to the nearby gas station and the broken down train, you should be able to find the parts I am looking for.",
{npc = "Governor Dave"},
{quests = {2}, level = 2},
{experience = 373, caps = 470},
{[5063] = {1, 1}, [5051] = {2, 1}},
1,
"Find and return a fuel can",
1,
"Find and return an engine"
)

addQuest(
4,
"Ya need batteries to keep robots going",
"Hello again! Thank you for fixing the generator. I have a new task that you can help me with. A little while back I was out scavenging for some batteries to keep me going and I began to look around the buildings in the swampish area. I got ambushed by a some swamp lurks and hid in the pit of one of the buildings and I stayed there all night. At the brink of Dawn I sped my way out of there heading straight back here to the sanctuary but, I left the batteries in the hole. I am too scared to go back there after that incident so I was hoping you could go there and fetch them for me.",
{npc = "Governor Dave"},
{quests = {3}, level = 6},
{experience = 3436, caps = 620},
{[5062] = {1, 1}},
1,
"Retrieve the batteries"
)

addQuest(
5,
"Patching up what Charles did",
"Why hello again! Thanks for getting me those batteries! They are working perfectly. I have a new job for you. As you can probably see that wall over yonder is broken to pieces and I don’t want to throw any blame around to who drove that vehicle into it *Cough* Charles *Cough* but we really need to get it patched incase some wild deathclaw roams by. We just need some cement and some good tools and we will be on our way to patching up that wall. Head over to the Hanger to find some nice tools and then, go through that tunnel in the mountain and look through those abandoned homes for some cement blocks and cementing paste.",
{npc = "Governor Dave"},
{quests = {4}, level = 6},
{experience = 4008, caps = 850},
{[5060] = {1, 1}, [5061] = {2, 1}},
1,
"Retrieve cementing paste",
1,
"Retrieve tools"
)

addQuest(
6,
"Running low on rations",
"Hey There! Thank you for the patch up supplies, your help is really appreciated. Now we have a big issue. This town is running very low on food and water rations. Usually I do a good job on spreading them out but recently we have gotten a lot of new members to the town. Go over to the Mill near the swamp to find some food rations. Then, head over to the small water tower and see if any crates of water supplies are left.",
{npc = "Governor Dave"},
{quests = {5}, level = 11},
{experience = 12300, caps = 1250},
{[5058] = {1, 1}, [5059] = {2, 1}},
1,
"Return with some food rations",
1,
"Return with some water rations"
)


addQuest(
7,
"Radiation poisoning",
"HELP! We need some medication QUICK! One of those food rations you got us had some old radiated gunk on it. One of the town members ate it and is extremely sick. We don’t want her turning into a ghoul  so we gotta get her some rad pills. This is asking a lot but I need you to head over to the main city. You gotta be careful son, there are bandits roaming that city. You neva know when they may come over and try to cause some trouble. Just head over to the hospital and find some radaway quick or else that town fellow may not survive this.",
{npc = "Governor Dave"},
{quests = {6}, level = 16},
{experience = 18763, caps = 1500},
{[5057] = {1, 1}},
1,
"Bring back some Radaway"
)

addQuest(
8,
"New tech from the helicopter crash",
"Thank you so much for getting that medicine. You have been a great help around this town and I would like to thank you once again. However, your help is still in need here. You see, we don’t have much technology here especially no high tech weapons or armor. Any of that stuff you see was salvaged from nearby. However, there is one place that no one has salvaged because of its mysterious appearance. A long time ago a high tech helicopter crashed nearby. No one knows if there were any survivors but were all afraid to go near it incase anybody is trying to ambush us. Please go search it and bring back anything you can find but be careful doing it. I don't know what condition the tech is still in, so you might have to rebuild it with other materials.",
{npc = "Governor Dave"},
{quests = {7}, level = 16},
{experience = 23754, caps = 2500},
{[5065] = {1, 1}},
1,
"Return new tech from crash site."
)

addQuest(
9,
"Crafting The Essentials",
"What do you want?!? Oh… Sorry. Pardon my manners, didn’t realize you are a wanderer. You look unprepared for the Wasteland, you won’t last 2 minutes with those rat mutants. You need to gear up, and what better way than to craft the items you will need to survive? Let's start with finding the corresponding crafting bench and then crafting the items. Go to the Weapons Bench, it is located outside along the cement wall. I would recommend you to craft a silenced .22 pistol, it is not the most effective way to kill but it will have to do for now. Also don’t forget to craft some ammo for it otherwise you won’t get anywhere. Next we will look at getting you lockpick and your Pickaxe. Those are essential items that every wanderer needs. There are plenty of chests that need a pick locking, you never know what you will find under those rust buckets. The Pickaxe is a good tool to have on hand because you never know when you might walk by something shiny in the rocks. Next locate the Aid bench, you will need to craft a couple Stimpacks. Stimpacks are good for keeping you alive. If you do not have the required materials you may try to purchase them which might be a little expensive, or you can try to go in the wasteland and safely collect items and hurry back to craft. The second option is a bit dangerous but you do not need to spend any money. Best of luck to ya! Come back when you have crafter all of the items and we will proceed.",
{npc = "npc_x"},
{quests = {}, level = 1},
{experience = 298, caps = 65},
nil,
1,
"Craft .22 Silenced Pistol",
20,
"Craft 20 .22 Ammo",
1,
"Craft Lockpick",
1,
"Craft Pickaxe",
3,
"Craft 3 Stimpacks"
)

addQuest(
10,
"Let’s Get Some Protection",
"Who’s there?!?! Oh it's you! You gotta stop sneaking up on me, I am a paranoid man. Well look at you, you got all the essentials to gather and fight, but you are missing something… ARMOR!! Every great wanderer has a set of armor to keep them safe from the harsh environment and those pesky rats. I suggest you start with a Green Rags, it will give you the most protection from the set. One time in the old days I remember wearing a shirt similar to that and I kid you not it saves my life from a rats attack. Anyways I get sidetracked let’s continue, then I would suggest the rest of the set in this order from most protection gain to the least: Raggedy Green Slacks, Ripped Green Sneakers, Green Gloves. Once you are all suited up come back and talk to me!",
{npc = "npc_x"},
{quests = {9}, level = 6},
{experience = 1718, caps = 200},
nil,
1,
"Craft Green Rags",
1,
"Craft Raggedy Green Slacks",
1,
"Craft Ripped Green Sneakers",
1,
"Craft Ragged Green Gloves"
)

addQuest(
11,
"Time For An Upgrade",
"Yo wanderer, I think you might be ready for an upgrade. Have you ever seen one of these before? Chinese! Freakin smart people. They made this here gun, she's a beauty ain’t she? Sorry got distracted, it will provide you with more fire power and will be able to take those rats down so fast you won’t ever have any problems with them rats. Oh and don’t forget to craft some ammo for it, a guns is only as useful as long as it's got ammunition. When you are done please come back and show me what you have made!",
{npc = "npc_x"},
{quests = {10}, level = 11},
{experience = 3075, caps = 525},
nil,
1,
"Craft Chinese Pistol",
20,
"Craft 20 10mm Ammo"
)

addQuest(
12,
"Armor, Armor, and more Armor",
"Woah!!! What’s that stinch??? Oh Wanderer, you need a change of cloths, need to start thinking about changing your clothes every so often. Good news, I just got my hands on some new clothes! But these are mine, I don’t like to share, but I think I figured out how to create them, I will share that with you. I call it the Construction Set! It offers some great protection and might get the lady's attention if you know what I mean. Now scram! Go get the supplies you are going to be using.",
{npc = "npc_x"},
{quests = {11}, level = 13},
{experience = 6150, caps = 1100},
nil,
1,
"Craft Construction T-Shirt",
1,
"Craft Constuction Slacks",
1,
"Craft Hard Hat",
1,
"Craft Construction Boots",
1,
"Craft Construction Gloves"
)

addQuest(
13,
"Learning the basics",
"Who are you? I’ve never heard of you. You new around here? Well in that case you definitely need to learn the ropes if you wish to be successful in this barren wasteland. How you ask? Well that’s easy kid, you NEED to be able to break into stuff. This might be a surprise to you, but a Crowbar is not going to help you break into everything in this world. That’s why you need to pickup Lock Picking! No, it’s not difficult at all. Train you? Hahaha thats funny. Oh wait, you’re serious? I don’t know kid, I’m not the one to train people.. But for this occasion I guess I could train you. Don’t tell anyone though! I don’t want hundreds of people coming to ask me for help… Alright kid first thing you gotta do is find a crate of valuables that you really want. Then, take out your handy dandy lockpick and you need put the Tension wrench in the bottom of the Lock. The second thing you need to do, is put the Lockpick itself above the tension wrench. After both things are in the lock, you need to slowly move the lockpick around the lock. For each spot you put the lockpick in, you can try and move the tension wrench. If the Tension wrench will not budge, move the lockpick to another spot and try again! Once the Tension Wrench moves freely you can successfully unlock the lock, Voila! Free loot for everyone! Oh would you look at that, there is a crate right over there, go give it a whirl!",
{npc = "Governor Dave"},
{quests = {}, level = 1},
{experience = 298, caps = 5},
nil,
1,
"Open the nearby crate"
)

addQuest(
14,
"Becoming a Thief",
"Hey kid, I need a favor.. What kind of favor you ask? Well, it involves stealing. I can’t get around like I used to, otherwise I would do it. That’s why I am asking you. What do you need to steal? Well that’s simple, when I was kicked out of Town. I left some valuables behind. I need you to go get them for me. No, I can not live without them. What you need to do, is sneak into the town and find my old house. If you take the Train or follow the railroad you will be able to reach Ghoul Town, my house is just before you enter town, it run down by now. There you will find an old crate. It will be right next to it on the floor and I need them ASAP!",
{npc = "Governor Dave"},
{quests = {13}, level = 6},
{experience = 2290, caps = 1100},
{[5048] = {1, 1}},
1,
"Steal the valuables"
)

addQuest(
15,
"The Treasure of Ghoul Town",
"Hey kid, how's it goin? Thanks for stealing that stuff for me last time.. Oh I mean uh thanks for retrieving my stuff.. Okay fine that was not my stuff, I’ll admit it. You know what Kid, I need another favor. There was this house in Ghoul Town that was guarded by some Ghoul. Word around town is that it is full of valuables, but the problem is that I can’t steal like I used to. I need you to kill some Ghoul around town and steal the valuables for me.. Wait I mean us, not me. Once you steal the valuables, I will be taking a small fee. Be careful kid. What? No, I don’t care about you. I just want my money!",
{npc = "Governor Dave"},
{quests = {14}, level = 11},
{experience = 3075, caps = 2250},
{[5055] = {1, 1}},
1,
"Return the ghoul’s valuables"
)


addQuest(
16,
"Saving an old friend",
"Wow, you again? I thought you died after that last quest. Oh well, I’m glad you are here. I need you help. The other day I was attacked by a blasted ghoul, and it almost killed me. While I was knocked out from the attack, thieves stole my Medical Supplies! I need you to break into the nearest Hospital and bring me back some blood bags, some Painkillers and Morphine. If you don’t..then I don’t know how much longer I am going to last.",
{npc = "Governor Dave"},
{quests = {15}, level = 13},
{experience = 6150, caps = 4000},
{[5052] = {1, 1}, [5053] = {2, 1}, [5054] = {3, 1}},
1,
"Collect Blood Bags",
1,
"Collect Painkillers",
1,
"Collect Morphine"
)

addQuest(
17,
"Mr.Whiskers",
"Hello there.. Who are you? Are you going to hurt me? Please don’t I don’t have anything. I even lost my kitten! If you don’t mind.. Can you go out and find my kitten. I was exploring around and fell in a hole into the sewers with her. I got scared and ran back here but forgot about Mr. Whiskers. Please go find her in the sewers!",
{npc = "Governor Dave"},
{quests = {}, level = 16},
{experience = 14847, caps = 1},
{[5064] = {1, 1}},
1,
"Retrieve Mr. Whiskers"
)

addQuest(
18,
"Rat Tails",
"Hey there! Nice to meet you! I am the Wasteland Biologist. However I have an issue with my job. I am not a fan of killing these creatures not only because I am scared of them, but because I hate seeing blood! Do me a favor and kill some rats for me and bring me back some tails that I can use to research their anatomy.",
{npc = "npc_x"},
{quests = {}, level = 2},
{experience = 250, caps = 100},
{[5066] = {1, 5}},
5,
"Retrieve 5 rat tails"
)

addQuest(
19,
"Mantis and their Nymphs",
"Hey there! I need you again! You see there are several Mantis and Nymphs out there and I would love to see their change in age! Please go kill some and grab me some of their spines. I can't use any damaged ones, they must be intact!",
{npc = "npc_x"},
{quests = {18}, level = 4},
{experience = 900, caps = 400},
{[5067] = {1, 2}, [5068] = {2, 2}},
2,
"Retrieve 2 Adult Mantis spines",
2,
"Retrieve 2 Mantis Nymph spines"
)

addQuest(
20,
"Swampy Ghouls",
"Hello Again! I have another creature that I would love to research. You see, there are many types of ghouls but the Swamp ghouls are fascinating. They walk barefoot in the swamp with ease! Go kill some and retrieve me their feet!.",
{npc = "npc_x"},
{quests = {19}, level = 8},
{experience = 3000, caps = 1000},
{[5069] = {1, 8}},
8,
"Retrieve 8 Swamp Ghoul Feet"
)

addQuest(
21,
"Cazador Stingers",
"Hello once again! I have a new creature I would love to research. I find the cazadors stingers interesting since they poison the target and can continuously sting people without any self injury. They also have very weak wings for some reason…  Go kill some and retrieve some of their stingers and wings.",
{npc = "npc_x"},
{quests = {20}, level =12 },
{experience = 7500, caps = 2000},
{[5070] = {1, 5}, [5071] = {2, 12}},
5,
"Retrieve 5 Cazador Stingers",
12,
"Retrieve 12 Cazador Wings"
)
