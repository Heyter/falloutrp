
local meta = FindMetaTable("Player")

function meta:hasCraftingLevel(level)
	return self:getLevel() >= level
end


// Recipes
RECIPES = {
	[TYPE_WEAPON] = {

	},
	[TYPE_APPAREL] = {

	},
	[TYPE_AMMO] = {

	},
	[TYPE_AID] = {

	},
	[TYPE_MISC] = {

	}
}

function addRecipe(id, level, quantity, materials)
	table.insert(RECIPES[tonumber(tostring(id)[1])], {classid = id, level = level, quantity = quantity, materials = materials})
end


//WEAPONS

addRecipe(1001, 24, 1,  {[5028] = 15, [5014] = 15, [5029] = 20, [5035] = 1})
addRecipe(1002, 32, 1,  {[5028] = 20, [5034] = 15, [5029] = 40, [5035] = 2})
addRecipe(1003, 36, 1,  {[5028] = 25, [5034] = 25, [5029] = 45, [5035] = 2})
addRecipe(1004, 42, 1,  {[5028] = 30, [5034] = 30, [5029] = 65, [5035] = 3})
addRecipe(1005, 47, 1,  {[5028] = 30, [5034] = 25, [5033] = 20, [5030] = 35})
addRecipe(1006, 7, 1,  {[5028] = 2, [5014] = 2, [5033] = 3, [5030] = 1})
addRecipe(1007, 45, 1,  {[5028] = 30, [5034] = 25, [5033] = 25, [5030] = 30})
addRecipe(1008, 23, 1,  {[5028] = 10, [5014] = 10, [5033] = 3, [5030] = 11})
addRecipe(1009, 39, 1,  {[5034] = 25, [5014] = 50, [5033] = 3, [5030] = 15})
addRecipe(1010, 50, 1,  {[5028] = 15, [5034] = 20, [5033] = 15, [5030] = 40})
addRecipe(1011, 19, 1,  {[5014] = 15, [5034] = 5, [5033] = 15, [5030] = 5})
addRecipe(1012, 41, 1,  {[5028] = 10, [5034] = 20, [5033] = 20, [5030] = 30})
addRecipe(1015, 15, 1,  {[5028] = 5, [5014] = 10, [5033] = 15, [5029] =2 })
addRecipe(1016, 15, 1,  {[5028] = 10, [5014] = 5, [5033] = 2, [5030] = 5})
addRecipe(1018, 31, 1,  {[5028] = 10, [5034] = 20, [5033] = 10, [5030] = 15})
addRecipe(1019, 27, 1,  {[5028] = 5, [5034] = 15, [5033] = 10, [5030] = 12})
addRecipe(1021, 25, 1,  {[5028] = 20, [5033] = 150})
addRecipe(1022, 5, 1,  {[5028] = 3, [5014] = 3, [5033] = 3})
addRecipe(1023, 1, 1,   {[5014] = 3})
addRecipe(1024, 29, 1,   {[5033] =150 , [5014] = 20, [5034] = 10})
addRecipe(1025, 13, 1,   {[5033] =10 , [5014] = 25, [5034] = 5})
addRecipe(1026, 21, 1,   {[5033] =10 , [5014] = 30, [5034] = 15})
addRecipe(1027, 3, 1,   {[5033] =2 , [5014] = 3})
addRecipe(1029, 17, 1,   {[5033] =10 , [5014] = 20, [5034] = 10})
addRecipe(1031, 50, 1,  {[1030] = 1, [5034] = 10, [5030] = 5})
addRecipe(1032, 9, 1,  {[5014] = 15, [5033] = 5})
addRecipe(1033, 18, 1,  {[5040] = 1, [5031] = 10, [5030] = 10, [5014] = 5})
addRecipe(1034, 40, 1,  {[5040] = 2, [5031] = 20, [5030] = 15, [5034] = 10})
addRecipe(1035, 10, 1,  {[5040] = 1, [5031] = 1, [5030] = 4})
addRecipe(1036, 34, 1,  {[5040] = 2, [5031] = 20, [5030] = 10, [5034] = 20})
addRecipe(1037, 22, 1,  {[5040] = 1, [5031] = 10, [5030] = 10, [5014] = 10})
addRecipe(1038, 26, 1,  {[5040] = 2, [5031] = 15, [5030] = 3, [5034] = 15})
addRecipe(1039, 50, 1,  {[5040] = 3, [5032] = 15, [5031] = 15, [5034] = 15})
addRecipe(1040, 30, 1,  {[5040] = 2, [5032] = 5, [5031] = 10, [5034] = 10})
addRecipe(1041, 14, 1,  {[5040] = 1, [5031] = 5, [5014] = 10})
addRecipe(1042, 45, 1,  {[5040] = 3, [5032] = 10, [5031] = 15, [5034] = 15})
addRecipe(1043, 40, 1,  {[5031] = 10, [5030] = 5, [5034] = 20, [5035] = 5})
addRecipe(1045, 28, 1,  {[5028] = 15, [5029] = 25, [5034] = 15, [5035] = 2})
addRecipe(1046, 38, 1,  {[1045] = 1, [5029] = 15, [5034] = 10})
addRecipe(1047, 22, 1,  {[5028] = 40, [5014] = 20, [5029] = 10, [5035] = 1})
addRecipe(1048, 10, 1,  {[5028] = 2, [5014] = 2, [5035] = 1})
addRecipe(1049, 24, 1,  {[1048] = 1, [5029] = 15, [5014] = 20, [5028] = 20})
addRecipe(1050, 4, 1,  {[5028] = 1, [5014] = 1, [5035] = 1})
addRecipe(1051, 12, 1,  {[5028] = 2, [5029] = 2, [5014] = 2, [5035] = 1})
addRecipe(1052, 8, 1,  {[1050] = 1, [5014] = 2, [5032] = 2})
addRecipe(1053, 40, 1,  {[5028] = 20, [5029] = 50, [5034] = 30, [5035] = 3})
addRecipe(1054, 26, 1,  {[5028] = 30, [5034] = 25, [5029] = 15})
addRecipe(1055, 46, 1,  {[5035] = 3, [5034] = 30, [5029] = 50, [5030] = 15})
addRecipe(1056, 2, 1,  {[5035] = 1, [5014] = 3})
addRecipe(1057, 16, 1,  {[5028] = 10, [5029] = 5, [5014] = 7, [5035] = 1})
addRecipe(1058, 26, 1,  {[1057] = 1, [5034] = 40, [5028] = 30, [5029] = 30})
addRecipe(1059, 28, 1,  {[5028] = 20, [5034] = 10, [5029] = 30, [5035] = 2})
addRecipe(1060, 34, 1,  {[5028] = 15, [5034] = 40, [5029] = 25, [5035] = 2})
addRecipe(1062, 48, 1,  {[5029] = 20, [5030] = 40, [5034] = 20, [5035] = 3})
addRecipe(1063, 20, 1,  {[5028] = 30, [5029] = 10, [5014] = 5, [5035] = 2})
addRecipe(1064, 30, 1,  {[1063] = 1, [5034] = 10, [5029] = 10, [5035] = 2})
addRecipe(1065, 50, 1,  {[5029] = 50, [5030] = 40, [5034] = 30, [5035] = 4})
addRecipe(1066, 32, 1,  {[5028] = 20, [5029] = 40, [5034] = 10, [5035] = 2})
addRecipe(1067, 18, 1,  {[5029] = 20, [5028] = 50, [5014] = 5, [5035] = 1})
addRecipe(1068, 14, 1,  {[5029] = 4, [5014] = 10, [5035] = 1})
addRecipe(1069, 22, 1,  {[5028] = 20, [5029] = 10, [5034] = 20, [5035] = 1})
addRecipe(1071, 15, 1,  {[5029] = 10, [5014] = 20})
addRecipe(1072, 49, 1,  {[5041] = 20, [5014] = 10, [5032] = 2, [5030] = 2})
addRecipe(1073, 30, 1,  {[5029] = 10, [5028] = 20, [5034] = 5})



