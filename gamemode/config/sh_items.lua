
// DO NOT TOUCH
TYPE_CAP = 0
TYPE_WEAPON = 1
TYPE_APPAREL = 2
TYPE_AMMO = 3
TYPE_AID = 4
TYPE_MISC = 5

RARITY_WHITE = 0
RARITY_GREEN = 1
RARITY_BLUE = 2
RARITY_PURPLE = 3
RARITY_ORANGE = 4

local rarityColors = {
    [RARITY_WHITE] = COLOR_WHITE,
    [RARITY_GREEN] = COLOR_GREEN,
    [RARITY_BLUE] = COLOR_BLUE,
    [RARITY_PURPLE] = COLOR_PURPLE,
    [RARITY_ORANGE] = COLOR_ORANGE
}

function getRarityColor(rarity)
    return rarityColors[rarity]
end

CRITICAL_MULTIPLIER = 1.5 // How much critical hits are multiplied by
