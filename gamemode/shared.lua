GM.Name = "Fallout Roleplay"
GM.Author = "Gaming_Unlimited"

DeriveGamemode("sandbox")

strRootPath = string.Replace(GM.Folder, "gamemodes/", "")
function searchPaths(originalPath, initial)
	initial = initial or false
	originalPath = originalPath .. "/"
	local files, directories = file.Find(originalPath .. "*", "LUA")

	if !initial then
		for _, strPath in pairs(files) do
			local prefix = string.sub(strPath, 1, 3)
			local correctedPath = string.gsub(originalPath .. strPath, strRootPath .. "/".. "gamemode/", "")

			if string.find(strPath, "sv_") then
				if SERVER then
					include(correctedPath)
				end
			elseif string.find(strPath, "cl_") then
				if SERVER then
					AddCSLuaFile(correctedPath)
				else
					include(correctedPath)
				end
			else
				if SERVER then
					AddCSLuaFile(correctedPath)					
					include(correctedPath)
				else
					include(correctedPath)		
				end
			end
		end
	end

	for _, strPath in pairs(directories) do
		searchPaths(originalPath .. strPath)
	end
end
searchPaths(strRootPath .. "/".. "gamemode/config", false)
searchPaths(strRootPath .. "/".. "gamemode/libraries", false)
searchPaths(strRootPath .. "/".. "gamemode/modules", false)