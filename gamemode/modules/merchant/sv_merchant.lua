
util.AddNetworkString("openMerchant")
util.AddNetworkString("sellItem")
util.AddNetworkString("buyItem")

local meta = FindMetaTable("Player")

function restock(npc, id, index)
	
end

function meta:buyItem(npc, type, id, index, uniqueid, quantity)
	// Create a copy of the item since the actual one will be deleted
	/*
	if 1 == 1 then
		self:notify("This is temporarily disabled, sorry.", NOTIFY_ERROR)
		return
	end
	*/
	
	local item = table.Copy(MERCHANTS[npc]["Sale"][id]["Items"][index])
	
	if item and (item.uniqueid == uniqueid) then
		if self:canAfford(item.price) then
			// Remove player caps
			self:addCaps(-item.price)
			
			// Remove item from npc's stock
			if !item.quantity then
				MERCHANTS[npc]["Sale"][id]["Items"][index] = nil
			elseif (quantity == item.quantity) or (item.quantity == 1) then
				MERCHANTS[npc]["Sale"][id]["Items"][index]["quantity"] = 0 // Make it zero for all predetermined items so it stays in the table
			else
				MERCHANTS[npc]["Sale"][id]["Items"][index]["quantity"] = MERCHANTS[npc]["Sale"][id]["Items"][index]["quantity"] - quantity
			end
			
			// Add stock back to the vendor
			restock(npc, id, index)
			
			// Add item to player inventory
			self:pickUpItem(item, quantity)
			
			// Reopen the npc shop menu
			self:openMerchant(npc)
		else
			// Can't afford this item
			self:notify("You cannot afford this item.", NOTIFY_ERROR)
			self:openMerchant(npc)
		end
	else
		// This item is no longer available
		self:notify("This item is no longer available, refreshing page.", NOTIFY_ERROR)
		self:openMerchant(npc)
	end
end

net.Receive("buyItem", function(len, ply)
	local npc = net.ReadString()
	local type = net.ReadString()
	local id = net.ReadInt(8) // The key of the item type in the MERCHANT table
	local index = net.ReadInt(16)
	local uniqueid = net.ReadInt(32) // To confirm that the item is still available on the server
	local quantity = net.ReadInt(16)
	
	ply:buyItem(npc, type, id, index, uniqueid, quantity)
end)

function meta:sellItem(npc, type, id, uniqueid, quantity)
	// Create a copy of the item since the actual one will be deleted
	local item = table.Copy(self.inventory[type][uniqueid])
	item.quantity = quantity
	item.price = getItemValue(item.classid) * 3

	// Remove item from player
	self:depleteInventoryItem(type, uniqueid, quantity)
	
	// Add item to npc
	table.insert(MERCHANTS[npc]["Sale"][id]["Items"], item)
	
	// Give player caps
	self:addCaps(getItemValue(item.classid) * quantity)
	
	// Reopen the npc shop menu
	self:openMerchant(npc)
end

net.Receive("sellItem", function(len, ply)
	local npc = net.ReadString()
	local type = net.ReadString()
	local id = net.ReadInt(8) // The key of the item type in the MERCHANT table
	local uniqueid = net.ReadInt(32)
	local quantity = net.ReadInt(16)
	
	ply:sellItem(npc, type, id, uniqueid, quantity)
end)

function meta:openMerchant(name)
	net.Start("openMerchant")
		net.WriteString(name)
		net.WriteTable(MERCHANTS[name]["Sale"])
	net.Send(self)
end

// Spawn merchants
function spawnMerchants()
	for name, info in pairs(MERCHANTS) do
		local merchant = ents.Create("merchant")
		merchant:SetPos(info.Position)
		merchant:SetAngles(info.Angles)
		merchant:Spawn()
		merchant:SetNickname(name)
		merchant:SetModel(info.Model)
	end
end

hook.Add("InitPostEntity", "spawnMerchants", function()
	timer.Simple(1, function()
		spawnMerchants()
	end)
	
	// Initalize the merchant's items
	timer.Simple(5, function()
		initializeMerchantItems()
	end)
end)