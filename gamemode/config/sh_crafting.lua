
WORKBENCH_MODEL = "models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl"

WORKBENCH_POSITIONS = {
	{Vector(-10667, 1816, 127), Angle(0, 60, 0)}
}

if SERVER then
	hook.Add("InitPostEntity", "SpawnWorkbenches", function()
		timer.Simple(1, function()
			for k,v in pairs(WORKBENCH_POSITIONS) do
				local bench = ents.Create("workbench")
				bench:SetPos(v[1])
				bench:SetAngles(v[2])
				bench:Spawn()
			end
		end)
	end)
end
