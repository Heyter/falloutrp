
local teamEmblems = {}

function team.setEmblem(teamIndex, emblem)
	teamInfo[teamIndex] = emblem
end
function team.getEmblem(teamIndex)
	return teamInfo[teamIndex] or ""
end

team.setEmblem(1, "falloutrp/factions/BrotherhoodOfSteelEmblem.png")
team.setEmblem(2, "falloutrp/factions/NewCaliforniaRepublicEmblem.png")
team.setEmblem(3, "falloutrp/factions/LegionEmblem.png")