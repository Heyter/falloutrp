
// Server
function createAmmo(item, quantity, useBase)
	item.quantity = quantity or 1
	
	return item
end

function spawnItAll()
	for k,v in pairs(CHEST_LOCATIONS) do
		local ent = ents.Create("chest")
		ent:SetPos(v.Position)
		ent:SetAngles(v.Angles)
		ent:Spawn()
	end

	for k,v in pairs(VEINS) do
		for a,b in pairs(v.Positions) do
			local ent = ents.Create("vein")
			ent:SetModel("models/props_mining/rock002.mdl")
			ent:SetPos(b.Position)
			ent:Spawn()
		end
	end
	for k,v in pairs(NPCS) do
		for a, b in pairs(v.Positions) do
			local ent = ents.Create("vein")
			ent:SetPos(b.Position)
			ent:Spawn()
			ent:SetModel("models/props_borealis/bluebarrel001.mdl")
		end
	end
end