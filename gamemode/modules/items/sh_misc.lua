
local Misc = Misc or {}

local mt = {
	__call = function(table, id, name, rarity, model, weight, value, material, quest)
		local misc = {
			name = name,
			rarity = rarity,
			model = model,
			weight = weight,
			value = value,
			material = material,
			quest = quest
		}
		setmetatable(misc, {__index = ITEM})

		function misc:isMaterial()
			return self.material
		end

		Misc[id] = misc
		return misc
	end
}
setmetatable(Misc, mt)

function findMisc(id)
	if id then
		return Misc[id]
	end
end

local meta = FindMetaTable("Player")

function meta:getMiscWeightTotal()
	local weight = 0

	for k,v in pairs(self.inventory.misc) do
		local itemWeight = v.quantity * findMisc(v.classid):getWeight()

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

function meta:getMiscQuantity(uniqueid)
	local quantity = self.inventory.misc[uniqueid]["quantity"]

	return quantity or 1
end

timer.Simple(5, function()
	Misc(5001, "Hammer", RARITY_WHITE, "models/clutter/hammer.mdl", .5, 20)
	Misc(5002, "Iron", RARITY_WHITE, "models/clutter/iorn.mdl", 1, 25)
	Misc(5003, "Plate", RARITY_WHITE, "models/clutter/plate.mdl", .2, 5)
	Misc(5004, "Ashtray", RARITY_WHITE, "models/clutter/ashtray.mdl", .1, 3)
	Misc(5005, "Book", RARITY_WHITE, "models/clutter/book.mdl", .5, 40)
	Misc(5006, "Camera", RARITY_WHITE, "models/clutter/camara.mdl", 1, 50)
	Misc(5007, "Checkerboard", RARITY_WHITE, "models/clutter/chessboard.mdl", .5, 35)
	Misc(5008, "Pan", RARITY_WHITE, "models/clutter/cookingpan.mdl", 1.5, 10)
	Misc(5009, "Kitchen Knife", RARITY_WHITE, "models/clutter/eatingknife.mdl", .5, 10)
	Misc(5010, "Garden Gnome", RARITY_WHITE, "models/clutter/gardengnome.mdl", 3, 5)
	Misc(5011, "Pitcher", RARITY_WHITE, "models/clutter/glasspitcher.mdl", .2, 2)
	Misc(5012, "Plunger", RARITY_WHITE, "models/clutter/plunger.mdl", .5, 3)
	Misc(5013, "Rake", RARITY_WHITE, "models/clutter/rake.mdl", 2, 5)
	Misc(5014, "Scrap Metal", RARITY_WHITE, "models/clutter/scrapmetal.mdl", 2, 20)
	Misc(5015, "Spatula", RARITY_WHITE, "models/clutter/spatula.mdl", 1, 2)
	Misc(5016, "Teddy Bear", RARITY_WHITE, "models/clutter/teddybear.mdl", .5, 50)
	Misc(5017, "Tray", RARITY_WHITE, "models/clutter/tray.mdl", .5, 2)
	Misc(5018, "Wrench", RARITY_WHITE, "models/clutter/wrench.mdl", 1.5, 5)
	Misc(5019, "Spork", RARITY_WHITE, "models/clutter/spork.mdl", .1, 1)
	Misc(5020, "Whisky Bottle", RARITY_WHITE, "models/clutter/whiskeybottle.mdl", 1, 15)
	Misc(5021, "Empty Blood Bag", RARITY_WHITE, "models/mosi/fallout4/props/aid/bloodbagempty.mdl", .5, 2)
	Misc(5022, "Blood Bag", RARITY_WHITE, "models/mosi/fallout4/props/aid/bloodbag.mdl", 1.5, 5)
	Misc(5023, "Can", RARITY_WHITE, "models/props_junk/PopCan01a.mdl", .1, 2)
	Misc(5024, "Gas Can", RARITY_WHITE, "models/props_junk/gascan001a.mdl", 3, 16)
	Misc(5025, "Tea Kettle", RARITY_WHITE, "models/props_interiors/pot01a.mdl", 1, 3)
	Misc(5026, "Tin Can", RARITY_WHITE, "models/props_junk/garbage_metalcan001a.mdl", .1, 1)
	Misc(5027, "Broken helicopter piece", RARITY_WHITE, "models/Gibs/helicopter_brokenpiece_02.mdl", 2, 50)

	// Mining Materials
	Misc(5028, "Rock", RARITY_WHITE, "models/ores/rock_ore.mdl", 0.25, 15, true)
	Misc(5029, "Copper", RARITY_WHITE, "models/ores/copper_ore.mdl", 0.25, 50, true)
	Misc(5030, "Silver", RARITY_WHITE, "models/ores/silver_ore.mdl", 0.25, 125, true)
	Misc(5031, "Gold", RARITY_WHITE, "models/ores/gold_ore.mdl", 0.25, 200, true)
	Misc(5032, "Crystal", RARITY_WHITE, "models/scalpet/crystal.mdl", 0.25, 350, true)


	Misc(5033, "Wooden stick", RARITY_WHITE, "models/gibs/wood_gib01a.mdl", 1, 10, true)
	Misc(5034, "Sheet metal", RARITY_WHITE, "models/props_phx/construct/metal_plate1.mdl", 3, 40, true)
	Misc(5035, "Pipe", RARITY_WHITE, "models/props_canal/mattpipe.mdl", 2, 175, true)


	// Crystal
	Misc(5036, "Holo Disk", RARITY_WHITE, "models/holodisk/holodisk.mdl", 1.5, 150, true)

	// Copper and Gold
	Misc(5037, "Conduit", RARITY_WHITE, "models/mosi/fallout4/electrical/conduits/conduit.mdl", 1, 17, true)
	Misc(5038, "Switchbox", RARITY_WHITE, "models/mosi/fallout4/electrical/conduits/switchbox.mdl", 2, 37, true)

	Misc(5039, "Crystal Shard", RARITY_WHITE, "models/scalpet/crystalshar.mdl", 0.25, 150, true)
	Misc(5040, "Plasma", RARITY_WHITE, "models/scalpet/crystalshar.mdl", 0.25, 300)
	Misc(5041, "Claw", RARITY_WHITE, "models/Halokiller38/fallout/weapons/Melee/deathclawgauntlet.mdl", 0.25, 35, true)
	Misc(5042, "Hide", RARITY_WHITE, "models/Gibs/HGIBS_scapula.mdl", 0.25, 15, true)
	Misc(5043, "Leather", RARITY_WHITE, "models/Gibs/HGIBS_scapula.mdl", 0.25, 30, true)
	Misc(5044, "Cloth", RARITY_WHITE, "models/cloth/clothwind01.mdl", 0.5, 10, true)
	Misc(5045, "Cotton", RARITY_WHITE, "models/weapons/w_snowball.mdl", 0.25, 5, true)
	Misc(5046, "Sage", RARITY_WHITE, "models/props/cs_office/Snowman_arm.mdl", 0.25, 15, true)

	// Quest Items
	Misc(5047, "Mr. Fuzzypants", RARITY_WHITE, "models/tsbb/animals/linsang.mdl", 0.5, 0, false, true)
	Misc(5048, "Valuables", RARITY_WHITE, "models/props_c17/BriefCase001a.mdl", 0.5, 0, false, true)
	Misc(5051, "Engine", RARITY_WHITE, "models/props_c17/trappropeller_engine.mdl", 25, 0, false, true)
	Misc(5052, "Blood Bag", RARITY_WHITE, "models/mosi/fallout4/props/aid/bloodbag.mdl", 2, 0, false, true)
	Misc(5053, "Painkillers", RARITY_WHITE, "models/mosi/fallout4/props/aid/daytripper.mdl", .1, 0, false, true)
	Misc(5054, "Morphine", RARITY_WHITE, "models/mosi/fallout4/props/aid/medx.mdl", .1, 0, false, true)
	Misc(5055, "Ghoul Valuables", RARITY_WHITE, "models/props_c17/BriefCase001a.mdl", 2, 0, false, true)
	Misc(5056, "Helicopter Weapon", RARITY_WHITE, "models/Items/combine_rifle_ammo01.mdl", 5, 0, false, true)
	Misc(5057, "Radaway", RARITY_WHITE, "models/mosi/fallout4/props/aid/radx.mdl", .5, 0, false, true)
	Misc(5058, "Food Rations", RARITY_WHITE, "models/props/cs_assault/box_stack1.mdl", .5, 0, false, true)
	Misc(5059, "Water Rations", RARITY_WHITE, "models/props/cs_assault/dryer_box.mdl", .5, 0, false, true)
	Misc(5060, "Cementing Paste", RARITY_WHITE, "models/props_junk/plasticbucket001a.mdl", 1, 0, false, true)
	Misc(5061, "Retrieval Tool", RARITY_WHITE, "models/weapons/w_models/w_toolbox.mdl", .5, 0, false, true)
	Misc(5062, "Batteries", RARITY_WHITE, "models/items/car_battery01.mdl", .5, 0, false, true)
	Misc(5063, "Fuel Can", RARITY_WHITE, "models/props_junk/gascan001a.mdl", 1, 0, false, true)
	Misc(5064, "Mr.Whiskers", RARITY_WHITE, "models/tsbb/animals/linsang.mdl", 0.5, 0, false, true)
	Misc(5065, "Mysterious Electronic", RARITY_WHITE, "models/mosi/fallout4/electrical/generators/generator01.mdl", 25, 0, false, true)
	Misc(5066, "Rat Tail", RARITY_WHITE, "models/fallout/giantrat_bodycap_tail.mdl", 0.5, 0, false, true)
	Misc(5067, "Adult Mantis Spine", RARITY_WHITE, "models/Gibs/HGIBS_spine.mdl", 0.5, 0, false, true)
	Misc(5068, "Mantis Nymph Spine", RARITY_WHITE, "models/Gibs/HGIBS_spine.mdl", 0.5, 0, false, true)
	Misc(5069, "Swampy Ghoul Feet", RARITY_WHITE, "models/fallout/ghoulferal_bodycap_leftleg.mdl", 0.5, 0, false, true)
	Misc(5070, "Cazador Stinger", RARITY_WHITE, "models/halokiller38/fallout/weapons/melee/chancesknife.mdl", 0.5, 0, false, true)
	Misc(5071, "Cazador Wings", RARITY_WHITE, "models/gibs/gunship_gibs_wing.mdl", 0.5, 0, false, true)
	Misc(5072, "Old Computer Chip", RARITY_WHITE, "models/mosi/fallout4/electrical/conduits/conduit_vaultwall.mdl", 0.5, 0, false, true)
	Misc(5073, "Advanced V2 Computer Chip", RARITY_WHITE, "models/Items/combine_rifle_cartridge01.mdl", 0.5, 0, false, true)
	Misc(5074, "Propellor", RARITY_WHITE, "models/props_c17/TrapPropeller_Blade.mdl", 15, 0, false, true)
	Misc(5075, "Airboat Seat", RARITY_WHITE, "models/nova/airboat_seat.mdl", 5, 0, false, true)
end)
