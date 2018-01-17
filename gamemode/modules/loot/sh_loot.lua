
LOOT_STRUCTURE_FACTORY = LOOT_STRUCTURE_FACTORY or {
	[15] = {
		["WEAPONS"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["APPAREL"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["AMMO"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["AID"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["MISC"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		}
	},
	[30] = {
		["WEAPONS"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["APPAREL"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["AMMO"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["AID"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["MISC"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		}
	},
	[50] = {
		["WEAPONS"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["APPAREL"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["AID"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["AMMO"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		},
		["MISC"] = {
			[RARITY_WHITE] = {},
			[RARITY_GREEN] = {},
			[RARITY_BLUE] = {},
			[RARITY_PURPLE] = {},
			[RARITY_ORANGE] = {}
		}
	},
}

LOOT_STRUCTURE = LOOT_STRUCTURE or {
	[15] = {
		[RARITY_WHITE] = {},
		[RARITY_GREEN] = {},
		[RARITY_BLUE] = {},
		[RARITY_PURPLE] = {},
		[RARITY_ORANGE] = {}
	},
	[30] = {
		[RARITY_WHITE] = {},
		[RARITY_GREEN] = {},
		[RARITY_BLUE] = {},
		[RARITY_PURPLE] = {},
		[RARITY_ORANGE] = {}
	},
	[50] = {
		[RARITY_WHITE] = {},
		[RARITY_GREEN] = {},
		[RARITY_BLUE] = {},
		[RARITY_PURPLE] = {},
		[RARITY_ORANGE] = {}
	},
}

function addToLoot(item)
	local id = item:getId()
	local rarity = item:getRarity()
	local level = util.normalizeLevel(item:getLevel())
	local category = item:getCategory()

	// Ammo, Aid, and Misc don't have levels
	if isAmmo(id) or isAid(id) or isMisc(id) then
		if isMisc(id) then
			if !item:isMaterial() or item:getQuest() then return end
		end

		for k,v in pairs(LOOT_STRUCTURE_FACTORY) do
			table.insert(LOOT_STRUCTURE_FACTORY[k][category][rarity], id)
		end
		
		return
	end

	table.insert(LOOT_STRUCTURE_FACTORY[level][category][rarity], id)
	table.insert(LOOT_STRUCTURE[level][rarity], id)
end
