
REGISTRATION_POINTS = 21 // How many points you have to use for SPECIAL when you first register a character

SPECIAL = {
	{Name = "Strength", Description = "Strength increases your total amount of hitpoints\nand also increases the total amount your inventory can hold."},
	{Name = "Perception", Description = "Perception reduces the amount of recoil form weapons\nand also increases critical hit damage."},
	{Name = "Endurance", Description = "Endurance increases the amount of time you can sprint for\n and also increases your health regeneration."},
	{Name = "Charisma", Description = "Charisma reduces the buying price from vendors\nand also increases the selling price to vendors."},
	{Name = "Intelligence", Description = "Intelligence increases the healing effects of first aid\n and also increases the effects of food and drinks."},
	{Name = "Agility", Description = "Agility increase the critical hit chance of weapons\n and also increases player's movement speed."},
	{Name = "Luck", Description = "Luck gives the player good fortune and\n increases the chance to get better loot."}
}

NAME_MIN = 3 // Min characters that a name can be
NAME_MAX = 30 // Max characters that a name can be (WARNING: Must change this in SQL if you want to increase)
NAME_INVALID = {"!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", "-", "=", "~", "`", "{", "}", "|", ":", "<", ">", "?", ",", ".", "/", ";", "[", "]"} // Characters not allowed in a players name

// Strength
HEALTH_PER_STRENGTH = 5 // How much extra health each point of strength gives you
INVENTORY_PER_STRENGTH = 10 // How much extra inventory space each point of strength gives you

// Perception
RECOIL_PER_PERCEPTION = 0.03 // How much recoil is reduced for each point of perception
CRITICALHITDAMAGE_MULTIPLIER_PERCEPTION = 0.05 // How much critical hit damage is increased (multiplier) by for each point of perception

// Endurance
SPRINT_AMOUNT_ENDURANCE = 5 // How many extra sprint points you get for each endurance point
HEALTHREGEN_MULTIPLIER_ENDURANCE = 0.03 // How much health regen time is reduced (multiplier) for each endurance point

// Charisma
PRICE_MULTIPLIER_CHARISMA = 0.05 // How much buying/selling price is reduced/increased (multiplier) for each point of charisma


// Intelligence
RESTORE_EFFECTS_INTELLIGENCE = 0.03 // How much health, hunger, thirst is restored (multiplier) by for each point of intelligence

// Agility
CRITICALHITCHANCE_MULTIPLIER_AGILITY = 0.03 // How much critical hit chance is increased (multiplier) by for each point of agility
MOVEMENT_SPEED_AGILITY = 2 // How much movement speed is increased by for each point of agility

// Luck

