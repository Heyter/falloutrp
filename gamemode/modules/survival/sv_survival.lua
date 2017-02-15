
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

local moans = {
	"vo/npc/male01/moan01.wav",
	"vo/npc/male01/moan02.wav",
	"vo/npc/male01/moan03.wav",
	"vo/npc/male01/moan04.wav",
	"vo/npc/male01/moan05.wav",
}

function meta:moan()
	local sound, index = table.Random(moans)
	
	self:EmitSound(sound)
end

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
	local oldStatus = self:getHungerStatus()

	if (self:getHunger() - hungerRemove) >= 0 then // Player will still have positive hunger after this removal
		self:addHunger(-hungerRemove)
		
		local newStatus = self:getHungerStatus()
		
		if newStatus != oldStatus then
			self:notify("You are feeling " ..newStatus .."!", NOTIFY_GENERIC)
		end
	end
	
	if self:getHunger() <= 0 then // They are out of hunger
		self:addHealth(-hungerDamage)
		self:notify("You need food.", NOTIFY_GENERIC)
		self:moan()
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
	local oldStatus = self:getThirstStatus()

	if (self:getThirst() - thirstRemove) >= 0 then // Player will still have positive thirst after this removal
		self:addThirst(-thirstRemove)
		
		local newStatus = self:getThirstStatus()
		
		if newStatus != oldStatus then
			self:notify("You are feeling " ..newStatus .."!", NOTIFY_GENERIC)
		end
	end
	
	if self:getThirst() <= 0 then // They are out of thirst
		self:addHealth(-thirstDamage)
		self:notify("You need water.", NOTIFY_GENERIC)
		self:moan()
	end
end

function meta:startThirstTimer()
	timer.Create("thirstUpdate" ..self:EntIndex(), thirstDelay, 0, function()
		if IsValid(self) and self:Alive() then
			self:updateThirst(thirstRemove)
		end
	end)
end