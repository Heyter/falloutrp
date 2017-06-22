
local Misc = {}

local meta = FindMetaTable("Player")

function meta:getMiscWeightTotal()
	local weight = 0

	for k,v in pairs(self.inventory.misc) do
		local itemWeight = v.quantity * getMiscWeight(v.classid)

		weight = weight + itemWeight
	end

	return weight
end

function meta:hasMiscItem(classid)
	for k,v in pairs(self.inventory.misc) do
		if v.classid == classid then
			return self.inventory.misc[v.uniqueid]
		end
	end

	return false
end

function addMisc(id, name, model, weight, value, quest)
	Misc[id] = {
		name = name,
		model = model,
		weight = weight,
		value = value,
		quest = quest
	}
end

function findMisc(id)
	if id then
		return Misc[id]
	end
end

// Base functions that have data that will not change
function getMiscName(id)
	return findMisc(id).name
end
function getMiscModel(id)
	return findMisc(id).model
end
function getMiscWeight(id)
	return findMisc(id).weight
end
function getMiscValue(id)
	return findMisc(id).value
end
function getMiscQuest(id)
	return findMisc(id).quest
end

// Functions that have data which can change
function getMiscNameQuantity(id, quantity)
	local name = getMiscName(id)

	if util.positive(quantity) then
		name = name .." (" ..quantity ..")"
	end

	return name
end

function meta:getMiscQuantity(uniqueid)
	local quantity = self.inventory.misc[uniqueid]["quantity"]

	return quantity or 1
end

addMisc(5001, "Hammer", "models/clutter/hammer.mdl", .5, 20)
addMisc(5002, "Iron", "models/clutter/iorn.mdl", 1, 25)
addMisc(5003, "Plate", "models/clutter/plate.mdl", .2, 5)
addMisc(5004, "Ashtray", "models/clutter/ashtray.mdl", .1, 3)
addMisc(5005, "Book", "models/clutter/book.mdl", .5, 40)
addMisc(5006, "Camera", "models/clutter/camara.mdl", 1, 50)
addMisc(5007, "Checkerboard", "models/clutter/chessboard.mdl", .5, 35)
addMisc(5008, "Pan", "models/clutter/cookingpan.mdl", 1.5, 10)
addMisc(5009, "Kitchen Knife", "models/clutter/eatingknife.mdl", .5, 10)
addMisc(5010, "Garden Gnome", "models/clutter/gardengnome.mdl", 3, 5)
addMisc(5011, "Pitcher", "models/clutter/glasspitcher.mdl", .2, 2)
addMisc(5012, "Plunger", "models/clutter/plunger.mdl", .5, 3)
addMisc(5013, "Rake", "models/clutter/rake.mdl", 2, 5)
addMisc(5014, "Scrap Metal", "models/clutter/scrapmetal.mdl", 2, 20)
addMisc(5015, "Spatula", "models/clutter/spatula.mdl", 1, 2)
addMisc(5016, "Teddy Bear", "models/clutter/teddybear.mdl", .5, 50)
addMisc(5017, "Tray", "models/clutter/tray.mdl", .5, 2)
addMisc(5018, "Wrench", "models/clutter/wrench.mdl", 1.5, 5)
addMisc(5019, "Spork", "models/clutter/spork.mdl", .1, 1)
addMisc(5020, "Whisky Bottle", "models/clutter/whiskeybottle.mdl", 1, 15)
addMisc(5021, "Empty Blood Bag", "models/mosi/fallout4/props/aid/bloodbagempty.mdl", .5, 2)
addMisc(5022, "Blood Bag", "models/mosi/fallout4/props/aid/bloodbag.mdl", 1.5, 5)
addMisc(5023, "Can", "models/props_junk/PopCan01a.mdl", .1, 2)
addMisc(5024, "Gas Can", "models/props_junk/gascan001a.mdl", 3, 16)
addMisc(5025, "Tea Kettle", "models/props_interiors/pot01a.mdl", 1, 3)
addMisc(5026, "Tin Can", "models/props_junk/garbage_metalcan001a.mdl", .1, 1)
addMisc(5027, "Broken helicopter piece", "models/Gibs/helicopter_brokenpiece_02.mdl", 2, 50)

