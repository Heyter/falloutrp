
local meta = FindMetaTable("Player")

function createItem(classid)
	local item = {}
	item.classid = classid
	
	if isWeapon(classid) then
		return createWeapon(item)
	elseif isApparel(classid) then
		return createApparel(item)
	elseif isAmmo(classid) then
		return createAmmo(item)
	elseif isAid(classid) then
				
	elseif isMisc(classid) then
		return createMisc(item)
	end
end