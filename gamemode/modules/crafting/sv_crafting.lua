
util.AddNetworkString("openCrafting")
util.AddNetworkString("craftItem")

local meta = FindMetaTable("Player")

function meta:openCrafting()
	net.Start("openCrafting")

	net.Send(self)
end

function meta:hasCraftingMaterials(materials)
	for material, amount in pairs(materials) do
		local count, uniqueid = self:getInventoryCount(material)
		if count < amount then
			return false
		end
	end

	return true
end

function meta:removeCraftingMaterials(materials)
	for item, amount in pairs(materials) do
		local count, uniqueid = self:getInventoryCount(item)

		// Remove the item from inventory
		self:depleteInventoryItem(classidToStringType(item), uniqueid, amount)
	end
end

function meta:craftItem(itemInfo)
	if self:hasCraftingLevel(itemInfo.level) then
		if self:hasCraftingMaterials(itemInfo.materials) then
			if self:canInventoryFit(itemInfo) then
				local quantity = itemInfo.quantity or 1
				self:removeCraftingMaterials(itemInfo.materials)

				// Give the item to the player
				self:pickUpItem(createItem(itemInfo.classid, 1, true), quantity)

				hook.Call("CraftedItem", GAMEMODE, self, itemInfo, quantity)

				net.Start("craftItem")
				net.Send(self)
			end
		end
	end
end

net.Receive("craftItem", function(len, ply)
	local type = net.ReadInt(8)
	local index = net.ReadInt(16)

	ply:craftItem(RECIPES[type][index])
end)
