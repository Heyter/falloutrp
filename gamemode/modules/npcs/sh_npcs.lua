function getNpcExp(type)
	return (NPCS.npcs[type] and NPCS[type]["Experience"]) or 100
end
function getNpcName(type)
	return (NPCS.npcs[type] and NPCS[type]["Name"]) or "N/A"
end
function getNpcHealth(type)
	return (NPCS.npcs[type] and NPCS[type]["Health"]) or 100
end
function getNpcLoot(type)
	return NPCS.npcs[type]["Loot"]
end
function getNpcLevel(type)
	return NPCS.npcs[type]["Level"]
end
