 
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
		return getApparelName(classid)
	elseif isAid(classid) then
		return getAidName(classid)
	elseif isMisc(classid) then
		return getMiscName(classid)
	end
end
function getItemWeight(classid)
	if isWeapon(classid) then
		return getWeaponWeight(classid)
	end
end
function getItemModel(classid)
	if isWeapon(classid) then
		return getWeaponModel(classid)
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