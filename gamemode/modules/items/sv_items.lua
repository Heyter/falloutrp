
util.AddNetworkString("useItem")

local meta = FindMetaTable("Player")

function meta:useItem(uniqueid, classid, quantity)
	if isAid(classid) then
		self:useAid(uniqueid, classid, quantity)
	end
end

net.Receive("useItem", function(len, ply)
	local itemId = net.ReadInt(32)
	local classid = net.ReadInt(16)
	local quantity = net.ReadInt(16)
	
	ply:useItem(itemId, classid, quantity)
end)

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
		return createAid(item)
	elseif isMisc(classid) then
		return createMisc(item)
	end
end