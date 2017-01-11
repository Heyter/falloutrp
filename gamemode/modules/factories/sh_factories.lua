
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
		["Bottlecap Factory"] = {Pos = Vector(8210, -12384, 2), Type = "Caps", Amount = 50, Delay = 300, Description = "The bottlecap factory automatically gives bottlecaps to the players of the owning faction."},
		["Weapon Factory"] = {Pos = Vector(9400, -12384, 2), Items = {1001, 1002, 1003}, Delay = 300, Description = "The weapon factory automatically creates weapons and stores them inside the factory itself, waiting for the players of the owning faction to loot them."},
		["Apparel Factory"] = {Pos = Vector(10600, -12384, 2), Items = {1001, 1002, 1003}, Delay = 300, Description = "The apparel factory automatically creates apparel and stores them inside the factory itself, waiting for the players of the owning faction to loot them."},
		["Ammunition Factory"] = {Pos = Vector(10000, -1100, 2), Items = {1001, 1002, 1003}, Delay = 300, Description = "The ammunition factory automatically creates ammunition and stores them inside the factory itself, waiting for the players of the owning faction to loot them."},
		["Materials Factory"] = {Pos = Vector(9000, -13000, 2), Items = {1001, 1002, 1003}, Delay = 300, Description = "The materials factory automatically creates crafting materials and stores them inside the factory itself, waiting for the players of the owning faction to loot them."},
	}
}
-------------------------------------------DONT TOUCH BEYOND HERE----------------------------------------------------

function FACTORY:controllerToString(controller)
	if controller == 0 then
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