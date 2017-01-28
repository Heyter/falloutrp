
util.AddNetworkString("setHunger")
util.AddNetworkString("setThirst")

local meta = FindMetaTable("Player")

local hungerMax = HUNGER_MAX or 0 // Max hunger a player can have
local hungerDelay = HUNGER_DELAY
local hungerRemove = HUNGER_REMOVE
local hungerDamage = HUNGER_DAMAGE

local thirstMax = THIRST_MAX or 0 // Max thirst a player can have
local thirstDelay = THIRST_DELAY
local thirstRemove = THIRST_REMOVE
local thirstDamage = THIRST_DAMAGE

function meta:setHunger(amount)
	self.playerData.hunger = amount
	
	net.Start("setHunger")
		net.WriteInt(self:getHunger(), 8)
	net.Send(self)
end

function meta:addHunger(amount)
	local currentHunger = self:getHunger()

	if currentHunger + amount > hungerMax then
		self:setHunger(hungerMax)
	else
		self:setHunger(currentHunger + amount)
	end
end

function meta:updateHunger(amount)
	if (self:getHunger() - hungerRemove) >= 0 then // Player will still have positive hunger after this removal
		self:addHunger(-hungerRemove)
	end
	
	if self:getHunger() <= 0 then // They are out of hunger
		self:addHealth(-hungerDamage)
	end
end

function meta:startHungerTimer()
	timer.Create("hungerUpdate" ..self:EntIndex(), hungerDelay, 0, function()
		if IsValid(self) and self:Alive() then
			self:updateHunger(hungerRemove)
		end
	end)
end

function meta:setThirst(amount)
	self.playerData.thirst = amount
	
	net.Start("setThirst")
		net.WriteInt(self:getThirst(), 8)
	net.Send(self)
end

function meta:addThirst(amount)
	local currentThirst = self:getThirst()

	if currentThirst + amount > thirstMax then
		self:setThirst(thirstMax)
	else
		self:setThirst(currentThirst + amount)
	end
end

function meta:updateThirst(amount)
	if (self:getThirst() - thirstRemove) >= 0 then // Player will still have positive hunger after this removal
		self:addThirst(-thirstRemove)
	end
	
	if self:getThirst() <= 0 then // They are out of hunger
		self:addHealth(-thirstDamage)
	end
end

function meta:startThirstTimer()
	timer.Create("thirstUpdate" ..self:EntIndex(), thirstDelay, 0, function()
		if IsValid(self) and self:Alive() then
			self:updateThirst(thirstRemove)
		end
	end)
end