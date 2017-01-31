
// Server

// Disable prop spawn
function GM:PlayerSpawnProp(ply)
	return ply:isAdmin()
end

// Disable tool gun
function GM:CanTool(ply)
	return ply:isAdmin()
end

// Disable give weapons
function GM:PlayerGiveSWEP(ply)
	return ply:isAdmin()
end

// Disable spawn weapons
function GM:PlayerSpawnSWEP(ply)
	return ply:isAdmin()
end

// Disable spawn npc
function GM:PlayerSpawnNPC(ply)
	return ply:isAdmin()
end

// Disable spawn vehicle
function GM:PlayerSpawnVehicle(ply)
	return ply:isAdmin()
end

// Disable spawn effect
function GM:PlayerSpawnEffect(ply)
	return ply:isAdmin()
end

// Disable spawn sent
function GM:PlayerSpawnSENT(ply)
	return ply:isAdmin()
end