
// NPC Config
NPCS = NPCS or {}

NPCS.npcs = {
	// Level 1-15 NPCs
	["nz_giantrat"] = {
		Name = "Giant Rat",
		Level = 15,
		Health = 175,
		Limit = 8, // How many can be active on the map at once
		SpawnRate = 45, // How often (seconds) we try to spawn a new one
		StartAmount = 2, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 30,
		Damage = 7,
		Loot = {
			[4014] = {quantity = {1, 2}, prob = 80},
			[5042] = {quantity = {1, 2}, prob = 80},
			[5045] = {quantity = {1, 1}, prob = 40},
			[5066] = {quantity = {1, 1}, prob = 100},
		},
		Positions = {
			{Position = Vector(-6886, 1203, 113)},
			{Position = Vector(-5814, 2292, 69)},
			{Position = Vector(-4949, 3104, 42)},
			{Position = Vector(-5422, 4245, 71)},
			{Position = Vector(-6118, 4775, 73)},
			{Position = Vector(-7058, 4714, 73)},
			{Position = Vector(-6446, 3343, 73)},
			{Position = Vector(-6742, 3881, 121)},
			{Position = Vector(-4840, 1824, 73)},
			{Position = Vector(-4951, 1069, 73)},
			{Position = Vector(-7309, 2611, 29)},
			{Position = Vector(-7912, 5186, 73)},
			{Position = Vector(-9546, 5298, 67)},
			{Position = Vector(-10752, 6097, 89)},
			{Position = Vector(-11625, 6067, 83)},
			{Position = Vector(-10372, 5492, 89)},
			{Position = Vector(-10979, 5267, 89)},
			{Position = Vector(-10730, 7607, 192)},
			{Position = Vector(-9483, 7650, 194)},
			{Position = Vector(-7830, 7412, 72)},
			{Position = Vector(-6128, 6248, 54)},
			{Position = Vector(-5294, 5743, 98)},
			{Position = Vector(-4257, 5854, 88)},
			{Position = Vector(-4041, 6942, 109)},
			{Position = Vector(-4692, 7423, 110)},
			{Position = Vector(-6273, 8319, 67)},
			{Position = Vector(-4758, 6473, 105)},
			{Position = Vector(-9394, 6394, 89)},
			{Position = Vector(-8109, 6431, 89)},
		},
	},
	["nz_mantis_nymph"] = {
		Name = "Mantis Nymph",
		Level = 15,
		Health = 200,
		Limit = 3, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 40,
		Damage = 12,
		Loot = {
			[5046] = {quantity = {1, 3}, prob = 80},
			[5046] = {quantity = {1, 3}, prob = 80},
			[5068] = {quantity = {1, 1}, prob = 50},
		},
		Positions = {
			{Position = Vector(-11393, 6969, 113)},
			{Position = Vector(-10024, 6695, 87)},
			{Position = Vector(-10067, 7776, 189)},
			{Position = Vector(-9144, 8325, 61)},
			{Position = Vector(-8120, 8851, 30)},
			{Position = Vector(-8048, 7671, 165)},
			{Position = Vector(-6978, 8443, 59)},
			{Position = Vector(-6317, 7466, 36)},
			{Position = Vector(-5437, 8049, 126)},
			{Position = Vector(-5388, 6934, 110)},
			{Position = Vector(-4988, 5767, 89)},
			{Position = Vector(-4203, 5058, 60)},
			{Position = Vector(-4763, 4175, 63)},
			{Position = Vector(-4267, 3591, 98)},
			{Position = Vector(-5573, 1156, 73)},
			{Position = Vector(-3220, 1440, 73)},
			{Position = Vector(-2784, 5227, 95)},
			{Position = Vector(1852, 4255, 172)},
			{Position = Vector(3145, 4493, 28)},
			{Position = Vector(4824, 5961, 86)},
		},
	},
	["nz_mantis"] = {
		Name = "Mantis",
		Level = 15,
		Health = 270,
		Limit = 3, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 45,
		Damage = 17,
		Loot = {
			[5046] = {quantity = {1, 5}, prob = 80},
			[5067] = {quantity = {1, 1}, prob = 50},
		},
		Positions = {
			{Position = Vector(3770, 6886, 79)},
			{Position = Vector(2704, 6887, 49)},
			{Position = Vector(1143, 7471, 191)},
			{Position = Vector(-123, 6617, 85)},
			{Position = Vector(-593, 8953, 177)},
			{Position = Vector(-1710, 9432, 236)},
			{Position = Vector(-2839, 8306, 222)},
			{Position = Vector(-2558, 9630, 305)},
			{Position = Vector(-5254, 9181, 42)},
			{Position = Vector(-2897, 5941, 42)},
			{Position = Vector(-2106, 5384, 77)},
			{Position = Vector(-1129, 5820, 28)},
			{Position = Vector(544, 4138, 81)},
			{Position = Vector(-1374, 1094, 386)},
			{Position = Vector(-2610, 3878, 689)},
			{Position = Vector(5674, 7745, 31)},
			{Position = Vector(7399, 6815, 31)},
			{Position = Vector(7291, 5564, 39)},
			{Position = Vector(5188, 3857, 26)},
			{Position = Vector(222, 9836, 160)},
		},
	},
	["nz_gecko"] = {
		Name = "Gecko",
		Level = 15,
		Health = 300,
		Limit = 7, // How many can be active on the map at once
		SpawnRate = 45, // How often (seconds) we try to spawn a new one
		StartAmount = 3, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 35,
		Damage = 19,
		Loot = {
			[4014] = {quantity = {1, 2}, prob = 80},
			[4006] = {quantity = {1, 1}, prob = 6}, // Water bottle
			[4009] = {quantity = {1, 1}, prob = 6}, // Chinese takeout
			[4001] = {quantity = {1, 1}, prob = 4},
			[5045] = {quantity = {1, 4}, prob = 80},
			[5028] = {quantity = {1, 2}, prob = 10},
			[5041] = {quantity = {1, 1}, prob = 5}
		},
		Positions = {
			{Position = Vector(-7013, 3166, 73)},
			{Position = Vector(-6333, 3881, 121)},
			{Position = Vector(-8917, 5718, 76)},
			{Position = Vector(-8710, 7166, 55)},
			{Position = Vector(-10317, 7047, 118)},
			{Position = Vector(-10766, 5436, 89)},
			{Position = Vector(-10182, 5484, 89)},
			{Position = Vector(-10908, 8109, 215)},
			{Position = Vector(-11371, 9341, 153)},
			{Position = Vector(-11632, 9078, 303)},
			{Position = Vector(-5958, 1540, 73)},
			{Position = Vector(-5296, 1707, 73)},
			{Position = Vector(-3346, 1253, 73)},
			{Position = Vector(-2977, 1669, 73)},
			{Position = Vector(-2922, 1300, 822)},
			{Position = Vector(-2800, 3128, 825)},
			{Position = Vector(-1365, 5706, 27)},
			{Position = Vector(-684, 4324, 34)},
			{Position = Vector(81, 4328, 45)},
			{Position = Vector(1189, 4102, 86)},
			{Position = Vector(908, 5401, 623)},
			{Position = Vector(1876, 5494, 750)},
			{Position = Vector(706, 6975, 154)},
			{Position = Vector(56, 8267, 115)},
			{Position = Vector(2073, 8999, 126)},
			{Position = Vector(5914, 5626, 36)},
			{Position = Vector(7091, 3907, 42)},
			{Position = Vector(7642, -117, 54)},
			{Position = Vector(6480, -1235, 39)},
			{Position = Vector(4130, -783, 114)},
			{Position = Vector(-1808, 2068, 567)},
			{Position = Vector(-5055, 4335, 54)},
			{Position = Vector(-4454, 6339, 105)},
			{Position = Vector(-7078, 6735, 104)},
		},
	},
	["nz_streettrog"] = {
		Name = "Trog",
		Level = 15,
		Health = 375,
		Limit = 4, // How many can be active on the map at once
		SpawnRate = 60, // How often (seconds) we try to spawn a new one
		StartAmount = 2, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 60,
		Damage = 23,
		Loot = {
			[4001] = {quantity = {1, 2}, prob = 8},
			[4002] = {quantity = {1, 1}, prob = 4},
			[4006] = {quantity = {1, 1}, prob = 6}, // Water bottle
			[4009] = {quantity = {1, 1}, prob = 6}, // Chinese takeout
			[4007] = {quantity = {1, 1}, prob = 6}, // Milk
			[4010] = {quantity = {1, 1}, prob = 6}, // Can of beans
			[4012] = {quantity = {1, 1}, prob = 10},
			[4011] = {quantity = {1, 1}, prob = 10},
			[4010] = {quantity = {1, 1}, prob = 10},
			[5045] = {quantity = {1, 8}, prob = 70},
			[5028] = {quantity = {1, 3}, prob = 40},
			[5029] = {quantity = {1, 2}, prob = 20},
			[5030] = {quantity = {1, 2}, prob = 10},
			[5031] = {quantity = {1, 1}, prob = 5},
			[5037] = {quantity = {1, 1}, prob = 3},
			[5038] = {quantity = {1, 1}, prob = 3},
			[5040] = {quantity = {1, 2}, prob = 20},
		},
		Positions = {
			{Position = Vector(-5137, 7335, 105)},
			{Position = Vector(-7809, 9852, 107)},
			{Position = Vector(-4913, 9747, 61)},
			{Position = Vector(-4352, 10362, 65)},
			{Position = Vector(-4158, 13251, 80)},
			{Position = Vector(-4202, 11747, 81)},
			{Position = Vector(-4918, 10933, 53)},
			{Position = Vector(-4925, 8504, 162)},
			{Position = Vector(-3464, 6505, 69)},
			{Position = Vector(-810, 10305, 162)},
			{Position = Vector(1300, 11181, 253)},
			{Position = Vector(1792, 10777, 126)},
			{Position = Vector(527, 8670, 207)},
			{Position = Vector(-1766, 7370, 134)},
			{Position = Vector(-3981, 8028, 233)},
			{Position = Vector(-1552, 5372, 48)},
			{Position = Vector(-5405, 12941, 251)},
			{Position = Vector(-1096, 11413, 87)},
		},
	},
	["nz_mirelurk"] = {
		Name = "Mirelurk",
		Level = 30,
		Health = 1200,
		Limit = 2, // How many can be active on the map at once
		SpawnRate = 180, // How often (seconds) we try to spawn a new one
		StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 80,
		Damage = 25,
		Loot = {
			[5028] = {quantity = {1, 10}, prob = 70},
			[5042] = {quantity = {1, 8}, prob = 80},
			[5046] = {quantity = {1, 5}, prob = 60},
		},
		Positions = {
			{Position = Vector(-2490, 11548, 109)},
			{Position = Vector(-1630, 12068, 75)},
			{Position = Vector(-3716, 13545, 78)},
			{Position = Vector(-3395, 12309, 37)},
			{Position = Vector(-3050, 11420, 108)},
			{Position = Vector(-2052, 11405, 89)},
		},
	},

	// Level 15-30 NPCs

	["nz_cazador"] = {
		Name = "Cazador",
		Level = 30,
		Health = 400,
		Limit = 7, // How many can be active on the map at once
		SpawnRate = 45, // How often (seconds) we try to spawn a new one
		StartAmount = 3, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 90,
		Damage = 25,
		Loot = {
			[4014] = {quantity = {1, 2}, prob = 80},
			[5043] = {quantity = {1, 3}, prob = 80},
			[5070] = {quantity = {1, 1}, prob = 30},
			[5071] = {quantity = {1, 2}, prob = 80},
		},
		Positions = {
			{Position = Vector(2318, 7619, 115)},
			{Position = Vector(3482, 7705, 32)},
			{Position = Vector(4809, 6811, 35)},
			{Position = Vector(4667, 4720, 28)},
			{Position = Vector(3629, 4227, 27)},
			{Position = Vector(3347, 2608, 85)},
			{Position = Vector(1653, 5382, 727)},
			{Position = Vector(2939, 5526, 717)},
			{Position = Vector(3354, 5596, 862)},
			{Position = Vector(2351, 5777, 727)},
			{Position = Vector(4498, 2572, 859)},
			{Position = Vector(4632, 1562, 708)},
			{Position = Vector(4630, 679, 794)},
			{Position = Vector(4920, -108, 798)},
			{Position = Vector(-1283, 1885, 391)},
			{Position = Vector(-2066, 2698, 712)},
			{Position = Vector(-2202, 1229, 737)},
			{Position = Vector(-3801, 2623, 505)},
			{Position = Vector(-52, 11014, 364)},
		},
	},
	["nz_sporecarrier"] = {
		Name = "Spore Carrier",
		Level = 30,
		Health = 520,
		Limit = 5, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 115,
		Damage = 28,
		Loot = {
			[4001] = {quantity = {1, 2}, prob = 8},
			[4002] = {quantity = {1, 1}, prob = 4},
			[4012] = {quantity = {1, 1}, prob = 10},
			[4011] = {quantity = {1, 1}, prob = 10},
			[4010] = {quantity = {1, 1}, prob = 10},
			[4004] = {quantity = {1, 2}, prob = 6},
			[5046] = {quantity = {1, 5}, prob = 50},
			[5044] = {quantity = {1, 2}, prob = 25},
		},
		Positions = {
			{Position = Vector(2785, 11589, 121)},
			{Position = Vector(2765, 12138, 121)},
			{Position = Vector(5816, 11869, 281)},
			{Position = Vector(5219, 12034, 281)},
			{Position = Vector(4352, 9071, 121)},
			{Position = Vector(-9743, 12597, 121)},
			{Position = Vector(-9524, 13064, -135)},
			{Position = Vector(-8888, 12636, -135)},
		},
	},
	["nz_ghoulferal_swamp"] = {
		Name = "Swamp Ghoul",
		Level = 15,
		Health = 310,
		Limit = 8, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 2, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 95,
		Damage = 20,
		Loot = {
			[4001] = {quantity = {1, 2}, prob = 8},
			[4002] = {quantity = {1, 1}, prob = 4},
			[4012] = {quantity = {1, 1}, prob = 10},
			[4011] = {quantity = {1, 1}, prob = 10},
			[4010] = {quantity = {1, 1}, prob = 10},
			[4004] = {quantity = {1, 2}, prob = 6},
			[5046] = {quantity = {1, 5}, prob = 50},
			[5044] = {quantity = {1, 2}, prob = 25},
			[5069] = {quantity = {1, 2}, prob = 100},
		},
		Positions = {
			{Position = Vector(-6177, 12890, 175)},
			{Position = Vector(-7489, 11913, 64)},
			{Position = Vector(-8755, 12132, 93)},
			{Position = Vector(-9863, 11733, 73)},
			{Position = Vector(-10779, 12902, 66)},
			{Position = Vector(-11707, 13678, 87)},
			{Position = Vector(-11828, 12323, 75)},
			{Position = Vector(-11895, 11098, 121)},
			{Position = Vector(-10942, 10756, 86)},
			{Position = Vector(-11029, 9822, 107)},
			{Position = Vector(-9655, 9539, 65)},
			{Position = Vector(-8463, 9338, 82)},
			{Position = Vector(-9668, 8630, 66)},
			{Position = Vector(-11414, 8756, 60)},
			{Position = Vector(-11859, 10132, 87)},
			{Position = Vector(-10655, 11775, 69)},
			{Position = Vector(-9059, 12815, 82)},
			{Position = Vector(-8747, 13816, 59)},
			{Position = Vector(-6822, 13541, 96)},
			{Position = Vector(-5345, 13405, 187)},
			{Position = Vector(-5602, 11441, 254)},
			{Position = Vector(-6299, 10922, 121)},
			{Position = Vector(-7089, 10186, 42)},
		},
	},
	["nz_ghoulferal"] = {
		Name = "Ghoul",
		Level = 30,
		Health = 450,
		Limit = 8, // How many can be active on the map at once
		SpawnRate = 45, // How often (seconds) we try to spawn a new one
		StartAmount = 2, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 120,
		Damage = 26,
		Loot = {
			[4001] = {quantity = {1, 2}, prob = 4},
			[4002] = {quantity = {1, 1}, prob = 4},
			[4006] = {quantity = {1, 1}, prob = 6}, // Water bottle
			[4009] = {quantity = {1, 1}, prob = 6}, // Chinese takeout
			[4007] = {quantity = {1, 1}, prob = 6}, // Milk
			[4010] = {quantity = {1, 1}, prob = 6}, // Can of beans
			[4012] = {quantity = {1, 1}, prob = 10},
			[4011] = {quantity = {1, 1}, prob = 10},
			[4010] = {quantity = {1, 1}, prob = 10},
			[4004] = {quantity = {1, 2}, prob = 6},
			[5046] = {quantity = {1, 2}, prob = 25},
			[5044] = {quantity = {1, 4}, prob = 25},
			[5032] = {quantity = {1, 1}, prob = 3},
			[5036] = {quantity = {1, 1}, prob = 2},
			[5031] = {quantity = {1, 1}, prob = 6},
			[5030] = {quantity = {1, 2}, prob = 8},
			[5055] = {quantity = {1, 1}, prob = 5},
		},
		Positions = {
			{Position = Vector(62, 3802, 42)},
			{Position = Vector(764, 2487, 55)},
			{Position = Vector(60, 1320, 73)},
			{Position = Vector(93, 1861, 73)},
			{Position = Vector(2622, 1262, 73)},
			{Position = Vector(3130, 2316, 37)},
			{Position = Vector(2912, 2601, 28)},
			{Position = Vector(3347, 211, 33)},
			{Position = Vector(2631, 703, 41)},
			{Position = Vector(2102, -586, 41)},
			{Position = Vector(1198, 145, 57)},
			{Position = Vector(449, -203, 34)},
			{Position = Vector(-77, 582, 41)},
			{Position = Vector(-225, 771, 41)},
			{Position = Vector(-347, 2104, 70)},
			{Position = Vector(2908, 3203, 33)},
			{Position = Vector(-135, 2426, 50)},
			{Position = Vector(1357, 1819, 73)},
			{Position = Vector(4468, 1777, 73)},
			{Position = Vector(4554, 1157, 73)},
			{Position = Vector(3807, 1356, 73)},
			{Position = Vector(7190, -40, 41)},
			{Position = Vector(7075, -790, 41)},
			{Position = Vector(7508, -621, 65)},
			{Position = Vector(6748, -331, 35)},
			{Position = Vector(6653, 633, 65)},
			{Position = Vector(5877, 1776, 73)},
			{Position = Vector(6048, 6215, 41)},
			{Position = Vector(5086, 7684, 27)},
			{Position = Vector(3651, 9302, 121)},
			{Position = Vector(2594, 9859, 121)},
			{Position = Vector(3000, 11835, 121)},
			{Position = Vector(4204, 11722, 121)},
			{Position = Vector(5019, 11481, 129)},
			{Position = Vector(5691, 11984, 126)},
			{Position = Vector(5605, 11462, 125)},
			{Position = Vector(6018, 12363, 122)},
			{Position = Vector(6531, 11355, 121)},
			{Position = Vector(6752, 9263, 121)},
			{Position = Vector(7344, 6087, 30)},
		},
	},
	/*
	["npc_ghoulferal_reaver"] = {
		Name = "Ghoul Reaver",
		Level = 30,
		Health = 900,
		Limit = 8, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 4, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 140,
		Loot = {
			[4001] = {quantity = {1, 2}, prob = 5},
			[4002] = {quantity = {1, 1}, prob = 5},
			[4006] = {quantity = {1, 1}, prob = 6}, // Water bottle
			[4009] = {quantity = {1, 1}, prob = 6}, // Chinese takeout
			[4007] = {quantity = {1, 1}, prob = 6}, // Milk
			[4010] = {quantity = {1, 1}, prob = 6}, // Can of beans
			[4012] = {quantity = {1, 1}, prob = 10},
			[4011] = {quantity = {1, 1}, prob = 10},
			[4010] = {quantity = {1, 1}, prob = 10},
			[4004] = {quantity = {1, 2}, prob = 7},
			[5046] = {quantity = {1, 2}, prob = 25},
			[5044] = {quantity = {1, 4}, prob = 25},
			[5039] = {quantity = {1, 1}, prob = 4},
			[5032] = {quantity = {1, 1}, prob = 2},
			[5036] = {quantity = {1, 1}, prob = 3},
			[5031] = {quantity = {1, 1}, prob = 7},
			[5030] = {quantity = {1, 2}, prob = 9},
			[5040] = {quantity = {1, 1}, prob = 5},
		},
		Positions = {
			{Position = Vector(-7709, -13306, 40), Active = false},
			{Position = Vector(-6903, -13280, 44), Active = false},
			{Position = Vector(-8750, -13771, 25), Active = false},
			{Position = Vector(-8465, -12962, 25), Active = false},
			{Position = Vector(-9187, -12528, 25), Active = false},
			{Position = Vector(-10387, -11524, 28), Active = false},
			{Position = Vector(-10857, -11921, 25), Active = false},
			{Position = Vector(-10206, -13260, 25), Active = false},
			{Position = Vector(-9661, -13781, 25), Active = false},
			{Position = Vector(-9920, -13912, 150), Active = false},
			{Position = Vector(-9262, -12961, 121), Active = false},
			{Position = Vector(-8052, -10967, 139), Active = false},
			{Position = Vector(-8804, -10343, 127), Active = false},
			{Position = Vector(5423, -11771, 163), Active = false},
			{Position = Vector(7339, -12638, 27), Active = false},
			{Position = Vector(7900, -11603, 27), Active = false},
			{Position = Vector(7587, -11861, 27), Active = false},
			{Position = Vector(5703, -11907, 27), Active = false},
			{Position = Vector(4826, -11867, 27), Active = false},
			{Position = Vector(4386, -11759, 27), Active = false},
			{Position = Vector(4179, -11335, 27), Active = false},
			{Position = Vector(3214, -11291, 30), Active = false},
			{Position = Vector(3993, -8689, 27), Active = false},
			{Position = Vector(8279, -8402, 27), Active = false},
		},
	},
	*/
	["nz_ghoulferal_roamer"] = {
		Name = "Ghoul Roamer",
		Level = 30,
		Health = 475,
		Limit = 9, // How many can be active on the map at once
		SpawnRate = 45, // How often (seconds) we try to spawn a new one
		StartAmount = 3, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 125,
		Damage = 30,
		Loot = {
			[4001] = {quantity = {1, 2}, prob = 4},
			[4002] = {quantity = {1, 1}, prob = 4},
			[4006] = {quantity = {1, 1}, prob = 6}, // Water bottle
			[4009] = {quantity = {1, 1}, prob = 6}, // Chinese takeout
			[4007] = {quantity = {1, 1}, prob = 6}, // Milk
			[4010] = {quantity = {1, 1}, prob = 6}, // Can of beans
			[4012] = {quantity = {1, 1}, prob = 10},
			[4011] = {quantity = {1, 1}, prob = 10},
			[4010] = {quantity = {1, 1}, prob = 10},
			[4004] = {quantity = {1, 2}, prob = 6},
			[5046] = {quantity = {1, 2}, prob = 25},
			[5044] = {quantity = {1, 4}, prob = 25},
			[5039] = {quantity = {1, 1}, prob = 3},
			[5032] = {quantity = {1, 1}, prob = 2},
			[5036] = {quantity = {1, 1}, prob = 2},
			[5031] = {quantity = {1, 1}, prob = 6},
			[5030] = {quantity = {1, 2}, prob = 8},
			[5055] = {quantity = {1, 1}, prob = 7},
		},
		Positions = {
			{Position = Vector(2909, 7622, 105)},
			{Position = Vector(2724, 8557, 121)},
			{Position = Vector(3526, 10270, 121)},
			{Position = Vector(2487, 10774, 121)},
			{Position = Vector(3598, 12527, 121)},
			{Position = Vector(4706, 10763, 121)},
			{Position = Vector(6057, 10838, 121)},
			{Position = Vector(6715, 12072, 121)},
			{Position = Vector(6735, 10105, 121)},
			{Position = Vector(6580, 8480, 121)},
			{Position = Vector(6606, 7178, 39)},
			{Position = Vector(5628, 5594, 33)},
			{Position = Vector(5618, 4572, 41)},
			{Position = Vector(6381, 3897, 41)},
			{Position = Vector(6423, 2973, 41)},
			{Position = Vector(6928, 1731, 73)},
			{Position = Vector(7202, 500, 42)},
			{Position = Vector(6209, -1042, 41)},
			{Position = Vector(4357, -1103, 41)},
			{Position = Vector(2614, -1057, 33)},
			{Position = Vector(3319, -130, 33)},
			{Position = Vector(1709, -1103, 33)},
			{Position = Vector(818, -178, 37)},
			{Position = Vector(781, 866, 66)},
			{Position = Vector(771, 1829, 73)},
			{Position = Vector(2031, 3135, 42)},
			{Position = Vector(3952, 3995, 45)},
		},
	},
	["nz_gecko_green"] = {
		Name = "Green Gecko",
		Level = 30,
		Health = 750,
		Limit = 4, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 2, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 150,
		Damage = 25,
		Loot = {
			[4014] = {quantity = {1, 3}, prob = 80},
			[5046] = {quantity = {1, 8}, prob = 80},
			[5043] = {quantity = {1, 5}, prob = 75},
			[5040] = {quantity = {1, 1}, prob = 5}, //Plasma
			[5032] = {quantity = {1, 1}, prob = 5}, //Crystal
			[5041] = {quantity = {1, 2}, prob = 12}, //Claw
		},
		Positions = {
			{Position = Vector(-2657, 11078, 128)},
			{Position = Vector(-523, 10781, 168)},
			{Position = Vector(-349, 11462, 379)},
			{Position = Vector(788, 11022, 315)},
			{Position = Vector(597, 9772, 156)},
			{Position = Vector(-357, 9259, 163)},
			{Position = Vector(-1917, 10210, 202)},
			{Position = Vector(-3036, 10184, 247)},
			{Position = Vector(-3596, 11718, 37)},
			{Position = Vector(-4770, 12205, 240)},
			{Position = Vector(-4508, 13410, 66)},
			{Position = Vector(-4113, 13687, 72)},
			{Position = Vector(-2111, 13863, 71)},
			{Position = Vector(-2503, 13905, 54)},
		},
	},
	["nz_nukalurk"] = {
		Name = "Nukalurk",
		Level = 50,
		Health = 1300,
		Limit = 2, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 175,
		Damage = 40,
		Loot = {
			[4014] = {quantity = {1, 8}, prob = 80},
			[5034] = {quantity = {1, 1}, prob = 25}, //Sheet metal
			[5014] = {quantity = {1, 4}, prob = 60}, //Scrap metal
			[5039] = {quantity = {1, 1}, prob = 30}, //Crystal
		},
		Positions = {
			{Position = Vector(338, 6579, 133)},
			{Position = Vector(1240, 5770, 651)},
			{Position = Vector(2329, 5535, 757)},
			{Position = Vector(3400, 5753, 836)},
			{Position = Vector(3939, 5592, 801)},
			{Position = Vector(4623, 3846, 61)},
			{Position = Vector(4772, 2381, 835)},
			{Position = Vector(4887, 1167, 720)},
			{Position = Vector(4655, -100, 759)},
			{Position = Vector(-915, 138, 56)},
		},
	},
	["nz_swamplurk"] = {
		Name = "Swamplurk",
		Level = 15,
		Health = 850,
		Limit = 3, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 175,
		Damage = 15,
		Loot = {
			[4014] = {quantity = {1, 8}, prob = 80},
			[5033] = {quantity = {1, 15}, prob = 40}, //Sticks
			[5046] = {quantity = {1, 15}, prob = 40}, //Sage
			[4001] = {quantity = {1, 2}, prob = 30}, //Stimpack
			[4008] = {quantity = {1, 4}, prob = 30}, //Water melon
		},
		Positions = {
			{Position = Vector(-5793, 9538, 72)},
			{Position = Vector(-6098, 10133, 97)},
			{Position = Vector(-7182, 11146, 48)},
			{Position = Vector(-7895, 11273, 73)},
			{Position = Vector(-8112, 12000, 96)},
			{Position = Vector(-8588, 13011, 75)},
			{Position = Vector(-8180, 13653, 63)},
			{Position = Vector(-9838, 13444, 90)},
			{Position = Vector(-10688, 13269, 59)},
			{Position = Vector(-11837, 12957, 75)},
			{Position = Vector(-11151, 11891, 89)},
			{Position = Vector(-11343, 11078, 60)},
			{Position = Vector(-9719, 10075, 85)},
			{Position = Vector(-9105, 9407, 69)},
			{Position = Vector(-10519, 9393, 109)},
		},
	},

	// Level 30-50 NPCs

	["nz_gecko_fire"] = {
		Name = "Fire Gecko",
		Level = 50,
		Health = 1200,
		Limit = 1, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 200,
		Damage = 30,
		Loot = {
			[4014] = {quantity = {1, 8}, prob = 90},
			[5043] = {quantity = {1, 8}, prob = 90},
			[5032] = {quantity = {1, 2}, prob = 5}, //Crystal
			[5040] = {quantity = {1, 2}, prob = 25}, //Plasma
		},
		Positions = {
			{Position = Vector(3385, -1084, 33)},
			{Position = Vector(2939, 41, 41)},
			{Position = Vector(807, -677, 33)},
			{Position = Vector(-48, -117, 38)},
			{Position = Vector(407, 741, 41)},
			{Position = Vector(3301, 3764, 31)},
			{Position = Vector(7409, 2878, 37)},
			{Position = Vector(5197, 9106, 120)},
			{Position = Vector(5678, 12126, 125)},
			{Position = Vector(2700, 11927, 121)},
			{Position = Vector(5492, 10471, 129)},
		},
	},
	/*
	["npc_magmalurk"] = {
		Name = "Magma Lurk",
		Health = 600,
		Limit = 6, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 4, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 45,
		Loot = {
		},
		Positions = {
		},
	},
	*/
	["nz_deathclaw"] = {
		Name = "Deathclaw",
		Level = 50,
		Health = 2500,
		Limit = 4, // How many can be active on the map at once
		SpawnRate = 120, // How often (seconds) we try to spawn a new one
		StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 250,
		Damage = 45,
		Loot = {
			[4014] = {quantity = {1, 8}, prob = 90},
			[5043] = {quantity = {1, 15}, prob = 90},
			[5041] = {quantity = {1, 8}, prob = 90}, // Claw
			[5032] = {quantity = {1, 2}, prob = 20}, //Crystal
			[5040] = {quantity = {1, 1}, prob = 3}, //Plasma
			[5036] = {quantity = {1, 1}, prob = 8}, //Holo disk
			[5031] = {quantity = {1, 2}, prob = 12}, //Gold
			[5030] = {quantity = {1, 2}, prob = 14}, //Silver
		},
		Positions = {
			{Position = Vector(-811, 13438, 683)},
			{Position = Vector(-174, 13831, 649)},
			{Position = Vector(270, 13557, 677)},
			{Position = Vector(549, 13514, 739)},
			{Position = Vector(717, 13883, 770)},
			{Position = Vector(87, 13037, 697)},
			{Position = Vector(-761, 12995, 628)},
			{Position = Vector(-344, 13224, 660)},
			{Position = Vector(-453, 12318, 496)},
			{Position = Vector(13, 12272, 457)},
			{Position = Vector(411, 12587, 482)},
			{Position = Vector(744, 11951, 422)},
			{Position = Vector(1016, 12176, 411)},
			{Position = Vector(1342, 12483, 367)},
			{Position = Vector(1956, 12979, 130)},
			{Position = Vector(1755, 13460, 101)},
			{Position = Vector(2229, 12807, 128)},
			{Position = Vector(552, 11205, 405)},
			{Position = Vector(2082, 11510, 120)},
			{Position = Vector(4359, 6845, 66)},
		},
	},
	/*
	["npc_deathclaw_alphamale"] = {
		Name = "Deathclaw Alphamale",
		Level = 50,
		Health = 4000,
		Limit = 3, // How many can be active on the map at once
		SpawnRate = 300, // How often (seconds) we try to spawn a new one
		StartAmount = 1, // How many of these npcs start in the server (so the server isn't bare on restart/startup)
		Experience = 500,
		Loot = {
			[4014] = {quantity = {1, 8}, prob = 90},
			[5043] = {quantity = {1, 15}, prob = 90},
			[5041] = {quantity = {1, 10}, prob = 90}, // Claw
			[5032] = {quantity = {1, 1}, prob = 8}, //Crystal
			[5040] = {quantity = {1, 1}, prob = 6}, //Plasma
			[5036] = {quantity = {1, 1}, prob = 15}, //Holo disk
			[5031] = {quantity = {1, 2}, prob = 30}, //Gold
			[5030] = {quantity = {1, 2}, prob = 35}, //Silver
		},
		Positions = {
			{Position = Vector(7127, 10839, 41), Active = false},
			{Position = Vector(9098, 10883, 46), Active = false},
			{Position = Vector(10119, 10893, 41), Active = false},
			{Position = Vector(14132, 9538, 66), Active = false},
			{Position = Vector(14182, 6474, 87), Active = false},
			{Position = Vector(13438, 5636, 40), Active = false},
			{Position = Vector(11184, 5249, 209), Active = false},
			{Position = Vector(7268, 5287, 35), Active = false},
		},
	},
	*/
}

NPCS.regenChecker = 4 // How often an evaded show it tracked
NPCS.regenPercentage = .30 // How much of max health is regened every evaded attack
