
BANK_WEIGHT = 500 // The max weight that a bank can hold
BANK_MODEL = "models/fallout3/vaultdesk01.mdl" // The model of the bank

BANK_POSITIONS = {
	Vector(-9317, 10401, 0)
}

if SERVER then
	hook.Add("InitPostEntity", "SpawnBanks", function()
		timer.Simple(1, function()
			for k,v in pairs(BANK_POSITIONS) do
				local bank = ents.Create("bank")
				bank:SetPos(v)
				bank:Spawn()
			end
		end)
	end)
end