// Mining Materials
addMisc(5028, "Rock", "models/ores/rock_ore.mdl", 0.25, 15)
addMisc(5029, "Copper", "models/ores/copper_ore.mdl", 0.25, 50)
addMisc(5030, "Silver", "models/ores/silver_ore.mdl", 0.25, 125)
addMisc(5031, "Gold", "models/ores/gold_ore.mdl", 0.25, 200)
addMisc(5032, "Crystal", "models/scalpet/crystal.mdl", 0.25, 350)
addMisc(5033, "Wooden stick", "models/gibs/wood_gib01a.mdl", 1, 10)
addMisc(5034, "Sheet metal", "models/props_phx/construct/metal_plate1.mdl", 3, 40)
addMisc(5035, "Pipe", "models/props_canal/mattpipe.mdl", 2, 175)


// Crystal
addMisc(5036, "Holo Disk", "models/holodisk/holodisk.mdl", 1.5, 150)

// Copper and Gold
addMisc(5037, "Conduit", "models/mosi/fallout4/electrical/conduits/conduit.mdl", 1, 17)
addMisc(5038, "Switchbox", "models/mosi/fallout4/electrical/conduits/switchbox.mdl", 2, 37)

addMisc(5039, "Crystal Shard", "models/scalpet/crystalshar.mdl", 0.25, 150)
addMisc(5040, "Plasma", "models/scalpet/crystalshar.mdl", 0.25, 300)
addMisc(5041, "Claw", "models/Halokiller38/fallout/weapons/Melee/deathclawgauntlet.mdl", 0.25, 35)
addMisc(5042, "Hide", "models/Gibs/HGIBS_scapula.mdl", 0.25, 15)
addMisc(5043, "Leather", "models/Gibs/HGIBS_scapula.mdl", 0.25, 30 )
addMisc(5044, "Cloth", "models/cloth/clothwind01.mdl", 0.5, 10)
addMisc(5045, "Cotton", "models/weapons/w_snowball.mdl", 0.25, 5)
addMisc(5046, "Sage", "models/props/cs_office/Snowman_arm.mdl", 0.25, 15)

// Quest Items
addMisc(5047, "Mr. Fuzzypants", "models/tsbb/animals/linsang.mdl", 0.5, 0, true)
addMisc(5048, "Valuables", "models/props_c17/BriefCase001a.mdl", 0.5, 0, true)
addMisc(5051, "Engine", "models/props_c17/trappropeller_engine.mdl", 25, 100, true)
addMisc(5052, "Blood Bag", "models/mosi/fallout4/props/aid/bloodbag.mdl", 2, 50, true)
addMisc(5053, "Painkillers", "models/mosi/fallout4/props/aid/daytripper.mdl", .1, 50, true)
addMisc(5054, "Morphine", "models/mosi/fallout4/props/aid/medx.mdl", .1, 75, true)
addMisc(5055, "Ghoul Valuables", "models/props_c17/BriefCase001a.mdl", 2, 100, true)
addMisc(5056, "Helicopter Part", "models/props_lab/labpart.mdl", 5, 70, true)
addMisc(5057, "Radaway", "models/mosi/fallout4/props/aid/radx.mdl", .5, 50, true)
addMisc(5058, "Food Rations", "models/props_junk/food_pile02.mdl", .5, 5, true)
addMisc(5059, "Water Rations", "models/props/cs_office/water_bottle.mdl", .5, 5, true)
addMisc(5060, "Cementing Paste", "models/props_junk/plasticbucket001a.mdl", 1, 20, true)
addMisc(5061, "Retrieval Tool", "models/weapons/w_models/w_toolbox.mdl", .5, 15, true)
addMisc(5062, "Batteries", "models/items/car_battery01.mdl", .5, 15, true)
addMisc(5063, "Fuel Can", "models/props_junk/gascan001a.mdl", 1, 35, true)
addMisc(5064, "Mr.Whiskers", "models/tsbb/animals/linsang.mdl", 0.5, 0, true)
