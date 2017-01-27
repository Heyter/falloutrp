
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

addMisc(5001, "Hammer", "models/clutter/hammer.mdl", 1, 5)
addMisc(5002, "Iron", "models/clutter/iorn.mdl", 1.5, 10)
addMisc(5003, "Plate", "models/clutter/plate.mdl", .5, 1)
addMisc(5004, "Ashtray", "models/clutter/ashtray.mdl", 1, 1)
addMisc(5005, "Book", "models/clutter/book.mdl", .5, 1)
addMisc(5006, "Camera", "models/clutter/camara.mdl", 1, 5)
addMisc(5007, "Checkerboard", "models/clutter/chessboard.mdl", 1, 3)
addMisc(5008, "Pan", "models/clutter/cookingpan.mdl", 2, 2)
addMisc(5009, "Kitchen Knife", "models/clutter/eatingknife.mdl", 1, 2)
addMisc(5010, "Garden Gnome", "models/clutter/gardengnome.mdl", 3, 5)
addMisc(5011, "Pitcher", "models/clutter/glasspitcher.mdl", 1, 1)
addMisc(5012, "Plunger", "models/clutter/plunger.mdl", 1, 1)
addMisc(5013, "Rake", "models/clutter/rake.mdl", 3, 2)
addMisc(5014, "Scrap Metal", "models/clutter/scrapmetal.mdl", 2, 5)
addMisc(5015, "Spatula", "models/clutter/spatula.mdl", 1, 1)
addMisc(5016, "Teddy Bear", "models/clutter/teddybear.mdl", .5, 1)
addMisc(5017, "Tray", "models/clutter/tray.mdl", 2, 1) 
addMisc(5018, "Wrench", "models/clutter/wrench.mdl", 1.5, 1)
addMisc(5019, "Spork", "models/clutter/spork.mdl", .5, 1)
addMisc(5020, "Whisky Bottle", "models/clutter/whiskeybottle.mdl", .5, 1)
addMisc(5021, "Empty Blood Bag", "models/mosi/fallout4/props/aid/bloodbagempty.mdl", .5, 1)
addMisc(5022, "Blood Bag", "models/mosi/fallout4/props/aid/bloodbag.mdl", 1.5, 10)
addMisc(5023, "Can", "models/props_junk/PopCan01a.mdl", .5, 2)
addMisc(5024, "Gas Can", "models/props_junk/gascan001a.mdl", 3, 2)
addMisc(5025, "Tea Kettle", "models/props_interiors/pot01a.mdl", 2, 3)
addMisc(5026, "Tin Can", "models/props_junk/garbage_metalcan001a.mdl", .5, 1)
addMisc(5027, "Broken helicopter piece", "models/Gibs/helicopter_brokenpiece_02.mdl", 1.5, 15)

// Mining Materials
addMisc(5028, "Rock", "models/ores/rock_ore.mdl", 0.25, 5)
addMisc(5029, "Copper", "models/ores/copper_ore.mdl", 0.25, 5)
addMisc(5030, "Silver", "models/ores/silver_ore.mdl", 0.25, 5)
addMisc(5031, "Gold", "models/ores/gold_ore.mdl", 0.25, 5)
addMisc(5032, "Crystal", "models/scalpet/crystal.mdl", 0.25, 5)
//addMisc(5002, "Wrench", "models/props_c17/tools_wrench01a.mdl", 1.5, 15)
