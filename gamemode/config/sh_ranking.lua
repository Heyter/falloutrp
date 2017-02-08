
local RANKS = {
	[TEAM_BOS] = {
		[0] = "Initiate",
		[10] = "Senior Initiate",
		[30] = "Squire",
		[75] = "Senior Squire",
		[150] = "Junior Knight",
		[350] = "Knight",
		[500] = "Senior Knight",
		[800] = "Knight Commander",
		[1250] = "Junior Paladin",
		[1750] = "Paladin",
		[2500] = "Paladin Commander", 
		[3500] = "Paladin Lord",
		[5000] = "Elder",

	},
	[TEAM_LEGION] = {
		[0] = "Recruit Legionary",
		[10] = "Prime Legionary",	
		[30] = "Veteran Legionary",
		[75] = "Recruit Decanus",
		[150] = "Prime Decanus",
		[350] = "Centurion",
		[500] = "Legate",
		[800] = "Legionary Scout",
		[1250] = "Legionary Explorer",
		[1750] = "Legionary Assassin",
		[2500] = "Legionary Instructor",
		[3500] = "Frumentarii",
		[5000] = "Caesar",

	},
	[TEAM_NCR] = {
		[0] = "Private",
		[10] = "Specialist",	
		[30] = "Corporal",
		[75] = "Sergeant",
		[150] = "Sergeant First Class",
		[350] = "Warrent Officer",
		[500] = "Lieutenant",
		[800] = "Captain",
		[1250] = "Major",
		[1750] = "Lieutenant Colonel",
		[2500] = "Colonel",
		[3500] = "Brigadier General",
		[5000] = "General",
	}
}

function getRanks()
	return RANKS
end