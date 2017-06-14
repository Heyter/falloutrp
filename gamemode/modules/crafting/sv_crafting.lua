
util.AddNetworkString("openCrafting")
util.AddNetworkString("craftItem")

net.Receive("craftItem", function(len, ply)
	local type = net.ReadInt(8)
	local index = net.ReadInt(16)
	local quantity = net.ReadInt(16)

	ply:craftItem(RECIPES[type][index], quantity)
end)

local meta = FindMetaTable("Player")

function meta:openCrafting()
	net.Start("openCrafting")

	net.Send(self)
end

function meta:hasCraftingMaterials(materials, quantity)
	for material, amount in pairs(materials) do
		local count, uniqueid = self:getInventoryCount(material)
		if count < (amount * quantity) then
			return false
		end
	end

	return true
end

function meta:removeCraftingMaterials(materials, quantity)
	for item, amount in pairs(materials) do
		local count, uniqueid = self:getInventoryCount(item)

		// Remove the item from inventory
		self:depleteInventoryItem(classidToStringType(item), uniqueid, amount * quantity)
	end
end

function meta:craftItem(itemInfo, quantity)
	local itemInfo = table.Copy(itemInfo)

	itemInfo.quantity = itemInfo.quantity or 1
	itemInfo.quantity = itemInfo.quantity * quantity

	print(itemInfo.quantity, quantity)

	if self:hasCraftingLevel(itemInfo.level) then
		if self:hasCraftingMaterials(itemInfo.materials, quantity) then
			if self:canInventoryFit(itemInfo) then
				self:removeCraftingMaterials(itemInfo.materials, quantity)

				// Give the item to the player
				self:pickUpItem(createItem(itemInfo.classid, 1, true), itemInfo.quantity)

				hook.Call("CraftedItem", GAMEMODE, self, itemInfo, itemInfo.quantity)

				net.Start("craftItem")
				net.Send(self)
			else
				self:notify("Insufficient inventory space", NOTIFY_ERROR, 5)
			end
		else
			self:notify("Insufficient materials", NOTIFY_ERROR, 5)
		end
	end
end
