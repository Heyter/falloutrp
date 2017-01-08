
REGISTRATION_POINTS = 21 // How many points you have to use for SPECIAL when you first register a character

SPECIAL = {
	{Name = "Strength", Description = "Strength increases your total amount of hitpoints\nand also increases the total amount your inventory can hold."},
	{Name = "Perception", Description = "Perception reduces the amount of recoil form weapons\nand also increases critical hit damage."},
	{Name = "Endurance", Description = "Endurance increases the amount of time you can sprint for\n and also increases your health regeneration."},
	{Name = "Charisma", Description = "Charisma reduces the buying price from vendors\nand also increases the selling price to vendors."},
	{Name = "Intelligence", Description = "Intelligence increases the healing effects of first aid\and also increases the effects of food and drinks."},
	{Name = "Agility", Description = "Agility increase the critical hit chance of weapons\and also increases player's movement speed."},
	{Name = "Luck", Description = "Luck gives the player good fortune and increases the chance to get better loot."}
}

NAME_MIN = 4 // Min characters that a name can be
NAME_MAX = 30 // Max characters that a name can be (WARNING: Must change this in SQL if you want to increase)
NAME_INVALID = {"!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", "-", "=", "~", "`", "{", "}", "|", ":", "<", ">", "?", ",", ".", "/", ";", "[", "]"} // Characters not allowed in a players name