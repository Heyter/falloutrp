
local meta = FindMetaTable("Player")

function meta:getTitleCreations()
	return self.playerData.titlecreations or 0
end

function meta:getTitles()
	return self.titles
end

// Get the title that is equipped
function meta:getTitle()
	return self.title
end