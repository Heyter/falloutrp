
MERCHANTS = MERCHANTS or {
	["Billy"] = {
		Position = Vector(-10721, 3450, 128),
		Angles = Angle(0, 320, 0),
		Model = "models/ncr/ncr_04.mdl",
		Sale = {
			[1] = {
				Type = "WEAPONS",
				Items = {},
				ItemsMimic = {
					{time = 300, uniqueid = -1, quantity = 1, price = 200, classid = 1023}, // (Lead Pipe)
					{time = 300, uniqueid = -2, quantity = 1, price = 550, classid = 1050}, // (9mm Pistol)
					{time = 300, uniqueid = -3, quantity = 1, price = 700, classid = 1006}, // (Bumper Sword)
					{time = 300, uniqueid = -4, quantity = 1, price = 3000, classid = 1035}, // (Laser Pistol)
				},
			},
		},
	},
	["John"] = {
		Position = Vector(-11103, 1383, 127),
		Angles = Angle(0, 50, 0),
		Model = "models/ncr/rangercombatarmor.mdl",
		Sale = {
			[1] = {
				Type = "AID",
				Items = {},
				ItemsMimic = {
					{time = 300, uniqueid = -1, quantity = 10, price = 400, classid = 4001},
					{time = 300, uniqueid = -2, quantity = 5, price = 1200, classid = 4002},
					{time = 300, uniqueid = -3, quantity = 5, price = 120, classid = 4006},
					{time = 300, uniqueid = -4, quantity = 10, price = 90, classid = 4010},
					{time = 300, uniqueid = -5, quantity = 5, price = 40, classid = 4012},
					{time = 300, uniqueid = -6, quantity = 1, price = 10000, classid = 4003},
				},
			},
		},
	},
	["Sky"] = {
		Position = Vector(-9980, 3037, 127),
		Angles = Angle(0, 140, 0),
		Model = "models/cl/military/legionrecruit.mdl",
		Sale = {
			[1] = {
				Type = "APPAREL",
				Items = {},
				ItemsMimic = {
					{time = 180, uniqueid = -1, quantity = 1, price = 1000, classid = 2003},
					{time = 180, uniqueid = -2, quantity = 1, price = 1200, classid = 2018},
					{time = 180, uniqueid = -3, quantity = 1, price = 900, classid = 2030},
					{time = 180, uniqueid = -4, quantity = 1, price = 700, classid = 2073},
					{time = 180, uniqueid = -5, quantity = 1, price = 700, classid = 2086},
				},
			},
		},
	},
	["Samantha"] = {
		Position = Vector(-11136, 2195, 130),
		Angles = Angle(0, -23, 0),
		Model = "models/humans/group03/female_07.mdl",
		Sale = {
			[1] = {
				Type = "MISC",
				Items = {},
				ItemsMimic = {
					{time = 300, uniqueid = -1, quantity = 10, price = 200, classid = 5014}, // (Scrap Metal)
					{time = 300, uniqueid = -2, quantity = 30, price = 30, classid = 5045}, // (Cotton)
					{time = 300, uniqueid = -3, quantity = 5, price = 500, classid = 5035}, // (Pipe)
					{time = 300, uniqueid = -4, quantity = 10, price = 80, classid = 5028}, // (Rock)
					{time = 300, uniqueid = -5, quantity = 1, price = 999999, classid = 5016}, // (Mr.FuzzyPants)
				},
			},
		},
	},
}


local function restock(merchant, typeId, itemId, respawnTime)
	timer.Simple(respawnTime, function()
		if MERCHANTS[merchant]["Sale"][typeId]["Items"][itemId]["quantity"] < 1 then
			MERCHANTS[merchant]["Sale"][typeId]["Items"][itemId]["quantity"] = MERCHANTS[merchant]["Sale"][typeId]["Items"][itemId]["quantity"] + 1
		end
		restock(merchant, typeId, itemId, respawnTime)
	end)
end

function initializeMerchantItems()
	for merchant, info in pairs(MERCHANTS) do
		for k, itemInfo in pairs(info.Sale) do
			for a, item in ipairs(itemInfo.ItemsMimic) do
				local newItem = createItem(item.classid, item.quantity, true)
				newItem.uniqueid = item.uniqueid
				newItem.price = item.price
				newItem.quantity = item.quantity

				table.insert(MERCHANTS[merchant]["Sale"][k]["Items"], newItem)

				restock(merchant, k, a, item.time)
			end
		end
	end
end
