
// NPC Config
NPCS = {
	["npc_giantrat"] = {
		Name = "Giant Rat",
		Level = 15,
		Health = 350,
		Limit = 30, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 10, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 75,
		Loot = {
			[4014] = {quantity = {1, 2}, prob = 80},
			[5042] = {quantity = {1, 3}, prob = 80},
		},
		Positions = {
			{Position = Vector(10022, -2350, 33), Active = false},
			{Position = Vector(10475, -2772, 30), Active = false},
			{Position = Vector(9957, -2546, 39), Active = false},
			{Position = Vector(10316, -2509, 32), Active = false},
			{Position = Vector(10170, -2685, 42), Active = false},
			{Position = Vector(9950, -2781, 41), Active = false},
			{Position = Vector(10280, -2916, 37), Active = false},
			{Position = Vector(10132, -2968, 43), Active = false},
			{Position = Vector(10269, -2241, 26), Active = false},
			{Position = Vector(9683, -2500, 26), Active = false},
			{Position = Vector(-12636, -1712, 26), Active = false},
			{Position = Vector(-12697, -1920, 26), Active = false},
			{Position = Vector(-12853, -1629, 26), Active = false},
			{Position = Vector(-12855, -1915, 26), Active = false},
			{Position = Vector(-12943, -1788, 26), Active = false},
			{Position = Vector(-12397, -7653, 41), Active = false},
			{Position = Vector(-12335, -7494, 53), Active = false},
			{Position = Vector(-12527, -7609, 38), Active = false},
			{Position = Vector(-12512, -7393, 51), Active = false},
			{Position = Vector(-12388, -7366, 58), Active = false},
			{Position = Vector(-9850, -8881, 29), Active = false},
			{Position = Vector(-9830, -9029, 29), Active = false},
			{Position = Vector(-9674, -8828, 33), Active = false},
			{Position = Vector(-9661, -9031, 32), Active = false},
			{Position = Vector(-9658, -9266, 26), Active = false},
			{Position = Vector(-9903, -9147, 28), Active = false},
			{Position = Vector(-9988, -8937, 28), Active = false},
			{Position = Vector(-9459, -8998, 35), Active = false},
			{Position = Vector(-9508, -9261, 26), Active = false},
			{Position = Vector(-9878, -9371, 27), Active = false},
			{Position = Vector(-4409, 5386, 26), Active = false},
			{Position = Vector(-4403, 5266, 26), Active = false},
			{Position = Vector(-4520, 5451, 26), Active = false},
			{Position = Vector(-4628, 5302, 26), Active = false},
			{Position = Vector(-4551, 5183, 26), Active = false},
			{Position = Vector(3914, 3824, 26), Active = false},
			{Position = Vector(3666, 3758, 25), Active = false},
			{Position = Vector(4039, 4138, 26), Active = false},
			{Position = Vector(3758, 4124, 26), Active = false},
			{Position = Vector(3571, 3982, 26), Active = false},
			{Position = Vector(3898, 4302, 28), Active = false},
			{Position = Vector(3658, 4357, 27), Active = false},
			{Position = Vector(4222, 3973, 33), Active = false},
			{Position = Vector(4238, 4296, 27), Active = false},
			{Position = Vector(4125, 4561, 32), Active = false},
			{Position = Vector(8734, 1893, 26), Active = false},
			{Position = Vector(8901, 2287, 26), Active = false},
			{Position = Vector(8602, 2247, 26), Active = false},
			{Position = Vector(8489, 2058, 26), Active = false},
			{Position = Vector(8947, 2030, 26), Active = false},
			{Position = Vector(7248, -1233, 26), Active = false},
			{Position = Vector(7601, -1301, 26), Active = false},
			{Position = Vector(7323, -887, 26), Active = false},
			{Position = Vector(7534, -1057, 25), Active = false},
			{Position = Vector(7874, -1056, 26), Active = false},
			{Position = Vector(3469, -5168, 37), Active = false},
			{Position = Vector(3405, -5433, 32), Active = false},
			{Position = Vector(3617, -5406, 29), Active = false},
			{Position = Vector(3638, -5256, 38), Active = false},
			{Position = Vector(3249, -5293, 34), Active = false},
			{Position = Vector(896, -7565, 26), Active = false},
			{Position = Vector(877, -7372, 26), Active = false},
			{Position = Vector(1124, -7611, 26), Active = false},
			{Position = Vector(1117, -7406, 27), Active = false},
			{Position = Vector(973, -7315, 27), Active = false},
			{Position = Vector(-5785, -6717, 26), Active = false},
			{Position = Vector(-6003, -6913, 27), Active = false},
			{Position = Vector(-5817, -7023, 26), Active = false},
			{Position = Vector(-5635, -6922, 25), Active = false},
			{Position = Vector(-5823, -6858, 26), Active = false},
			{Position = Vector(-4310, -1582, 31), Active = false},
			{Position = Vector(-4140, -1654, 34), Active = false},
			{Position = Vector(-4522, -1802, 28), Active = false},
			{Position = Vector(-4334, -2000, 31), Active = false},
			{Position = Vector(-4179, -1905, 35), Active = false}
		},	
	},
	["npc_gecko"] = {
			Name = "Gecko",
			Level = 15,
			Health = 550,
			Limit = 35, // How many can be active on the map at once
			SpawnRate = 120, // How often (seconds) we try to spawn a new one
			StartAmount = 10, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
			Experience = 115,
			Loot = {
				[4014] = {quantity = {1, 2}, prob = 80},
				[5042] = {quantity = {1, 3}, prob = 80},
			},
			Positions = {
				{Position = Vector(-11622, 3740, 0), Active = false},
				{Position = Vector(-11471, 4033, 0), Active = false},
				{Position = Vector(-11255, 4310, 0), Active = false},
				{Position = Vector(9437, 3581, 27), Active = false},
				{Position = Vector(9686, 3542, 39), Active = false},
				{Position = Vector(9980, 3600, 61), Active = false},
				{Position = Vector(5824, -2542, 0), Active = false},
				{Position = Vector(5791, -3126, 0), Active = false},
				{Position = Vector(5188, -2582, 1), Active = false},
				{Position = Vector(3379, -316, 0), Active = false},
				{Position = Vector(4172, 243, 30), Active = false},
				{Position = Vector(-2269, -5612, 0), Active = false},
				{Position = Vector(-2102, -5733, 0), Active = false},
				{Position = Vector(-2151, -6078, 0), Active = false},
				{Position = Vector(-8547, 3976, 4), Active = false},
				{Position = Vector(-8724, 4239, 3), Active = false},
				{Position = Vector(-8881, 3836, 2), Active = false},
				{Position = Vector(288, 3465, 3), Active = false},
				{Position = Vector(368, 4102, 0), Active = false},
				{Position = Vector(1002, 3358, 0), Active = false},
				{Position = Vector(-2002, 5324, 95), Active = false},
				{Position = Vector(-2562, 5083, 103), Active = false},
				{Position = Vector(-2212, 5937, 64), Active = false},
				{Position = Vector(-1269, 13591, 0), Active = false},
				{Position = Vector(-1077, 13089, 5), Active = false},
				{Position = Vector(-838, 13455, 2), Active = false},
				{Position = Vector(5004, -5624, 26), Active = false},
				{Position = Vector(5509, -5601, 22), Active = false},
				{Position = Vector(4911, -5202, 82), Active = false},
				{Position = Vector(-2631, -9836, 2), Active = false},
				{Position = Vector(-2404, -10135, 4), Active = false},
				{Position = Vector(-2858, -10322, 0), Active = false},
				{Position = Vector(-4566, -10507, 0), Active = false},
				{Position = Vector(-4857, -10466, 0), Active = false},
				{Position = Vector(-12125, -4639, 43), Active = false},
				{Position = Vector(-12704, -4387, 28), Active = false},
				{Position = Vector(-12308, -4147, 5), Active = false},
				{Position = Vector(-11899, 547, 52), Active = false},
				{Position = Vector(-12128, 1131, 17), Active = false},
				{Position = Vector(-12405, 584, 1), Active = false},
				{Position = Vector(-7068, 3872, 115), Active = false},
				{Position = Vector(-6749, 3499, 194), Active = false},
				{Position = Vector(-7108, 3525, 149), Active = false},
				{Position = Vector(-635, 8803, 61), Active = false},
				{Position = Vector(-93, 8564, 16), Active = false},
				{Position = Vector(-151, 9227, 16), Active = false},
				{Position = Vector(7664, 4403, 0), Active = false},
				{Position = Vector(7536, 5030, 6), Active = false},
				{Position = Vector(3174, 11977, 57), Active = false}
			},		
	},
	["npc_gecko_fire"] = {
			Name = "Fire Gecko",
			Level = 50,
			Health = 1000,
			Limit = 10, // How many can be active on the map at once
			SpawnRate = 120, // How often (seconds) we try to spawn a new one
			StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
			Experience = 250,
			Loot = {
				[4014] = {quantity = {1, 2}, prob = 80},
				[5042] = {quantity = {1, 3}, prob = 80},
				[5036] = {quantity = {1, 2}, prob = 5},
				[5039] = {quantity = {1, 2}, prob = 5},
			},
			Positions = {
				{Position = Vector(3984, -345, 0), Active = false},
				{Position = Vector(-4768, -10181, 0), Active = false},
				{Position = Vector(7057, 4396, -5), Active = false},
				{Position = Vector(-2102, -5733, 0), Active = false},
				{Position = Vector(7771, -11686, 16), Active = false},
				{Position = Vector(7988, -11684, 16), Active = false},
				{Position = Vector(7929, -11168, 16), Active = false},
				{Position = Vector(7246, -11255, 16), Active = false},
				{Position = Vector(10823, -11133, 37), Active = false},
				{Position = Vector(10682, -11093, 38), Active = false},
				{Position = Vector(11035, -10979, 32), Active = false},
				{Position = Vector(10638, -10922, 32), Active = false},
				{Position = Vector(6460, -12452, 17), Active = false},
				{Position = Vector(6595, -12163, 16), Active = false},
				{Position = Vector(6716, -12403, 17), Active = false},
				{Position = Vector(7829, -12142, 16), Active = false},
				{Position = Vector(7795, -12333, 16), Active = false},
				{Position = Vector(3438, -12257, 16), Active = false},
				{Position = Vector(3617, -12103, 16), Active = false},
				{Position = Vector(-13348, 2870, 32), Active = false},
				{Position = Vector(-13279, 2809, 40), Active = false},
				{Position = Vector(-13453, 6087, 15), Active = false},
				{Position = Vector(-13562, 6065, 14), Active = false},
				{Position = Vector(-13459, 5832, 14), Active = false},
			},		
	},
	["npc_mantis"] = {
			Name = "Giant Mantis",
			Level = 15,
			Health = 475,
			Limit = 20, // How many can be active on the map at once
			SpawnRate = 120, // How often (seconds) we try to spawn a new one
			StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
			Experience = 75,
			Loot = {
				[4014] = {quantity = {1, 2}, prob = 80},
				[5042] = {quantity = {1, 3}, prob = 80},
			},
			Positions = {
				{Position = Vector(4572, -1241, 29), Active = false},
				{Position = Vector(4226, -1322, 17), Active = false},
				{Position = Vector(4388, -1607, 29), Active = false},
				{Position = Vector(-2017, 1382, 29), Active = false},
				{Position = Vector(12103, -3275, 52), Active = false},
				{Position = Vector(12384, -3273, 53), Active = false},
				{Position = Vector(-2211, 1153, 29), Active = false},
				{Position = Vector(12674, -3300, 41), Active = false},
				{Position = Vector(-2414, 1023, 29), Active = false},
				{Position = Vector(13976, -9696, 42), Active = false},
				{Position = Vector(1148, -3533, 29), Active = false},
				{Position = Vector(14206, -10265, 52), Active = false},
				{Position = Vector(1261, -3255, 29), Active = false},
				{Position = Vector(5833, -13632, 53), Active = false},
				{Position = Vector(6549, -13749, 63), Active = false},
				{Position = Vector(6509, -13601, 65), Active = false},
				{Position = Vector(1450, -2966, 29), Active = false},
				{Position = Vector(2572, -14028, 90), Active = false},
				{Position = Vector(3178, -14005, 99), Active = false},
				{Position = Vector(1179, -12296, 55), Active = false},
				{Position = Vector(972, -12162, 39), Active = false},
				{Position = Vector(966, -8367, 73), Active = false},
				{Position = Vector(-2658, -12040, 100), Active = false},
				{Position = Vector(-2870, -11791, 54), Active = false},
				{Position = Vector(-2562, -11717, 115), Active = false},
				{Position = Vector(1248, -8301, 58), Active = false},
				{Position = Vector(-7275, -13526, 34), Active = false},
				{Position = Vector(1393, -8385, 56), Active = false},
				{Position = Vector(-7303, -9258, 73), Active = false},
				{Position = Vector(-7205, -9362, 60), Active = false},
				{Position = Vector(-13505, 127, 29), Active = false},
				{Position = Vector(-8507, 5458, 33), Active = false}
			},		
	},
	["npc_mantis_nymph"] = {
			Name = "Giant Mantis Nymph",
			Level = 15,
			Health = 350,
			Limit = 8, // How many can be active on the map at once
			SpawnRate = 120, // How often (seconds) we try to spawn a new one
			StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
			Experience = 60,
			Loot = {
				[4014] = {quantity = {1, 2}, prob = 80},
				[5042] = {quantity = {1, 3}, prob = 80}
			},
			Positions = {
				{Position = Vector(-7397, -9370, 73), Active = false},
				{Position = Vector(13769, -10042, 40), Active = false},
				{Position = Vector(4226, -1322, 17), Active = false},
				{Position = Vector(-9846, 5442, 29), Active = false},
				{Position = Vector(-2870, -11791, 54), Active = false},
				{Position = Vector(-13226, 215, 29), Active = false},
				{Position = Vector(-13046, 413, 29), Active = false},
				{Position = Vector(-12963, 652, 29), Active = false},
				{Position = Vector(-9430, 5711, 29), Active = false},
				{Position = Vector(-9630, 5529, 29), Active = false},
			},		
	},
	["npc_cazador"] = {
			Name = "Cazador",
			Level = 30,
			Health = 675,
			Limit = 25, // How many can be active on the map at once
			SpawnRate = 120, // How often (seconds) we try to spawn a new one
			StartAmount = 5, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
			Experience = 120,
			Loot = {
				[4014] = {quantity = {1, 2}, prob = 80},
				[5043] = {quantity = {1, 3}, prob = 80},
			},
			Positions = {
				{Position = Vector(5855, 3022, 28), Active = false},
				{Position = Vector(6088, 2997, 22), Active = false},
				{Position = Vector(9453, 869, 75), Active = false},
				{Position = Vector(9139, 684, 63), Active = false},
				{Position = Vector(13304, -5179, 371), Active = false},
				{Position = Vector(13128, -5070, 356), Active = false},
				{Position = Vector(-5084, -12377, 79), Active = false},
				{Position = Vector(-5159, -11998, 59), Active = false},
				{Position = Vector(-9795, -5761, 465), Active = false},
				{Position = Vector(-9605, -5778, 434), Active = false},
				{Position = Vector(-13327, -8077, 106), Active = false},
				{Position = Vector(-13611, -8010, 89), Active = false},
				{Position = Vector(-7388, -10939, 23), Active = false},
				{Position = Vector(-7072, -10912, 21), Active = false},
				{Position = Vector(-3432, -13368, 19), Active = false},
				{Position = Vector(-3488, -13605, 21), Active = false},
				{Position = Vector(11966, -10498, 27), Active = false},
				{Position = Vector(12105, -10542, 22), Active = false},
				{Position = Vector(-11080, -3957, 104), Active = false},
				{Position = Vector(13874, 5969, 35), Active = false},
				{Position = Vector(13918, 5893, 35), Active = false},
				{Position = Vector(-11256, -3656, 84), Active = false},
				{Position = Vector(14113, 8987, 73), Active = false},
				{Position = Vector(14083, 8864, 90), Active = false},
				{Position = Vector(-11041, 7077, 22), Active = false},
				{Position = Vector(-10945, 6768, 22), Active = false},
				{Position = Vector(944, 12363, 31), Active = false},
				{Position = Vector(992, 12451, 40), Active = false},
				{Position = Vector(-7290, 6224, 161), Active = false},
				{Position = Vector(-7132, 6560, 157), Active = false},
				{Position = Vector(-3088, 12045, 2), Active = false},
				{Position = Vector(-3111, 12144, 0), Active = false},
			},	
	},
	/*
	["npc_gecko_golden"] = {
			Name = "Feral Ghoul",
			Health = 400,
			Limit = 40, // How many can be active on the map at once
			SpawnRate = 120, // How often (seconds) we try to spawn a new one
			StartAmount = 5, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
			Experience = 35,
			Loot = {
				[4014] = {quantity = {1, 2}, prob = 80},
				[5042] = {quantity = {1, 3}, prob = 80},
				[5029] = {quantity = {1, 2}, prob = 25},
				[5030] = {quantity = {1, 2}, prob = 25},
				[5031] = {quantity = {1, 2}, prob = 25},
				[5032] = {quantity = {1, 2}, prob = 10},
				[5041] = {quantity = {1, 1}, prob = 1},
			},
			Positions = {
				{Position = Vector(-9756, -11314, 20), Active = false},
				{Position = Vector(-9740, -11444, 18), Active = false},
				{Position = Vector(-10766, -11336, 14), Active = false},
				{Position = Vector(-10373, -11360, 17), Active = false},
				{Position = Vector(-10574, -12667, 15), Active = false},
				{Position = Vector(-9008, -13259, 128), Active = false},
				{Position = Vector(-8162, -13141, 23), Active = false},
				{Position = Vector(-8271, -12863, 18), Active = false},
				{Position = Vector(-8911, -12796, 14), Active = false},
				{Position = Vector(-9071, -13248, 15), Active = false},
				{Position = Vector(-8936, -13289, 16), Active = false},
				{Position = Vector(-9427, -11751, 16), Active = false},
				{Position = Vector(-9835, -11686, 18), Active = false},
				{Position = Vector(-9388, -13223, 15), Active = false},
				{Position = Vector(-9037, -12305, 15), Active = false},
				{Position = Vector(-7930, -12224, 14), Active = false},
				{Position = Vector(-9439, -13681, 15), Active = false},
				{Position = Vector(-8593, -13703, 15), Active = false},
				{Position = Vector(-9070, -13563, 14), Active = false},
				{Position = Vector(-9190, -14138, 15), Active = false},
				{Position = Vector(-9924, -13907, 15), Active = false},
				{Position = Vector(-9908, -13585, 15), Active = false},
				{Position = Vector(7736, -8607, 16), Active = false},
				{Position = Vector(7654, -8729, 17), Active = false},
				{Position = Vector(7551, -8560, 16), Active = false},
				{Position = Vector(4568, -9454, 22), Active = false},
				{Position = Vector(7963, -8488, 17), Active = false},
				{Position = Vector(4816, -8798, 22), Active = false},
				{Position = Vector(4670, -9616, 22), Active = false},
				{Position = Vector(6919, -11227, 16), Active = false},
				{Position = Vector(6680, -11088, 16), Active = false},
				{Position = Vector(6763, -11253, 16), Active = false},
				{Position = Vector(4620, -9078, 158), Active = false},
				{Position = Vector(3946, -11184, 17), Active = false},
				{Position = Vector(3750, -11026, 16), Active = false},
				{Position = Vector(3758, -11327, 16), Active = false},
				{Position = Vector(3579, -11136, 17), Active = false},
				{Position = Vector(4710, -9213, 22), Active = false},
				{Position = Vector(3517, -9424, 16), Active = false},
				{Position = Vector(3728, -9389, 16), Active = false},
				{Position = Vector(3692, -9594, 16), Active = false},
				{Position = Vector(5703, -9230, 22), Active = false},
				{Position = Vector(5676, -8770, 22), Active = false},
				{Position = Vector(5128, -9503, 17), Active = false},
				{Position = Vector(5314, -9563, 16), Active = false},
				{Position = Vector(5186, -9658, 16), Active = false},
				{Position = Vector(5798, -9029, 158), Active = false},
				{Position = Vector(5771, -9526, 158), Active = false},
				{Position = Vector(6214, -9575, 17), Active = false},
				{Position = Vector(6244, -9400, 16), Active = false},
				{Position = Vector(6217, -9095, 17), Active = false},
				{Position = Vector(6427, -9340, 16), Active = false},
				{Position = Vector(5985, -11368, 16), Active = false},
				{Position = Vector(5635, -11352, 16), Active = false},
				{Position = Vector(4730, -11442, 16), Active = false},
				{Position = Vector(4788, -11669, 16), Active = false},
				{Position = Vector(5544, -11931, 16), Active = false},
				{Position = Vector(5999, -11680, 16), Active = false},
				{Position = Vector(8228, -10088, 16), Active = false},
				{Position = Vector(8074, -10041, 16), Active = false},
				{Position = Vector(7087, -12552, 16), Active = false},
				{Position = Vector(7447, -12575, 16), Active = false},
				{Position = Vector(7108, -11844, 16), Active = false},
				{Position = Vector(7771, -11686, 16), Active = false},
				{Position = Vector(7988, -11684, 16), Active = false},
				{Position = Vector(7929, -11168, 16), Active = false},
				{Position = Vector(7246, -11255, 16), Active = false},
				{Position = Vector(10823, -11133, 37), Active = false},
				{Position = Vector(10682, -11093, 38), Active = false},
				{Position = Vector(11035, -10979, 32), Active = false},
				{Position = Vector(10638, -10922, 32), Active = false},
				{Position = Vector(6460, -12452, 17), Active = false},
				{Position = Vector(6595, -12163, 16), Active = false},
			},		
		},
	*/
	["npc_gecko_green"] = {
			Name = "Green Gecko",
			Level = 30,
			Health = 1500,
			Limit = 12, // How many can be active on the map at once
			SpawnRate = 120, // How often (seconds) we try to spawn a new one
			StartAmount = 2, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
			Experience = 125,
			Loot = {
				[4014] = {quantity = {1, 2}, prob = 80},
				[5042] = {quantity = {1, 3}, prob = 80},
				[5029] = {quantity = {1, 4}, prob = 25},
				[5030] = {quantity = {1, 3}, prob = 10},
				[5031] = {quantity = {1, 2}, prob = 5},
				[5032] = {quantity = {1, 2}, prob = 2},
				[5041] = {quantity = {1, 2}, prob = 10},
			},
			Positions = {
				{Position = Vector(7695, -12192, 17), Active = false},
				{Position = Vector(3350, -12114, 17), Active = false},
				{Position = Vector(6484, -11916, 16), Active = false},
				{Position = Vector(8305, -9928, 16), Active = false},
				{Position = Vector(7998, -8428, 17), Active = false},
				{Position = Vector(4551, -8735, 22), Active = false},
				{Position = Vector(6716, -12403, 17), Active = false},
				{Position = Vector(7829, -12142, 16), Active = false},
				{Position = Vector(7795, -12333, 16), Active = false},
				{Position = Vector(3438, -12257, 16), Active = false},
				{Position = Vector(3617, -12103, 16), Active = false},
				{Position = Vector(-13348, 2870, 32), Active = false},
				{Position = Vector(-13279, 2809, 40), Active = false},
				{Position = Vector(-13453, 6087, 15), Active = false},
				{Position = Vector(-13562, 6065, 14), Active = false},
				{Position = Vector(-13459, 5832, 14), Active = false},
			},		
	},
	["npc_deathclaw"] = { 
		Name = "Deathclaw",
		Level = 50,
		Health = 2000,
		Limit = 20, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 4, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 250,
		Loot = {
			[4014] = {quantity = {1, 8}, prob = 80},
			[5043] = {quantity = {1, 6}, prob = 80},
			[5029] = {quantity = {1, 6}, prob = 25},
			[5030] = {quantity = {1, 4}, prob = 8},
			[5031] = {quantity = {1, 2}, prob = 4},
			[5032] = {quantity = {1, 2}, prob = 2},
			[5040] = {quantity = {1, 1}, prob = 4},
			[5041] = {quantity = {1, 5}, prob = 50},
			[5039] = {quantity = {1, 1}, prob = 15},
		},		
		Positions = {
			{Position = Vector(9659, 10653, 23), Active = false},
			{Position = Vector(-6300, -5143, 0), Active = false},
			{Position = Vector(11523, 10179, 8), Active = false},
			{Position = Vector(-12517, -491, 16), Active = false},
			{Position = Vector(7174, 7548, -1), Active = false},
			{Position = Vector(-11511, 5340, 2), Active = false},
			{Position = Vector(9109, 5860, 0), Active = false},
			{Position = Vector(11615, 6189, 3), Active = false},
			{Position = Vector(4598, 8384, 9), Active = false},
			{Position = Vector(3380, 10812, 16), Active = false},
			{Position = Vector(5940, 11176, 1), Active = false},
			{Position = Vector(10223, 13343, 1), Active = false},
			{Position = Vector(7755, 11330, 1), Active = false},
			{Position = Vector(8480, 13004, 0), Active = false},
			{Position = Vector(13831, -3658, 10), Active = false},
			{Position = Vector(6650, -10404, 16), Active = false},
			{Position = Vector(3404, 8540, 10), Active = false},
			{Position = Vector(5891, 8115, 6), Active = false},
			{Position = Vector(7728, 10293, 0), Active = false},
			{Position = Vector(7070, 9469, 0), Active = false},
			{Position = Vector(-11945, 4054, 2), Active = false},
			{Position = Vector(8838, 923, 5), Active = false},
			{Position = Vector(8147, -286, 0), Active = false},
			{Position = Vector(-4828, -11729, 0), Active = false},
			{Position = Vector(-10766, -11336, 14), Active = false},
			{Position = Vector(-10373, -11360, 17), Active = false},
			{Position = Vector(-10574, -12667, 15), Active = false},
			{Position = Vector(-9008, -13259, 128), Active = false},
			{Position = Vector(-8162, -13141, 23), Active = false},
			{Position = Vector(-8271, -12863, 18), Active = false},
			{Position = Vector(-8911, -12796, 14), Active = false},
			{Position = Vector(-9071, -13248, 15), Active = false},
			{Position = Vector(-8936, -13289, 16), Active = false},
			{Position = Vector(-9427, -11751, 16), Active = false},
			{Position = Vector(-9388, -13223, 15), Active = false},
			{Position = Vector(-9037, -12305, 15), Active = false},
			{Position = Vector(-7930, -12224, 14), Active = false},
			{Position = Vector(-9439, -13681, 15), Active = false},
			{Position = Vector(-8593, -13703, 15), Active = false},
			{Position = Vector(-9070, -13563, 14), Active = false},
			{Position = Vector(-9190, -14138, 15), Active = false},
			{Position = Vector(-9924, -13907, 15), Active = false},
			{Position = Vector(-9908, -13585, 15), Active = false},
			{Position = Vector(7736, -8607, 16), Active = false},
			{Position = Vector(7654, -8729, 17), Active = false},
			{Position = Vector(7551, -8560, 16), Active = false},
			{Position = Vector(4568, -9454, 22), Active = false},
			{Position = Vector(7963, -8488, 17), Active = false},
			{Position = Vector(4816, -8798, 22), Active = false},
			{Position = Vector(4670, -9616, 22), Active = false},
			{Position = Vector(6919, -11227, 16), Active = false},
			{Position = Vector(6680, -11088, 16), Active = false},
			{Position = Vector(6763, -11253, 16), Active = false},
			{Position = Vector(4620, -9078, 158), Active = false},
			{Position = Vector(3946, -11184, 17), Active = false},
			{Position = Vector(3750, -11026, 16), Active = false},
			{Position = Vector(3758, -11327, 16), Active = false},
			{Position = Vector(3579, -11136, 17), Active = false},
			{Position = Vector(4710, -9213, 22), Active = false},
		},		
	},
	/*
	["npc_mirelurk"] = {
		Name = "Mirelurk",
		Health = 600,
		Limit = 6, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 4, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 45,
		Loot = {
			[5030] = {quantity = {1, 8}, prob = 15},
			[5031] = {quantity = {1, 3}, prob = 15},
			[5044] = {quantity = {1, 2}, prob = 10},
			[5043] = {quantity = {1, 2}, prob = 10},
		},				
		Positions = {
			{Position = Vector(-6092, -362, -247), Active = false},
			{Position = Vector(-6581, -347, -243), Active = false},
			{Position = Vector(-6630, -913, -258), Active = false},
			{Position = Vector(-6405, -1062, -244), Active = false},
			{Position = Vector(-6254, -2027, -262), Active = false},
			{Position = Vector(-6722, -2376, -232), Active = false},
			{Position = Vector(-6213, -3218, -267), Active = false},
			{Position = Vector(-6137, -3673, -205), Active = false},
		},
	},
	*/
}

function getNpcExp(type)
	return (NPCS[type] and NPCS[type]["Experience"]) or 100
end

function getNpcName(type)
	return (NPCS[type] and NPCS[type]["Name"]) or "N/A"
end

function getNpcHealth(type)
	return (NPCS[type] and NPCS[type]["Health"]) or 100
end

function getNpcLoot(type)
	return NPCS[type]["Loot"]
end

function getNpcLevel(type)
	return NPCS[type]["Level"]
end