
local meta = FindMetaTable("Player")

function meta:hasVip()
	return tobool(self.playerData.vip) or false
end

// VIP Buffs
function meta:getVipInventoryIncrease()
	return self:hasVip() and 50 or 0
end

function meta:getVipBankIncrease()
	return self:hasVip() and 100 or 0
end
