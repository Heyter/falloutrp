
// Shared
VEIN_MODEL = "models/props_mining/rock002.mdl"
VEIN_POSITIONS = {
	Vector(-5732, 6528, 4),
	Vector(-4512, 6748, 1)

}

if SERVER then
	hook.Add("InitPostEntity", "SpawnVeins", function()
		timer.Simple(1, function()
			for k,v in pairs(VEIN_POSITIONS) do
				local vein = ents.Create("vein")
				vein:SetPos(v)
				vein:Spawn()
			end
		end)
	end)
end