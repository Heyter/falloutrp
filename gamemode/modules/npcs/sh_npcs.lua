local meta = FindMetaTable("Entity")

function meta:IsNPC()
	local class = self:GetClass()

	if string.sub(class, 1, 3) == "nz_" then
		return true
	elseif string.sub(class, 1, 4) == "npc_" then
		return true
	end
end

function getNpcExp(type)
	return (NPCS.npcs[type] and NPCS.npcs[type]["Experience"]) or 100
end
function getNpcName(type)
	return (NPCS.npcs[type] and NPCS.npcs[type]["Name"]) or "N/A"
end
function getNpcHealth(type)
	return (NPCS.npcs[type] and NPCS.npcs[type]["Health"]) or 100
end
function getNpcLoot(type)
	return NPCS.npcs[type]["Loot"]
end
function getNpcLevel(type)
	return NPCS.npcs[type]["Level"]
end
