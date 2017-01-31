
BANK_WEIGHT = 300 // The max weight that a bank can hold
BANK_MODEL = "models/sal/fallout4/safe.mdl" // The model of the bank

BANK_POSITIONS = {
	{Vector(-8298, 11153, 38), Angle(0, -90, 0)}
}

if SERVER then
	hook.Add("InitPostEntity", "SpawnBanks", function()
		timer.Simple(1, function()
			for k,v in pairs(BANK_POSITIONS) do
				local bank = ents.Create("bank")
				bank:SetPos(v[1])
				bank:SetAngles(v[2])
				bank:Spawn()
			end
		end)
	end)
end