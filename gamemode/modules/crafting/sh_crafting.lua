
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
addRecipe(1023, 1, 1, {[5035] = 1})
addRecipe(1056, 1, 1, {[5035] = 1, [5014] = 1})
addRecipe(1001, 2, 1, {[5035] = 1, [5014] = 3})
addRecipe(1027, 3, 1, {[5033] = 3})
addRecipe(1044, 6, 1, {[5035] = 1, [5014] = 1})
addRecipe(1032, 9, 1, {[5014] = 4})
addRecipe(1070, 10, 1, {[5035] = 2, [5014] = 1})


addRecipe(1074, 1, 1,  {[5014] = 1}) // Lockpick
addRecipe(1075, 1, 1,  {[5014] = 1, [5033] = 1}) // Pickaxe



//ARMOUR
addRecipe(2018, 1, 1,  {[5044] = 40})
addRecipe(2030, 1, 1,  {[5044] = 30})
addRecipe(2003, 1, 1,  {[5044] = 25})
addRecipe(2073, 1, 1,  {[5044] = 20})
addRecipe(2086, 1, 1,  {[5044] = 20})

addRecipe(2016, 10, 1,  {[5042] = 45})
addRecipe(2028, 10, 1,  {[5042] = 40})
addRecipe(2001, 10, 1,  {[5042] = 35})
addRecipe(2071, 10, 1,  {[5042] = 30})
addRecipe(2084, 10, 1,  {[5042] = 30})

addRecipe(2041, 31, 1,  {[5029] = 30, [5034] = 10})
addRecipe(2042, 31, 1,  {[5029] = 26, [5034] = 8})
addRecipe(2043, 31, 1,  {[5029] = 24, [5034] = 6})
addRecipe(2044, 31, 1,  {[5029] = 22, [5034] = 4})
addRecipe(2045, 31, 1,  {[5029] = 22, [5034] = 4})

//AMMO
addRecipe(3001, 1, 40,  {[5014] = 1})
addRecipe(3002, 1, 40,  {[5040] = 1})
addRecipe(3003, 1, 40,  {[5039] = 1})

//AID
addRecipe(4001, 1, 1, {[5046] = 4, [5035] = 1})

//MISC
addRecipe(5034, 1, 1,  {[5014] = 10})
addRecipe(5035, 1, 1,  {[5029] = 1, [5014] = 1})
addRecipe(5043, 1, 1,  {[5042] = 3})
addRecipe(5044, 1, 2,  {[5045] = 3})
addRecipe(5040, 1, 2,  {[5036] = 2})
addRecipe(5065, 16, 1,  {[5056] = 1, [5037] = 8, [5038] = 2, [5040] = 10, [5032] = 5}) // Quest 8
addRecipe(5037, 10, 1, {[5031] = 2, [5014] = 4})
addRecipe(5075, 5, 1, {[5044] = 5, [5042] = 15}) // Quest 22
