
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

function createItem(classid, quantity, useLower, useHigher)
	local item = {}
	item.classid = classid

	if isCap(classid) then
		item.quantity = quantity or 1
		return item
	elseif isWeapon(classid) then
		return createWeapon(item, nil, useLower, useHigher)
	elseif isApparel(classid) then
		return createApparel(item, nil, useLower, useHigher)
	elseif isAmmo(classid) then
		return createAmmo(item, quantity)
	elseif isAid(classid) then
		return createAid(item, quantity)
	elseif isMisc(classid) then
		return createMisc(item, quantity)
	end
end
