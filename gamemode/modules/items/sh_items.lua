 
//Shared

TYPE_WEAPON = 1
TYPE_APPAREL = 2
TYPE_AMMO = 3
TYPE_AID = 4
TYPE_MISC = 5

function getItemName(classId)
	if isWeapon(classId) then
		return getWeaponName(classId)
	elseif isApparel(classId) then
		return getApparelName(classId)
	elseif isAmmo(classId) then
		return getApparelName(classId)
	elseif isAid(classId) then
		return getAidName(classId)
	elseif isMisc(classId) then
		return getMiscName(classId)
	end
end
function getItemWeight(classId)
	if isWeapon(classId) then
		return getWeaponWeight(classId)
	end
end

function classidToType(classId)
	local index = classId .."" // Convert id number to string so we can index it
	
	return tonumber(index[1])
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