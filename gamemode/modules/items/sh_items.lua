ITEM = {}

function ITEM:getId()
	return self.id
end
function ITEM:getName()
	return self.name
end
function ITEM:getRarity()
	return self.rarity
end
function ITEM:getEntity()
	return self.entity
end
function ITEM:getType()
	return self.type
end
function ITEM:getWeight()
	return self.weight or 0
end
function ITEM:getValue()
	return self.value or 0
end
function ITEM:getLevel()
	return self.level or 0
end
function ITEM:getModel()
	return self.model
end
function ITEM:getSlot()
	return self.slot
end
function ITEM:getMaxDurability()
	return self.durability
end
function ITEM:getNameQuantity(quantity)
	local name = self:getName()

	if util.positive(quantity) then
		return name .." (" ..quantity ..")"
	end

	return name
end
function ITEM:getQuest()
	return self.quest
end

local caps = {name = "Caps"}
setmetatable(caps, {__index = ITEM})

function findItem(classid)
	if isCap(classid) then
		return caps
	elseif isWeapon(classid) then
		return findWeapon(classid)
	elseif isApparel(classid) then
		return findApparel(classid)
	elseif isAmmo(classid) then
		return findAmmo(classid)
	elseif isAid(classid) then
		return findAid(classid)
	elseif isMisc(classid) then
		return findMisc(classid)
	end
end

function classidToType(classid)
	local index = classid .."" // Convert id number to string so we can index it

	return tonumber(index[1])
end

function classidToStringType(classid)
	if isWeapon(classid) then
		return "weapons"
	elseif isApparel(classid) then
		return "apparel"
	elseif isAmmo(classid) then
		return "ammo"
	elseif isAid(classid) then
		return "aid"
	elseif isMisc(classid) then
		return "misc"
	end
end

function isCap(classid)
	return classidToType(classid) == TYPE_CAP
end
function isWeapon(classid)
	return classidToType(classid) == TYPE_WEAPON
end
function isApparel(classid)
	return classidToType(classid) == TYPE_APPAREL
end
function isAmmo(classid)
	return classidToType(classid) == TYPE_AMMO
end
function isAid(classid)
	return classidToType(classid) == TYPE_AID
end
function isMisc(classid)
	return classidToType(classid) == TYPE_MISC
end

function isStackable(classid)
	return isAmmo(classid) or isAid(classid) or isMisc(classid)
end
