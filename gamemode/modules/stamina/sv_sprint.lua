	
local staminaDrainSpeed 	= STAMINA_DRAIN_SPEED	-- Time in seconds
local staminaRestoreSpeed 	= STAMINA_RESTORE_SPEED	-- Time in seconds	

local disableLevel = DISABLE_RUN
local defaultJump = JUMP_POWER	
	
-- PlayerSpawn
function tcb_StaminaStart(ply)
	if ply.loaded then
		timer.Destroy("tcb_StaminaTimer")
		ply:SetRunSpeed(ply:getMaxRunSpeed())
		ply:SetNWInt("tcb_Stamina", ply:getMaxSprintLength())
		
		tcb_StaminaRestore(ply)
	end
end
hook.Add("PlayerSpawn", "tcb_StaminaStart", tcb_StaminaStart)
	
-- KeyPress
function tcb_StaminaPress(ply, key)

	if key == IN_SPEED or ply:KeyDown(IN_SPEED) then
		if ply:InVehicle() then return end
		if ply:GetMoveType() == MOVETYPE_NOCLIP then return end
		if ply:GetMoveType() ==  MOVETYPE_LADDER then return end
		local maxRun = ply:getMaxRunSpeed()
		local maxWalk = ply:getMaxWalkSpeed()
		if ply:GetNWInt( "tcb_Stamina" ) > disableLevel then
			ply:SetRunSpeed(maxRun)
			timer.Destroy("tcb_StaminaGain")
			timer.Create( "tcb_StaminaTimer", staminaDrainSpeed, 0, function( )
				if ply:GetNWInt("tcb_Stamina") <= 0 then
					ply:SetRunSpeed(maxWalk)
					timer.Destroy("tcb_StaminaTimer")
					return false
				end
				local vel = ply:GetVelocity()
				if vel.x >= maxWalk or vel.x <= -maxWalk or vel.y >= maxWalk or vel.y <= -maxWalk then
					ply:SetNWInt("tcb_Stamina", ply:GetNWInt("tcb_Stamina") - 1)
				end
			end)
		else
			ply:SetRunSpeed(maxWalk)
			timer.Destroy("tcb_StaminaTimer")
		end
	end
	if key == IN_JUMP or ply:KeyDown(IN_JUMP) then
		if ply:GetNWInt("tcb_Stamina") > disableLevel then
			ply:SetJumpPower(defaultJump)
			ply:SetNWInt("tcb_Stamina", ply:GetNWInt("tcb_Stamina") - 1)
		else
			ply:SetJumpPower(0)
		end
	end
end
hook.Add("KeyPress", "tcb_StaminaPress", tcb_StaminaPress) 

-- KeyRelease
function tcb_StaminaRelease(ply, key)
	if key == IN_SPEED and !ply:KeyDown(IN_SPEED) then
		timer.Destroy("tcb_StaminaTimer")
		tcb_StaminaRestore(ply)
	end
end
hook.Add("KeyRelease", "tcb_StaminaRelease", tcb_StaminaRelease) 
	
-- StaminaRestore
function tcb_StaminaRestore(ply)
	timer.Create("tcb_StaminaGain", staminaRestoreSpeed, 0, function( ) 
		if IsValid(ply) then
			if ply:GetNWInt("tcb_Stamina") >= ply:getMaxSprintLength() then
				return false
			else
				ply:SetNWInt("tcb_Stamina", ply:GetNWInt("tcb_Stamina") + 1)
			end
		end
	end)	
end
