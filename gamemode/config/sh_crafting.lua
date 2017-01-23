
WORKBENCH_MODEL = "models/props_trainstation/bench_indoor001a.mdl"

WORKBENCH_POSITIONS = {
	Vector(-8989, 10147, 19)
}

if SERVER then
	hook.Add("InitPostEntity", "SpawnWorkbenches", function()
		timer.Simple(1, function()
			for k,v in pairs(WORKBENCH_POSITIONS) do
				local bench = ents.Create("workbench")
				bench:SetPos(v)
				bench:Spawn()
			end
		end)
	end)
end