
// Shared

SCAVENGE = {
	Metal = { 
		Sizes = {
			small = {
				Props = {
					"models/props_junk/metal_paintcan001b.mdl",
					"models/props_junk/metalbucket01a.mdl",
					"models/props_junk/metalbucket02a.mdl",
					"models/props_interiors/Furniture_chair03a.mdl",
				}, 
				Amount = {1, 3}
			}, 
			medium = {
				Props = {
					"models/props_c17/FurnitureBoiler001a.mdl",
					"models/props_c17/oildrum001.mdl",
					"models/props_wasteland/kitchen_shelf002a.mdl",
					"models/props_c17/canister02a.mdl"
				}, 
				Amount = {3, 7}
			},
			large = {
				Props = {
					"models/props_vehicles/car004b_physics.mdl",
					"models/props_vehicles/car005b_physics.mdl",
					"models/props_vehicles/car002b_physics.mdl",
					"models/props_vehicles/car003b_physics.mdl"
				}, 
				Amount = {5, 10}
			}
		},
		Positions = {
			{Position = Vector(-2210, 4472, 87), Active = false},
			{Position = Vector(-3265, 4742, 29), Active = false},
			{Position = Vector(-6357, -194, -220), Active = false},
			{Position = Vector(-5265, -4803, 0), Active = false},
			{Position = Vector(-6641, -9311, 23), Active = false},
			{Position = Vector(-8410, -9038, 102), Active = false},
			{Position = Vector(-11687, -10399, 0), Active = false},
			{Position = Vector(-13036, -7666, 2), Active = false},
			{Position = Vector(-12478, -5513, 3), Active = false},
			{Position = Vector(-13255, -2469, 11), Active = false},
			{Position = Vector(-11195, 2398, 72), Active = false},
			{Position = Vector(-10782, 7143, 0), Active = false},
		},
		Limit = 10, // How many normal veins can be on map at a time
		Default = 5014, // The default rock that is mined if the extra isn't rolled
		Extras = {[5034] = 15, [5003] = 5, [5018] = 5, [5024] = 5, [1015] = 2, [1017] = 2, [1021] = 2, [1022] = 2, [1023] = 2, [1025] = 2, [1029] = 2, [1030] = 2, [1032] = 2} // Rock = Probability %
	},	
	Herbal = { 
		Sizes = {
			small = {
				Props = {
					"models/props/de_inferno/largebush02.mdl",
					"models/props/de_inferno/largebush01.mdl"
				}, 
				Amount = {1, 3}
			}, 
			medium = {
				Props = {
					"models/props/de_inferno/largebush06.mdl",
				}, 
				Amount = {3, 7}
			},
			large = {
				Props = {
					"models/props/de_inferno/planterplantsvertex.mdl", 
					"models/props/CS_militia/vine_wall2.mdl"
				}, 
				Amount = {5, 10}
			}
		},
		Positions = {
			{Position = Vector(-4331, 8556, 0), Active = false},
			{Position = Vector(-4930, 9444, 0), Active = false},
			{Position = Vector(-2945, 10425, 0), Active = false},
			{Position = Vector(-709, 11702, 0), Active = false},
			{Position = Vector(742, 9218, 0), Active = false},
			{Position = Vector(1368, 8241, 38), Active = false},
			{Position = Vector(2641, 8208, 2), Active = false},
			{Position = Vector(3582, 12324, 37), Active = false},
			{Position = Vector(6681, 13271, 11), Active = false},
			{Position = Vector(8134, 13343, 0), Active = false},
			{Position = Vector(12568, 5253, 18), Active = false},
			{Position = Vector(10776, -4295, -8), Active = false},
		},
		Limit = 10, // How many normal veins can be on map at a time
		Default = 5045, // The default rock that is mined if the extra isn't rolled
		Extras = {[5046] = 10, [4008] = 30, [4013] = 30} // Rock = Probability %
	},	
	Wood = { 
		Sizes = {
			small = {
				Props = {
					"models/props/de_prodigy/wood_pallet_debris_01.mdl",
					"models/props_lab/dogobject_wood_crate001a_damagedmax.mdl",
					"models/props_c17/woodbarrel001.mdl",
					"models/props/de_prodigy/wood_pallet_01.mdl"
				}, 
				Amount = {1, 3}
			}, 
			medium = {
				Props = {
					"models/props/cs_militia/ladderwood.mdl",
					"models/props/cs_militia/fencewoodlog02_short.mdl",
					"models/props/cs_militia/wood_bench.mdl",
					"models/props_interiors/Furniture_shelf01a.mdl"
				}, 
				Amount = {3, 7}
			},
			large = {
				Props = {
					"models/props_foliage/driftwood_clump_02a.mdl",
					"models/props_foliage/driftwood_clump_03a.mdl",
					"models/props/cs_militia/fencewoodlog04_long.mdl",
					"models/props/cs_militia/shelves_wood.mdl"
				}, 
				Amount = {5, 10}
			}
		}, 
		Positions = {
			{Position = Vector(9682, -3524, 41), Active = false},
			{Position = Vector(12454, -7239, 35), Active = false},
			{Position = Vector(9499, -13280, 4), Active = false},
			{Position = Vector(7731, -13201, 11), Active = false},
			{Position = Vector(523, -11384, 6), Active = false},
			{Position = Vector(375, -9888, 19), Active = false},
			{Position = Vector(-1960, -8933, 0), Active = false},
			{Position = Vector(-4913, -9069, 16), Active = false},
			{Position = Vector(-10658, -12072, 0), Active = false},
			{Position = Vector(-9984, -12674, 0), Active = false},
			{Position = Vector(-8579, 1014, -7), Active = false},
			{Position = Vector(-6376, 7167, 5), Active = false},
			{Position = Vector(-4666, 13170, 6), Active = false},
			{Position = Vector(-4137, 13695, 7), Active = false},
			{Position = Vector(14108, -4048, 59), Active = false},
			{Position = Vector(13773, -7856, 24), Active = false},
			{Position = Vector(8118, -7337, 0), Active = false},
		},
		Limit = 12, // How many normal veins can be on map at a time
		Default = 5033, // The default rock that is mined if the extra isn't rolled
		Extras = {[5029] = 30} // Rock = Probability %
	},
}

SCAVENGE_START = 3 // How many of each type start on the map
SCAVENGE_TIMER = 60 // How often we try to spawn a new vein (seconds)
SCAVENGE_SOUND = "pickaxe/deploy.wav" // Sound made when a vein is mined successfully