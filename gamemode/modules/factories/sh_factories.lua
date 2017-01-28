
if !FACTORY then
	FACTORY = {} 
end

------------------------------------------EDIT BELOW HERE--------------------------------------------------------------
FACTORY.captureTime = 20 //How long the war(contested) lasts
FACTORY.captureDistance = 1300 //Distance away that player must be from FACTORY to be detected when capturing

FACTORY.warCommand = "/war" //Command players type to start war
FACTORY.warDistance = 1500 //Distance away that player must be from FACTORY to start war

FACTORY.Message_CurrentlyContested = "This factory is currently being contested!" //Message when you try to /war
FACTORY.Message_ControlledByYou = "Your faction owns this FACTORY!" //Message when you try to /war

FACTORY.Color_Place = Color(255, 255, 255, 255) //Name of FACTORY
FACTORY.Color_Time = Color(255, 255, 255, 255) //The Time Counting down
FACTORY.Color_Contested = Color(255, 0, 0, 255) //The "CONTESTED"
FACTORY.Color_Controller = Color(0, 255, 0, 255) //Name of who owns it

FACTORY.Cooldown = 600 //How long after a war before another can start

FACTORY.Setup = { //Name Of Place = Position, Check Received Every Salary For Owning FACTORY(If Enabled)
	["gm_construct"] = {
		["Bottlecap Factory"] = {Pos = Vector(-480, -1450, -80), Type = "Caps", Amount = 50, Delay = 300},
		["Weapon Factory"] = {Pos = Vector(1400, 3280, 30), Items = {1001, 1002, 1003}, Delay = 300},
		["Apparel Factory"] = {Pos = Vector(1400, 3280, 30), Items = {1001, 1002, 1003}, Delay = 300},
		["Ammunition Factory"] = {Pos = Vector(1400, 3280, 30), Items = {1001, 1002, 1003}, Delay = 300},
		["Materials Factory"] = {Pos = Vector(1400, 3280, 30), Items = {1001, 1002, 1003}, Delay = 300},
	},	
	["rp_oldworld_fix"] = {
		["Bottlecap Factory"] = {Pos = Vector(3585, -9319, 2), Type = "Caps", Amount = 250, Delay = 300, Description = "The bottlecap factory automatically gives bottlecaps to the players of the owning faction."},
		["Weapon Factory"] = {Pos = Vector(10127, 8297, -572), Items = {1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075}, Delay = 300, Description = "The weapon factory automatically creates weapons and stores them inside the factory itself, waiting for the players of the owning faction to loot them."},
		["Apparel Factory"] = {Pos = Vector(-9607, -12451, 0), Items = {2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036, 2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044, 2045, 2046, 2047, 2048, 2049, 2050, 2051, 2052, 2053, 2054, 2055, 2056, 2057, 2058, 2059, 2060, 2061, 2062, 2063, 2064, 2065, 2065, 2066, 2067, 2068, 2069, 2070, 2071, 2072, 2073, 2074, 2075, 2076, 2077, 2078, 2079, 2080, 2081, 2082, 2083, 2084, 2085, 2086, 2087, 2088, 2089, 2090, 2091, 2092, 2093, 2094, 2095, 2096}, Delay = 300, Description = "The apparel factory automatically creates apparel and stores them inside the factory itself, waiting for the players of the owning faction to loot them."},
		["Ammunition Factory"]  = {Pos = Vector(11864, -11829, 9), Items = {3002, 3004, 3005, 3006, 3007, 3008, 3009, 3010, 3011, 3012, 3014, 3014, 3015, 3016, 3017, 3020, 3021, 3023, 3026 }, Delay = 300, Description = "The ammunition factory automatically creates ammunition and stores them inside the factory itself, waiting for the players of the owning faction to loot them."},
		["Materials Factory"] = {Pos = Vector(-6182, -3804, -37), Items = {5028, 5029, 5030, 5031, 5033, 5034, 5035, 5044, 5045, 5043, 5042, 5046}, Delay = 300, Description = "The materials factory automatically creates crafting materials and stores them inside the factory itself, waiting for the players of the owning faction to loot them."},
	}
}
-------------------------------------------DONT TOUCH BEYOND HERE----------------------------------------------------

function FACTORY:controllerToString(controller)
	if controller == 4 then
		return "Uncontested"
	else
		return team.GetName(controller) or ""
	end
end

if SERVER then
	function FACTORY.spawnFactories()
		for map,tab in pairs(FACTORY.Setup) do
			if map == game.GetMap() then
				for place, tab in pairs(tab) do
					local t = ents.Create("factory")
					t:SetPos(tab["Pos"])
					t:SetPlace(place)
					t:Spawn()
				end
			end
		end
	end
	hook.Add("InitPostEntity", "spawnFactories", FACTORY.spawnFactories)
end