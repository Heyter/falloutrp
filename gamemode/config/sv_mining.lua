
// Shared
VEINS = {
	Common = {
		Sizes = {
			small = {Props = {"models/props_nature/rock_worn001.mdl", "models/props_nature/rock_worn_cluster001.mdl", "models/props_nature/rock_worn_cluster002.mdl"}, Amount = {1, 3}},
			medium = {Props = {"models/props_mining/rock003.mdl"}, Amount = {3, 7}},
			large = {Props = {"models/props_mining/rock001.mdl"}, Amount = {5, 10}}
		},
		Positions = {
			{Position = Vector(-6726, 8002, 10)},
			{Position = Vector(-4521, 8582, 127)},
			{Position = Vector(-3090, 8690, 243)},
			{Position = Vector(-1345, 8911, 221)},
			{Position = Vector(77, 7161, 129)},
			{Position = Vector(2382, 7313, 85)},
			{Position = Vector(-6694, 6136, 22)},
			{Position = Vector(-3681, 5501, 10)},
			{Position = Vector(-864, 5491, 4)},
			{Position = Vector(-936, 6893, 21)},
			{Position = Vector(-149, 9830, 124)},
			{Position = Vector(-2724, 7680, 213)},
			{Position = Vector(-8740, 7690, 162)},
			{Position = Vector(-6651, 10731, 39)},
			{Position = Vector(-5400, 11778, 243)},
			{Position = Vector(-3560, 10707, 29)},
			{Position = Vector(1497, 9774, 56)},
			{Position = Vector(4776, 7356, 3)},
			{Position = Vector(-4526, 13822, 12)},
			{Position = Vector(-2316, 11116, 96)},
			{Position = Vector(801, 4142, 60)},
			{Position = Vector(3351, 4181, 1)},
			{Position = Vector(5147, 4921, 7)},
			{Position = Vector(187, -625, 2)},
			{Position = Vector(-4831, 3441, 49)},
			{Position = Vector(-10576, 8839, 16)},
		},
		Limit = 12, // How many normal veins can be on map at a time
		Experience = 10,
		Default = 5028, // The default rock that is mined if the extra isn't rolled
		Extras = {[5029] = 35} // Rock = Probability %
	},
	Uncommon = {
		Sizes = {
			small = {Props = {"models/props_wasteland/rockgranite02c.mdl", "models/props_wasteland/rockgranite03c.mdl"}, Amount = {1, 3}},
			medium = {Props = {"models/props_wasteland/rockcliff01b.mdl", "models/props_wasteland/rockgranite01a.mdl"}, Amount = {3, 7}},
			large = {Props = {"models/props_wasteland/rockcliff_cluster03a.mdl", "models/props_wasteland/rockcliff01f.mdl"}, Amount = {5, 10}}
		},
		Positions = {
			{Position = Vector(3294, 7242, 25)},
			{Position = Vector(1531, 7031, 141)},
			{Position = Vector(-221, 6418, 50)},
			{Position = Vector(-885, 8647, 140)},
			{Position = Vector(-2570, 9274, 289)},
			{Position = Vector(-3549, 7550, 196)},
			{Position = Vector(-2233, 5723, 4)},
			{Position = Vector(-5710, 6769, 97)},
			{Position = Vector(-8325, 5490, 56)},
			{Position = Vector(-8922, 8933, 5)},
			{Position = Vector(-5984, 9193, 36)},
			{Position = Vector(-3975, 9103, 173)},
			{Position = Vector(-3066, 10432, 194)},
			{Position = Vector(2022, 9489, 91)},
			{Position = Vector(5970, 7440, 2)},
			{Position = Vector(5886, 4062, 8)},
			{Position = Vector(7302, -1059, 13)},
			{Position = Vector(3635, -743, 35)},
			{Position = Vector(1626, 2521, 6)},
			{Position = Vector(-415, 3248, 42)},
			{Position = Vector(-6306, 13789, 74)},
		},
		Limit = 10, // How many rare veins can be on map at a time
		Experience = 20,
		Default = 5030, // The default rock that is mined if the extra isn't rolled
		Extras = {[5031] = 40} // Rock = Probability %
	},
	Rare = {
		Sizes = {
			small = {Props = {"models/rarerocks/crystal1.mdl"}, Amount = {1, 3}},
			large = {Props = {"models/rarerocks/crystal2.mdl"}, Amount = {2, 4}}
		},
		Positions = {
			{Position = Vector(3686, 5599, 851)},
			{Position = Vector(1224, 5420, 687)},
			{Position = Vector(7658, 7418, 26)},
			{Position = Vector(8069, 8098, 84)},
			{Position = Vector(7871, 13673, 24)},
			{Position = Vector(3935, 13902, 36)},
			{Position = Vector(523, 13826, 713)},
			{Position = Vector(-858, 14042, 574)},
			{Position = Vector(-1890, 13954, 121)},
			{Position = Vector(-1652, 12866, 180)},
			{Position = Vector(-11829, 13949, 63)},
			{Position = Vector(-8450, 11046, 30)},
			{Position = Vector(-5157, 9819, 9)},
			{Position = Vector(-4073, 9909, 21)},
			{Position = Vector(-2292, 13079, -9)},
			{Position = Vector(-2557, 12308, -58)},
			{Position = Vector(-2150, 12118, 10)},
			{Position = Vector(2380, 6822, 66)},
			{Position = Vector(7663, 5653, 15)},
			{Position = Vector(-1203, 1289, 361)},
			{Position = Vector(-894, -497, 170)},
			{Position = Vector(-308, -1190, 62)},
		},
		Limit = 8, // How many rare veins can be on map at a time
		Experience = 30,
		Default = 5039, // The default rock that is mined if the extra isn't rolled
		Extras = {[5032] = 35, [5040] = 20} // Rock = Probability %
	}
}

function spawnrocks()
	for k,v in pairs(VEINS) do
		for a,b in pairs(v.Positions) do
			local ent = ents.Create("vein")
			ent:SetModel("models/props_mining/rock002.mdl")
			ent:SetPos(b.Position)
			ent:Spawn()
		end
	end
end

VEIN_TIMER = 180 // How often we try to spawn a new vein (seconds)
VEIN_SOUND = "pickaxe/deploy.wav" // Sound made when a vein is mined successfully

function printRockPositions()
	for k,v in pairs(ents.FindByClass("prop_physics")) do
		if v:GetModel() == "models/props_borealis/bluebarrel001.mdl" and v._id == 15 then
			local p = v:GetPos()
			print("{Position = Vector(" ..math.floor(p[1]) ..", " ..math.floor(p[2]) ..", " ..math.floor(p[3]) ..")},")
			//print("{Position = Vector(" ..math.floor(p[1]) ..", " ..math.floor(p[2]) ..", " ..math.floor(p[3]) .."), Angles = Angle(" ..math.floor(a[1]) ..", " ..math.floor(a[2]) ..", " ..math.floor(a[3]) ..")},")
			//{Position = Vector(8349, 4075, 17), Angles = Angle(0, -79, 2), Active = false},
		end
	end
end
