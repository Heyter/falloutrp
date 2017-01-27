
// Shared 
VEINS = {
	Normal = { 
		Sizes = {
			small = {Props = {"models/props_nature/rock_worn001.mdl", "models/props_nature/rock_worn_cluster001.mdl", "models/props_nature/rock_worn_cluster002.mdl"}, Amount = {1, 3}}, 
			medium = {Props = {"models/props_mining/rock003.mdl"}, Amount = {3, 7}},
			large = {Props = {"models/props_mining/rock001.mdl"}, Amount = {5, 10}}
		},
		Positions = {
			{Position = Vector(-9019, 3395, 1), Active = false},
			{Position = Vector(-9788, 5942, 0), Active = false},
			{Position = Vector(-8354, 4890, 18), Active = false},
			{Position = Vector(-5277, 3886, 3), Active = false},
			{Position = Vector(-5774, 2585, 1), Active = false},
			{Position = Vector(-3456, 3006, 19), Active = false},
			{Position = Vector(-2317, 3482, 6), Active = false},
			{Position = Vector(609, 4815, 0), Active = false},
			{Position = Vector(3209, 6212, 42), Active = false},
			{Position = Vector(5392, 4738, -12), Active = false},
			{Position = Vector(4335, 5309, 54), Active = false},
			{Position = Vector(9352, 5226, 1), Active = false},
			{Position = Vector(8090, 1155, 0), Active = false},
			{Position = Vector(6508, 1082, 176), Active = false},
			{Position = Vector(8427, -2191, 0), Active = false},
			{Position = Vector(10885, -2611, 2), Active = false},
			{Position = Vector(11802, -3180, 10), Active = false},
			{Position = Vector(12877, -3114, 4), Active = false},
			{Position = Vector(14292, -3114, 3), Active = false},
			{Position = Vector(13737, -6365, 46), Active = false},
			{Position = Vector(13691, -9339, 36), Active = false},
			{Position = Vector(13923, -10543, 13), Active = false},
			{Position = Vector(12828, -11097, 11), Active = false},
			{Position = Vector(9690, -7761, 95), Active = false},
			{Position = Vector(6507, -7052, 21), Active = false},
			{Position = Vector(7679, -5884, -6), Active = false},
			{Position = Vector(6301, -13566, 34), Active = false},
			{Position = Vector(1065, -11805, 29), Active = false},
			{Position = Vector(1024, -12624, 13), Active = false},
			{Position = Vector(-2862, -12256, 43), Active = false},
			{Position = Vector(-2907, -11510, 14), Active = false},
			{Position = Vector(-3145, -10430, 0), Active = false},
			{Position = Vector(-4312, -10098, 0), Active = false},
			{Position = Vector(-4474, -11848, 0), Active = false},
			{Position = Vector(-7353, -13843, 10), Active = false},
			{Position = Vector(-6953, -13779, 46), Active = false},
			{Position = Vector(-7259, -8784, 41), Active = false},
			{Position = Vector(-7574, -5518, 33), Active = false},
			{Position = Vector(-6216, -2517, -273), Active = false},
			{Position = Vector(-6519, 559, -310), Active = false},
			{Position = Vector(-7549, 6652, 89), Active = false},
			{Position = Vector(-13392, 491, 0), Active = false},
			{Position = Vector(-12136, -1868, 58), Active = false},
			{Position = Vector(-10918, -3687, 111), Active = false},
			{Position = Vector(-13615, -9222, 34), Active = false},
			{Position = Vector(-12355, -9080, 182), Active = false},
			{Position = Vector(-11662, -7979, 48), Active = false},
			{Position = Vector(-9601, -9661, 11), Active = false},
			{Position = Vector(1486, -3335, 12), Active = false},
			{Position = Vector(4583, -1504, 0), Active = false},
			{Position = Vector(2182, 223, 45), Active = false},
			{Position = Vector(-2409, 1478, 0), Active = false},
			{Position = Vector(1168, -8615, 33), Active = false},
			{Position = Vector(2918, -13801, 52), Active = false}
		},
		Limit = 35, // How many normal veins can be on map at a time
		Default = 5028, // The default rock that is mined if the extra isn't rolled
		Extras = {[5029] = 30} // Rock = Probability %
	},
	Rare = {
		Sizes = {
			small = {Props = {"models/rarerocks/crystal1.mdl"}, Amount = {1, 3}},
			large = {Props = {"models/rarerocks/crystal2.mdl"}, Amount = {2, 4}}
		},
		Positions = {
			{Position = Vector(-7325, -10460, 2), Active = false},
			{Position = Vector(-6255, -13472, 219), Active = false},
			{Position = Vector(-3711, -11483, 2), Active = false},
			{Position = Vector(-3687, -12076, 11), Active = false},
			{Position = Vector(-1957, -5395, 2), Active = false},
			{Position = Vector(-1785, -5718, 2), Active = false},
			{Position = Vector(-3458, -3681, 2), Active = false},
			{Position = Vector(-5953, -504, -260), Active = false},
			{Position = Vector(-6616, -599, -248), Active = false},
			{Position = Vector(-6436, 8560, 18), Active = false},
			{Position = Vector(-6653, 9364, 2), Active = false},
			{Position = Vector(-4041, 10483, 284), Active = false},
			{Position = Vector(-5974, 14118, 2), Active = false},
			{Position = Vector(13039, 3005, 145), Active = false},
			{Position = Vector(13056, 156, 58), Active = false},
			{Position = Vector(11419, 268, 38), Active = false},
			{Position = Vector(13584, -900, 22), Active = false},
			{Position = Vector(-11477, -12078, 2), Active = false},
			{Position = Vector(-13049, -6667, 6), Active = false},
			{Position = Vector(-11709, 874, 43), Active = false},
			{Position = Vector(-13483, 2612, 88), Active = false},
			{Position = Vector(-13350, 3067, 29), Active = false},
			{Position = Vector(-13601, 6472, 2), Active = false},
			{Position = Vector(-13654, 5317, 4), Active = false},
			{Position = Vector(-9899, 7183, 2), Active = false},
			{Position = Vector(14576, 8957, 53), Active = false},
			{Position = Vector(13857, 4067, 343), Active = false}, 
			{Position = Vector(13969, 3550, 57), Active = false},
			{Position = Vector(-13450, 1164, 2), Active = false},
			{Position = Vector(-13035, 1612, 2), Active = false},
			{Position = Vector(2070, -3744, 220), Active = false}
		},
		Limit = 15, // How many rare veins can be on map at a time
		Default = 5030, // The default rock that is mined if the extra isn't rolled
		Extras = {[5031] = 30, [5032] = 10} // Rock = Probability %
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

VEIN_RARE_CHANCE = 10 // % chance that a rare vein is spawned
VEIN_TIMER = 300 // How often we try to spawn a new vein (seconds)
VEIN_SOUND = "pickaxe/deploy.wav" // Sound made when a vein is mined successfully

function printRockPositions()
	for k,v in pairs(ents.FindByModel("models/props_c17/oildrum001_explosive.mdl")) do
		local p = v:GetPos()
		print("{Position = Vector(" ..math.floor(p[1]) ..", " ..math.floor(p[2]) ..", " ..math.floor(p[3]) .."), Active = false},")
	end
end
