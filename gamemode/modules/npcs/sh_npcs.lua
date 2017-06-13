function getNpcExp(type)
	return (NPCS[type] and NPCS[type]["Experience"]) or 100
end
function getNpcName(type)
	return (NPCS[type] and NPCS[type]["Name"]) or "N/A"
end
function getNpcHealth(type)
	return (NPCS[type] and NPCS[type]["Health"]) or 100
end
function getNpcLoot(type)
	return NPCS[type]["Loot"]
end
function getNpcLevel(type)
	return NPCS[type]["Level"]
end
