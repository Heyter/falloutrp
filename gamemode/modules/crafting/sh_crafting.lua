
// Recipes
RECIPES = {
	[TYPE_WEAPON] = {

	}
}

function addRecipe(id, level, materials)
	table.insert(RECIPES[tonumber(tostring(id)[1])], {classid = id, level = level, materials = materials})
end

addRecipe(1001, 1, {[5001] = 2, [5002] = 1})
 
