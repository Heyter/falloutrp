
MERCHANTS = {
	["Billy"] = {
		Position = Vector(-9209, 13197.406250, 11),
		Angles = Angle(0, -70, 0),
		Model = "models/humans/group01/male_04.mdl",
		Sale = {
			[1] = {
				Type = "WEAPONS",
				Items = {},
				ItemsMimic = {
					{time = 300, uniqueid = -1, quantity = 1, price = 3000, classid = 1015},
					{time = 300, uniqueid = -2, quantity = 1, price = 750, classid = 1027},
					{time = 300, uniqueid = -3, quantity = 1, price = 1000, classid = 1044},
					{time = 300, uniqueid = -4, quantity = 1, price = 1200, classid = 1061},
					{time = 300, uniqueid = -5, quantity = 1, price = 1500, classid = 1017},
					{time = 300, uniqueid = -6, quantity = 1, price = 3000, classid = 1062},
					{time = 300, uniqueid = -7, quantity = 1, price = 3250, classid = 1068},
					{time = 300, uniqueid = -8, quantity = 1, price = 4000, classid = 1002},
				},
			},
		},
	},
	["John"] = {
		Position = Vector(-7849, 13046, 9),
		Angles = Angle(0, 175, 0),
		Model = "models/humans/group01/male_04.mdl",
		Sale = {
			[1] = {
				Type = "AID",
				Items = {},
				ItemsMimic = {
					{time = 300, uniqueid = -1, quantity = 10, price = 500, classid = 4001},
					{time = 300, uniqueid = -2, quantity = 5, price = 1500, classid = 4002},
					{time = 300, uniqueid = -3, quantity = 5, price = 1250, classid = 4006},
					{time = 300, uniqueid = -4, quantity = 10, price = 500, classid = 4010},
					{time = 300, uniqueid = -5, quantity = 5, price = 400, classid = 4012},
					{time = 300, uniqueid = -6, quantity = 1, price = 5000, classid = 4003},
				},
			},	
		},
	},
	["Sky"] = {
		Position = Vector(-6580, 12722, 5),
		Angles = Angle(0, -135, 0),
		Model = "models/humans/group01/female_04.mdl",
		Sale = {
			[1] = {
				Type = "APPAREL",
				Items = {},
				ItemsMimic = {
					{time = 300, uniqueid = -1, quantity = 1, price = 4500, classid = 2041},
					{time = 300, uniqueid = -2, quantity = 1, price = 4200, classid = 2042},
					{time = 300, uniqueid = -3, quantity = 1, price = 3900, classid = 2043},
					{time = 300, uniqueid = -4, quantity = 1, price = 3600, classid = 2044},
					{time = 300, uniqueid = -5, quantity = 1, price = 3300, classid = 2045},
				},
			},	
		},
	},
	["Samantha"] = {
		Position = Vector(-8143, 10440, 13),
		Angles = Angle(0, 125, 0),
		Model = "models/humans/group01/female_04.mdl",
		Sale = {
			[1] = {
				Type = "MISC",
				Items = {},
				ItemsMimic = {
					{time = 300, uniqueid = -1, quantity = 10, price = 450, classid = 5014},
					{time = 300, uniqueid = -2, quantity = 30, price = 200, classid = 5045},
					{time = 300, uniqueid = -3, quantity = 5, price = 1000, classid = 5035},
					{time = 300, uniqueid = -4, quantity = 10, price = 750, classid = 5028},
					{time = 300, uniqueid = -5, quantity = 1, price = 2000, classid = 5016},
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