
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

function addMisc(id, name, model, weight, value)
	Misc[id] = {
		name = name,
		model = model,
		weight = weight,
		value = value,
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

addMisc(5001, "Hammer", "models/clutter/hammer.mdl", .5, 40)
addMisc(5002, "Iron", "models/clutter/iorn.mdl", 1 ,50)
addMisc(5003, "Plate", "models/clutter/plate.mdl", .2, 10)
addMisc(5004, "Ashtray", "models/clutter/ashtray.mdl", .1, 5)
addMisc(5005, "Book", "models/clutter/book.mdl", .5, 40)
addMisc(5006, "Camera", "models/clutter/camara.mdl", 1, 100)
addMisc(5007, "Checkerboard", "models/clutter/chessboard.mdl", .5, 70)
addMisc(5008, "Pan", "models/clutter/cookingpan.mdl", 1.5, 20)
addMisc(5009, "Kitchen Knife", "models/clutter/eatingknife.mdl", .5, 20)
addMisc(5010, "Garden Gnome", "models/clutter/gardengnome.mdl", 3, 20)
addMisc(5011, "Pitcher", "models/clutter/glasspitcher.mdl", .2, 1)
addMisc(5012, "Plunger", "models/clutter/plunger.mdl", .5, 5)
addMisc(5013, "Rake", "models/clutter/rake.mdl", 2, 10)
addMisc(5014, "Scrap Metal", "models/clutter/scrapmetal.mdl", 2, 150 )
addMisc(5015, "Spatula", "models/clutter/spatula.mdl", 1, 1)
addMisc(5016, "Teddy Bear", "models/clutter/teddybear.mdl", .5, 100)
addMisc(5017, "Tray", "models/clutter/tray.mdl", .5, 1) 
addMisc(5018, "Wrench", "models/clutter/wrench.mdl", 1.5, 10)
addMisc(5019, "Spork", "models/clutter/spork.mdl", .1, 1)
addMisc(5020, "Whisky Bottle", "models/clutter/whiskeybottle.mdl", 1, 30)
addMisc(5021, "Empty Blood Bag", "models/mosi/fallout4/props/aid/bloodbagempty.mdl", .5, 1)
addMisc(5022, "Blood Bag", "models/mosi/fallout4/props/aid/bloodbag.mdl", 1.5, 10)
addMisc(5023, "Can", "models/props_junk/PopCan01a.mdl", .1, 2)
addMisc(5024, "Gas Can", "models/props_junk/gascan001a.mdl", 3, 25)
addMisc(5025, "Tea Kettle", "models/props_interiors/pot01a.mdl", 1, 5)
addMisc(5026, "Tin Can", "models/props_junk/garbage_metalcan001a.mdl", .1, 1)
addMisc(5027, "Broken helicopter piece", "models/Gibs/helicopter_brokenpiece_02.mdl", 2, 100)

// Mining Materials
addMisc(5028, "Rock", "models/ores/rock_ore.mdl", 0.25, 10)
addMisc(5029, "Copper", "models/ores/copper_ore.mdl", 0.25, 100)
addMisc(5030, "Silver", "models/ores/silver_ore.mdl", 0.25, 250)
addMisc(5031, "Gold", "models/ores/gold_ore.mdl", 0.25, 750)
addMisc(5032, "Crystal", "models/scalpet/crystal.mdl", 0.25, 1250)


addMisc(5033, "Wooden stick", "models/gibs/wood_gib01a.mdl", 1, 15)
addMisc(5034, "Sheet metal", "models/props_phx/construct/metal_plate1.mdl", 3, 1500)
addMisc(5035, "Pipe", "models/props_canal/mattpipe.mdl", 2, 75)


// Crystal
addMisc(5036, "Holo Disk", "models/holodisk/holodisk.mdl", 1.5, 250)

// Copper and Gold
addMisc(5037, "Conduit", "models/mosi/fallout4/electrical/conduits/conduit.mdl", 1, 25)
addMisc(5038, "Switchbox", "models/mosi/fallout4/electrical/conduits/switchbox.mdl", 2, 75)

addMisc(5039, "Crystal Shard", "models/scalpet/crystalshar.mdl", 0.25, 500)
addMisc(5041, "Claw", "models/Halokiller38/fallout/weapons/Melee/deathclawgauntlet.mdl", 0.25, 75)
addMisc(5042, "Hide", "models/Gibs/HGIBS_scapula.mdl", 0.25, 25)
addMisc(5043, "Leather", "models/Gibs/HGIBS_scapula.mdl", 0.25, 75 )
addMisc(5044, "Cloth", "models/cloth/clothwind01.mdl", 0.5, 25)
addMisc(5045, "Cotton", "models/weapons/w_snowball.mdl", 0.25, 15)
addMisc(5046, "Sage", "models/props/cs_office/Snowman_arm.mdl", 0.25, 5)