addRecipe(1074, 2, 1,  {[5014] = 1, [5028] = 2}) // Lockpick
addRecipe(1075, 1, 1,  {[5014] = 1, [5033] = 1}) // Pickaxe



//ARMOUR

// Green Rags (New Recipe)
addRecipe(2018, 1, 1,  {[5044] = 40})
addRecipe(2030, 1, 1,  {[5044] = 30})
addRecipe(2003, 1, 1,  {[5044] = 25})
addRecipe(2073, 1, 1,  {[5044] = 20})
addRecipe(2086, 1, 1,  {[5044] = 20})

// Construction Set (New Recipe)
addRecipe(2016, 10, 1,  {[5042] = 45})
addRecipe(2028, 10, 1,  {[5042] = 40})
addRecipe(2001, 10, 1,  {[5042] = 35})
addRecipe(2071, 10, 1,  {[5042] = 30})
addRecipe(2084, 10, 1,  {[5042] = 30})

// Sturdy Armor
addRecipe(2051, 16, 1,  {[5028] = 40, [5014] = 15})
addRecipe(2052, 16, 1,  {[5028] = 36, [5014] = 13})
addRecipe(2053, 16, 1,  {[5028] = 32, [5014] = 11})
addRecipe(2054, 16, 1,  {[5028] = 30, [5014] = 9})
addRecipe(2055, 16, 1,  {[5028] = 30, [5014] = 9})

