
MERCHANTS = {
	["Billy"] = {
		Position = Vector(-9209, 13197.406250, 11),
		Angles = Angle(0, 0, 0),
		Sale = {
			[1] = {
				Type = "WEAPONS",
				Items = {},
				ItemsMimic = {
					{uniqueid = -1, quantity = 1, price = 100, classid = 1001}
				}
			}
		},
	},
	["John"] = {
		Position = Vector(-7849, 13046, 9),
		Angles = Angle(0, 0, 0),
		Sale = {
			[1] = {
				Type = "AID",
				Items = {},
				ItemsMimic = {
					{uniqueid = -1, quantity = 1, price = 100, classid = 4001}
				}
			},	
		},
	},
	["Sky"] = {
		Position = Vector(-6580, 12722, 5),
		Angles = Angle(0, 0, 0),
		Sale = {
			[1] = {
				Type = "APPAREL",
				Items = {},
				ItemsMimic = {
					{uniqueid = -1, quantity = 1, price = 100, classid = 2001}
				}
			},	
		},
	},
	["Samantha"] = {
		Position = Vector(-8143, 10440, 13),
		Angles = Angle(0, 0, 0),
		Sale = {
			[1] = {
				Type = "MISC",
				Items = {},
				ItemsMimic = {
					{uniqueid = -1, quantity = 1, price = 100, classid = 5001}
				},
			},
		},
	},
}

function initializeMerchantItems()
	for merchant, info in pairs(MERCHANTS) do
		for k, itemInfo in pairs(info.Sale) do
			for a, item in pairs(itemInfo.ItemsMimic) do
				local newItem = createItem(item.classid, item.quantity)
				newItem.uniqueid = item.uniqueid
				newItem.price = item.price
				
				table.insert(MERCHANTS[merchant]["Sale"][k]["Items"], newItem)
			end
		end
	end
end