
// Recipes
RECIPES = {
	[TYPE_WEAPON] = {

	}
}

function addRecipe(id, level, materials)
	table.insert(RECIPES[tonumber(tostring(id)[1])], {classid = id, level = level, materials = materials})
end

addRecipe(1001, 1, {[5028] = 2, [5014] = 1})
addRecipe(1004, 1, {[5014] = 2, [5002] = 1})
addRecipe(1005, 1, {[5014] = 2, [5002] = 1})
 
