
local meta = FindMetaTable("Player")

function createItem(classId)
	local item = {}
	item.classId = classId
	
	if isWeapon(classId) then
		return createWeapon(item)
	elseif isApparel(classId) then
		
	elseif isAmmo(classId) then
			
	elseif isAid(classId) then
				
	elseif isMisc(classId) then
	
	end
end