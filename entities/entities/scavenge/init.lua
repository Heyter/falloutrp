AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.nextUse = 0
end

function ENT:OnTakeDamage(dmg)

end

function ENT:Think()

end

function ENT:Use(activator)
	if IsValid(activator) and activator:IsPlayer() and (self.count > 0) then
		USE:begin(self, activator, 3)
	end
end

function ENT:OnUseFinish(activator)
	if IsValid(activator) and activator:IsPlayer() and (self.count > 0) then
		self:EmitSound(SCAVENGE_SOUND)
		local loot = self:generateLoot()
		local hitPos = activator:GetEyeTrace().HitPos

		createLoot(hitPos, loot)
		self:reduceCount(#loot)

		activator:addExp(5)

		activator:notify("Scavenged object.", NOTIFY_GENERIC)

		USE:begin(self, activator, 5)
	end
end

function ENT:hasStackableItem(loot, classid)
	for k,v in pairs(loot) do
		if v.classid == classid and isStackable(classid) then
			return k
		end
	end

	return false
end

function ENT:generateLoot()
	local loot = {}

	// Add the default item and subtract item amount
	for i = 1, self.count do
		local item = createItem(SCAVENGE[self:getType()]["Default"], 1)

		local exists = self:hasStackableItem(loot, item.classid)
		if exists then
			loot[exists].quantity = loot[exists].quantity + item.quantity
		else
			table.insert(loot, item)
		end

		local extras = SCAVENGE[self:getType()]["Extras"]

		for item, chance in pairs(extras) do
			if (self:getCount() - #loot > 0) then
				if util.roll(chance) then
					local extraItem = createItem(item, 1)

					local exists = self:hasStackableItem(loot, extraItem.classid)
					if exists then
						loot[exists].quantity = loot[exists].quantity + extraItem.quantity
					else
						table.insert(loot, extraItem)
					end
				end
			end
		end
	end

	return loot
end



function ENT:reduceCount(amount)
	self.count = 0

	SCAVENGE[self:getType()]["Positions"][self.key]["Active"] = false
	util.fadeRemove(self)
end


function ENT:setType(type)
	self.type = type
end

function ENT:getType()
	return self.type
end

function ENT:setCount(count)
	self.count = count
end

function ENT:getCount()
	return self.count
end
