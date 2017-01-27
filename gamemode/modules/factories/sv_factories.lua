
if !FACTORY then
	FACTORY = {} 
end

util.AddNetworkString("factoryInfo")

function FACTORY.WarSay(ply, text)
	if string.sub(text, 1, #FACTORY.warCommand) == FACTORY.warCommand then
		FACTORY:CheckInTerritory(ply)
		return ""
	end
end
hook.Add("PlayerSay", "WarSay", FACTORY.WarSay)

function FACTORY:CheckInTerritory(ply)
	for k,v in pairs(ents.FindByClass("factory")) do
		if ply:GetPos():Distance(v:GetPos()) <= self.warDistance then
			self:CheckStatus(ply, v)
			return
		end
	end
end

function FACTORY:CheckStatus(ply, factory)
	if factory:GetStatus() == 1 then --Contested
		ply:notify(self.Message_CurrentlyContested, NOTIFY_ERROR)
		return
	elseif factory:GetController() == ply:Team() then
		ply:notify(self.Message_ControlledByYou, NOTIFY_ERROR)
		return
	elseif factory:OnCooldown() then
		local cd = factory:GetCooldown() - CurTime()
		ply:notify("You must wait " ..string.FormattedTime(cd, "%02i:%02i") .." before doing another war!", NOTIFY_ERROR)
		return
	else
		self:StartWar(ply:Team(), factory)
	end
end

function FACTORY:StartWar(clan, factory)
	factory:SetCooldown()
	factory:SetStatus(1)
	factory:SetTime(self.captureTime)
	
	// Notify the server that its being taken over
	--CLANS:notifyAllClans("Clan factory", 5, clan.. " is taking over " ..factory:GetPlace())
	
	timer.Create("FACTORY " ..factory:GetPlace(), 1, self.captureTime, function()
		self:CheckCaptureStatus(factory)
	end)
end

function FACTORY:CheckCaptureStatus(factory)
	local teams = {} 
	
	for k,v in pairs(ents.FindInSphere(factory:GetPos(), self.captureDistance)) do
		if v:IsValid() && v:IsPlayer() && v:Alive() then
			if !teams[v:Team()] then
				teams[v:Team()] = 1
			else
				teams[v:Team()] = teams[v:Team()] + 1
			end
		end
	end
	
	factory:SetTime(factory:GetTime() - 1)
	
	//This is for keeping the current winner - the winner, if there is a tie
	local currentKey, currentValue
	if teams[factory:GetController()] then
		currentKey = factory:GetController()
		currentValue = teams[factory:GetController()]
	end
	
	
	if factory:GetTime() <= 0 then
		self:EndWar(factory, util.getWinningKeyTie(teams, currentKey, currentValue))
	else
		self:ChangeCaptureStatus(factory, util.getWinningKeyTie(teams, currentKey, currentValue))
	end
end

function FACTORY:ChangeCaptureStatus(factory, owner)
	if owner == nil then
		factory:SetController(4)
	else
		factory:SetController(owner)
	end
end

function FACTORY:EndWar(factory, winner)
	timer.Destroy("FACTORY" ..factory:GetPlace())
	
	if winner != nil then
		// Create hook
		--CLANS:notifyAllClans("Clan factory", 5, winner.. " has taken over " ..factory:GetPlace())
	end
	
	if winner == nil then
		factory:SetStatus(0)
		factory:SetController(4)
	else
		// Remove the existing timer
		if timer.Exists("Factory" ..factory:EntIndex()) then
			timer.Remove("Factory" ..factory:EntIndex())
		end
	
		factory:SetStatus(2)
		factory:SetController(winner)
		
		timer.Create("Factory" ..factory:EntIndex(), factory:getInfo()["Delay"], 0, function()
			local faction = factory:GetController()
				
			if faction != 0 then // The factory is owner by a faction
				if factory:getInfo()["Type"] == "Caps" then
					for k,ply in pairs(team.GetPlayers(faction)) do
						ply:addCaps(factory:getInfo()["Amount"])
					end
				else
					for k,ply in pairs(team.GetPlayers(faction)) do
						factory:addRandomItem(ply)
					end
				end
			end
		end)
	end
end

function FACTORY.SendInfo()
	timer.Create("FACTORY Send Info", 1, 0, function()
	
		FACTORY.clientInfo = {}
		
		for k,ply in pairs(player.GetAll()) do
			for k,factory in pairs(ents.FindByClass("factory")) do
				FACTORY.clientInfo[factory:GetPlace()] = {
					Pos = {factory:GetPos().x, factory:GetPos().y, factory:GetPos().z},
					Time = factory:GetTime(),
					Controller = factory:GetController(),
					Status = factory:GetStatus()
				}
			end
			
			net.Start("factoryInfo")
				net.WriteTable(FACTORY.clientInfo)
			net.Send(ply)
		end
	end)
end
hook.Add("InitPostEntity", "SendInfo", FACTORY.SendInfo)
