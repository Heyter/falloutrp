
util.AddNetworkString("useAid")

local meta = FindMetaTable("Player")

function createAid(item)
	item.quantity = 1
	
	return item
end

function meta:loadInvAid()
	// Get aid
	MySQLite.query("SELECT * FROM aid WHERE steamid = '" ..self:SteamID() .."'", function(results)
		self:loadInventoryCount()
	end)	
end

function meta:addHealth(health)
	local currentHp = self:Health()
	
	if currentHp + health > self:getMaxHealth() then
		self:SetHealth(self:getMaxHealth())
	else
		self:SetHealth(currentHp + health)
		
		// Kill the player if they go below 0 health
		if self:Health() <= 0 then
			self:Kill()
		end
	end
end

function meta:addHealthOverTime(health, timeInterval, timeLength)
	if timer.Exists("healthOverTime" ..self:EntIndex()) then
		timer.Destroy("healthOverTime" ..self:EntIndex())
	end

	local healthInterval = health / (timeLength / timeInterval)
	
	timer.Create("healthOverTime" ..self:EntIndex(), timeInterval, (timeLength / 2), function()
		if IsValid(self) then
			self:addHealth(healthInterval)
		end
	end)
end


function meta:doAidFunction(classid)
	local healthPercent = getAidHealthPercent(classid)
	local health = getAidHealth(classid)
	local timeInterval = getAidTimeInterval(classid)
	local timeLength = getAidTimeLength(classid)
	local hunger = getAidHunger(classid)
	local thirst = getAidThirst(classid)
	
	if util.positive(time) then
		if util.positive(healthPercent) then
			self:addHealthOverTime((healthPercent/100) * self:getMaxHealth(), time)
		end
		if util.positive(health) then
			self:addHealthOverTime(health, time)
		end
	else
		if util.positive(healthPercent) then
			self:addHealth((healthPercent/100) * self:getMaxHealth())
		end
		if util.positive(health) then
			self:addHealth(health)
		end
		if util.positive(hunger) then
			self:addHunger(hunger)
		end
		if util.positive(thirst) then
			self:addThirst(thirst)
		end
	end
end

function meta:useAid(uniqueid, classid, quantity)
	local aidQuantity = self:getAidQuantity(uniqueid)

	if aidQuantity >= quantity then
		if aidQuantity == quantity then // If they used up all the aid that was in their inventory
			self.inventory.aid[uniqueid] = nil
			MySQLite.query("DELETE FROM aid WHERE uniqueid = " ..uniqueid)
		else // Deduct how much aid they used
			self.inventory.aid[uniqueid]["quantity"] = self.inventory.aid[uniqueid]["quantity"] - quantity
			MySQLite.query("UPDATE aid SET quantity = " ..self.inventory.aid[uniqueid]["quantity"] .." WHERE uniqueid = " ..uniqueid)
		end

		// Do the function associated with the aid
		self:doAidFunction(classid)
				
		//Update client
		net.Start("useAid")
			net.WriteInt(uniqueid, 32)
			net.WriteInt(classid, 16)
			net.WriteInt(quantity, 16)
		net.Send(self)
	else
		// Client tried to use more quantity than is actually there
	end
end