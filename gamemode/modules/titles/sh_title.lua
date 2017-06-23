
local meta = FindMetaTable("Player")

function meta:getTitles()
	return self.titles
end

// Get the title that is equipped
function meta:getTitle()
	return self.title
end
