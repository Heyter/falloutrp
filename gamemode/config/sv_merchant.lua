
MERCHANTS = {
	["John Doyle"] = {
		Position = Vector(-10343, 11293, 8),
		Angles = Angle(0, 0, 0),
		Sale = {
			[1] = {
				Type = "WEAPONS",
				Items = {},
				ItemsMimic = {
					{uniqueid = -1, quantity = 1, price = 100, classid = 1001}
				}
			},
			[2] = {
				Type = "APPAREL",
				Items = {},
				ItemsMimic = {
					{uniqueid = -2, quantity = 1, price = 100, classid = 2001}
				}
			},
			[3] = {
				Type = "AMMO",
				Items = {},
				ItemsMimic = {
					{uniqueid = -3, quantity = 1, price = 100, classid = 3001}
				}
			},
			[4] = {
				Type = "AID",
				Items = {},
				ItemsMimic = {
					{uniqueid = -4, quantity = 1, price = 100, classid = 4001}
				}
			},
			[5] = {
				Type = "MISC",
				Items = {},
				ItemsMimic = {
					{uniqueid = -5, quantity = 1, price = 100, classid = 5001}
				}
			}
		}
	}
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