// Reinforced Leather
addRecipe(2046, 22, 1,  {[5043] = 30, [5014] = 15})
addRecipe(2047, 22, 1,  {[5043] = 27, [5014] = 13})
addRecipe(2048, 22, 1,  {[5043] = 25, [5014] = 12})
addRecipe(2049, 22, 1,  {[5043] = 23, [5014] = 10})
addRecipe(2050, 22, 1,  {[5043] = 23, [5014] = 10})

// Medium Armor
addRecipe(2056, 25, 1,  {[5029] = 20, [5014] = 15})
addRecipe(2057, 25, 1,  {[5029] = 18, [5014] = 12})
addRecipe(2058, 25, 1,  {[5029] = 16, [5014] = 10})
addRecipe(2059, 25, 1,  {[5029] = 14, [5014] = 8})
addRecipe(2060, 25, 1,  {[5029] = 14, [5014] = 8})

// Rusty Metal Armor (New Recipe)
addRecipe(2019, 31, 1,  {[5029] = 30, [5034] = 10})
addRecipe(2031, 31, 1,  {[5029] = 26, [5034] = 8})
addRecipe(2004, 31, 1,  {[5029] = 24, [5034] = 6})
addRecipe(2074, 31, 1,  {[5029] = 22, [5034] = 4})
addRecipe(2087, 31, 1,  {[5029] = 22, [5034] = 4})




// Security Armor (New Recipe)
addRecipe(2023, 37, 1,  {[5042] = 30, [5034] = 20, [5043] = 30})
addRecipe(2036, 37, 1,  {[5042] = 25, [5034] = 18, [5043] = 25})
addRecipe(2009, 37, 1,  {[5042] = 23, [5034] = 16, [5043] = 23})
addRecipe(2078, 37, 1,  {[5042] = 22, [5034] = 15, [5043] = 22})
addRecipe(2091, 37, 1,  {[5042] = 22, [5034] = 15, [5043] = 22})

// Heavy Armor
addRecipe(2061, 46, 1,  {[5014] = 30, [5030] = 15, [5034] = 20})
addRecipe(2062, 46, 1,  {[5014] = 25, [5030] = 13, [5034] =18})
addRecipe(2063, 46, 1,  {[5014] = 22, [5030] = 12, [5034] = 16})
addRecipe(2064, 46, 1,  {[5014] = 19, [5030] = 11, [5034] = 14})
addRecipe(2065, 46, 1,  {[5014] = 19, [5030] = 11, [5034] = 14})

// Power Armor
addRecipe(2066, 50, 1,  {[5032] = 8, [5034] = 15, [5014] = 30})
addRecipe(2067, 50, 1,  {[5032] = 7, [5034] = 14, [5014] = 25})
addRecipe(2068, 50, 1,  {[5032] = 6, [5034] = 13, [5014] = 23})
addRecipe(2069, 50, 1,  {[5032] = 5, [5034] = 12, [5014] = 22})
addRecipe(2070, 50, 1,  {[5032] = 5, [5034] = 12, [5014] = 22})


//AMMO

addRecipe(3001, 2, 30,  {[5014] = 1})
addRecipe(3002, 16, 40,  {[5014] = 2})
addRecipe(3004, 26, 40,  {[5014] = 3})
addRecipe(3005, 38, 40,  {[5014] = 3})
addRecipe(3006, 12, 40,  {[5014] = 2})
addRecipe(3007, 46, 50,  {[5014] = 4})
addRecipe(3008, 50, 40,  {[5034] = 3})
addRecipe(3009, 8, 30,  {[5014] = 1})
addRecipe(3010, 20, 40,  {[5034] = 1})
addRecipe(3011, 22, 50,  {[5014] = 3})
addRecipe(3012, 48, 50,  {[5034] = 2})
addRecipe(3015, 32, 40,  {[5014] = 2})
addRecipe(3016, 24, 30,  {[5014] = 1})
addRecipe(3017, 4, 30,  {[5014] = 1})
addRecipe(3020, 37, 300,  {[5032] = 1})
addRecipe(3021, 18, 90,  {[5039] = 1})
addRecipe(3023, 25, 90,  {[5040] = 1})
addRecipe(3026, 34, 50,  {[5034] = 2})



//AID
addRecipe(4001, 1, 1, {[5046] = 4, [5035] = 1})


//MISC

addRecipe(5034, 1, 1,  {[5014] = 10})
addRecipe(5035, 1, 1,  {[5029] = 2, [5014] = 2})
addRecipe(5043, 1, 1,  {[5042] = 3})
addRecipe(5044, 1, 2,  {[5045] = 3})
addRecipe(5040, 1, 2,  {[5036] = 2})
