
hook.Add("PlayerSpawn", "SetupPlayer", function(ply)
	if ply.loaded then
		timer.Simple(1, function()
			// Set health
			ply:SetHealth(ply:getMaxHealth())

			// Initialize hunger
			ply:setHunger(HUNGER_MAX)
			ply:startHungerTimer()

			// Initialize thirst
			ply:setThirst(THIRST_MAX)
			ply:startThirstTimer()

			// Initialize stamina
			tcb_StaminaStart(ply)

			// Initialize health regen
			ply:startHealthRegen()

			// Ask Pvp protection
			ply:pvpProtection()

			if ply:Team() == TEAM_BOS then
				ply:SetModel("models/player/nikout/fallout/wintercombatarmormale.mdl")
			elseif ply:Team() == TEAM_NCR then
				ply:SetModel("models/player/ncr/desertranger.mdl")
			elseif ply:Team() == TEAM_LEGION then
				ply:SetModel("models/player/cl/military/legiondecanus.mdl")
			end
		end)
	end
end)

hook.Add("PlayerSpawn", "CustomCollision", function(ply)
	ply:SetAvoidPlayers(true)
end)

// Loadout
hook.Add("PlayerLoadout", "playerLoadout", function(ply)
	ply:Give("rphands")

	// No default loadout
	return true
end)
