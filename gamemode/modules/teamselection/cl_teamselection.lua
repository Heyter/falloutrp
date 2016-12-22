

local teams = {
	[1] = {
		Name = "Brotherhood of Steel", 
		Emblem = "falloutrp/factions/BrotherhoodOfSteelEmblem.png",
		Repuation = "falloutrp/factions/BrotherhoodOfSteelReputation.png",
		Description = "We are awesome.\nYou need to join."
	}
}

local function teamSelection()

	print("Hi")
end

net.Receive("teamSelection", function(len, ply)
	teamSelection()
end)