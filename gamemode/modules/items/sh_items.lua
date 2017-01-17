 
//Shared

TYPE_WEAPON = 1
TYPE_APPAREL = 2
TYPE_AMMO = 3
TYPE_AID = 4
TYPE_MISC = 5

function getItemName(classid)
	if isWeapon(classid) then
		return getWeaponName(classid)
	elseif isApparel(classid) then
		return getApparelName(classid)
	elseif isAmmo(classid) then
		return getAmmo(classid)
	elseif isAid(classid) then
		return getAidName(classid)
	elseif isMisc(classid) then
		return getMiscName(classid)
	end
end
function getItemWeight(classid)
	if isWeapon(classid) then
		return getWeaponWeight(classid)
	elseif isApparel(classid) then
		return getApparelWeight(classid)
	elseif isAmmo(classid) then
		return getAmmoWeight(classid)
	elseif isAid(classid) then
		return getAidWeight(classid)
	elseif isMisc(classid) then
		return getMiscWeight(classid)
	end
end
function getItemModel(classid)
	if isWeapon(classid) then
		return getWeaponModel(classid)
	elseif isApparel(classid) then
		return getApparelModel(classid)
	elseif isAmmo(classid) then
		return getAmmoModel(classid)
	elseif isAid(classid) then
		return getAidModel(classid)
	elseif isMisc(classid) then
		return getMiscModel(classid)
	end
end

function getItemNameQuantity(classid, quantity)
	if util.positive(quantity) then
		if isAmmo(classid) then
			return getAmmoNameQuantity(classid, quantity)
		elseif isAid(classid) then
			return getAidNameQuantity(classid, quantity)
		elseif isMisc(classid) then
			return getMiscNameQuantity(classid, quantity)
		end
	else
		return getItemName(classid)
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