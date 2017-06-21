
CHEST_LOCATIONS = {
	{Position = Vector(-9918, 12927, -148), Angles = Angle(0, -35, 0)},
	{Position = Vector(-32, 11430, 460), Angles = Angle(0, -180, 0)},
	{Position = Vector(4255, 9132, 108), Angles = Angle(0, -180, 0)},
	{Position = Vector(6790, 743, 52), Angles = Angle(0, -89, 0)},
	{Position = Vector(144, 666, 28), Angles = Angle(0, 91, -1)},
	{Position = Vector(1890, 825, 44), Angles = Angle(0, -179, 0)},
	{Position = Vector(5220, 7049, 628), Angles = Angle(0, -36, 0)},
	{Position = Vector(2659, 11379, 236), Angles = Angle(0, -91, 0)},
	{Position = Vector(4222, 11546, 108), Angles = Angle(0, -1, 0)},
	{Position = Vector(5037, 11627, 169), Angles = Angle(0, 86, -1)},
	{Position = Vector(5363, 11620, 268), Angles = Angle(0, -177, 0)},
	{Position = Vector(5264, 11942, 268), Angles = Angle(0, -97, 0)},
	{Position = Vector(2504, 9497, 108), Angles = Angle(0, -176, 0)},
	{Position = Vector(-9573, 13012, 64), Angles = Angle(0, 63, -1)},
	{Position = Vector(-11428, 9259, 500), Angles = Angle(0, -89, 0)},
	{Position = Vector(-9423, 983, 278), Angles = Angle(0, -1, 0)},
	{Position = Vector(-8336, 3929, 476), Angles = Angle(0, 92, -1)},
	{Position = Vector(-2638, 1923, 60), Angles = Angle(0, 177, 0)},
	{Position = Vector(-2491, 1563, 60), Angles = Angle(0, -94, 0)},
	{Position = Vector(-414, 5900, 94), Angles = Angle(0, 150, 0)},
	{Position = Vector(150, 9137, 209), Angles = Angle(0, -3, 0)},
	{Position = Vector(-6131, 3033, 60), Angles = Angle(0, 2, -1)},
	{Position = Vector(2457, 11675, 108), Angles = Angle(0, -1, 0)},
	{Position = Vector(3164, 12254, 232), Angles = Angle(0, -130, 0)},
	{Position = Vector(6126, 12233, 396), Angles = Angle(0, -2, 0)},
	{Position = Vector(5488, 12215, 268), Angles = Angle(0, -177, 0)},
	{Position = Vector(4161, 9111, 116), Angles = Angle(0, 162, 0)},
	{Position = Vector(7591, 3339, 24), Angles = Angle(0, 7, -1)},
	{Position = Vector(7075, 2490, 24), Angles = Angle(0, 178, 0)},
	{Position = Vector(7108, 3223, 31), Angles = Angle(0, 179, 0)},
	{Position = Vector(7024, 3093, 31), Angles = Angle(0, 135, 0)},
	{Position = Vector(7235, 3036, 47), Angles = Angle(0, 1, -1)},
	{Position = Vector(7910, 1536, 60), Angles = Angle(0, 89, -1)},
	{Position = Vector(2629, -288, 28), Angles = Angle(0, 88, -1)},
	{Position = Vector(2499, -802, 28), Angles = Angle(0, 1, -1)},
	{Position = Vector(-321, 169, 33), Angles = Angle(0, 91, -1)},
	{Position = Vector(-148, 612, 28), Angles = Angle(0, 179, 0)},
	{Position = Vector(-3417, 13318, 76), Angles = Angle(0, -70, 0)},
	{Position = Vector(-9753, 13078, 119), Angles = Angle(0, -93, 0)},
	{Position = Vector(-8613, 11547, -276), Angles = Angle(0, -86, 0)},
	{Position = Vector(-8462, 13219, -204), Angles = Angle(0, 178, 0)},
	{Position = Vector(6320, 5802, 148), Angles = Angle(0, 35, -1)},
	{Position = Vector(-923, 14101, 586), Angles = Angle(0, -71, 0)},
	{Position = Vector(-2606, 12579, -96), Angles = Angle(0, -137, 0)},
}

function spawnchests()
	for k,v in pairs(CHEST_LOCATIONS) do
		local ent = ents.Create("chest")
		ent:SetPos(v.Position)
		ent:SetAngles(v.Angles)
		ent:Spawn()
	end
end

CHEST_MODEL = "models/props/cs_militia/footlocker01_closed.mdl"
CHEST_RARE_MODEL = "models/props/cs_militia/footlocker01_closed.mdl"

CHEST_UNLOCK_SOUND = "doors/latchunlocked1.wav"

CHEST_TIMER = 300 // How often we try to add another chest on the map
CHEST_LIMIT = 25 // How many chests can be on the map at once
