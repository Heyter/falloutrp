
// Server
local meta = FindMetaTable("Player")

function meta:doHealthRegen()
	self:addHealth(1)
	
	timer.Simple(5 - (5 * self:getEnduranceHealthRegen()), function()
		if IsValid(self) and self:Alive() then
			self:doHealthRegen()
		end
	end)
end

function meta:startHealthRegen()
	timer.Simple(5, function()
		if IsValid(self) and self:Alive() then
			self:doHealthRegen()
		end
	end)
end