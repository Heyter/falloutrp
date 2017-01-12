
local teamEmblems = {}

function team.setEmblem(teamIndex, emblem)
	teamEmblems[teamIndex] = emblem
end
function team.getEmblem(teamIndex)
	return teamEmblems[teamIndex] or ""
end

team.setEmblem(1, Material("falloutrp/factions/BrotherhoodOfSteelEmblem.png"))
team.setEmblem(2, Material("falloutrp/factions/NewCaliforniaRepublicEmblem.png"))
team.setEmblem(3, Material("falloutrp/factions/LegionEmblem.png"))