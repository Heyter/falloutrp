
util.AddNetworkString("dropItem")
util.AddNetworkString("equipItem")
util.AddNetworkString("unequipItem")

//Server
local meta = FindMetaTable("Player")

function meta:dropItem(uniqueId, itemType)
	if uniqueId and itemType then
		//Delete from lua
		self.inventory[itemType][uniqueId] = nil
		
		//Update the client
		net.Start("dropItem")
		
		net.Send(self)
		
		//Delete from MySQL
		MySQLite.query("DELETE FROM " ..itemType .." WHERE uniqueid = " ..uniqueId)
		
		//Drop the item on the ground
	end
end

function meta:equipItem(uniqueId, itemType)
	if uniqueId and itemType then
		//Update in lua
		self.inventory[itemType][uniqueId]["equipped"] = true
		
		//Update client
		net.Start("equipItem")
		
		net.Send(self)
		
		//Update MySQL
		MySQLite.query("UPDATE " ..itemType .." SET equipped = 1 WHERE uniqueid = " ..uniqueId)
	end
end

function meta:unequipItem(uniqueId, itemType)
	if uniqueId and itemType then
		//Update in lua
		self.inventory[itemType][uniqueId]["equipped"] = false
		
		//Update client
		net.Start("unequipItem")
		
		net.Send(self)
		
		//Update MySQL
		MySQLite.query("UPDATE " ..itemType .." SET equipped = 0 WHERE uniqueid = " ..uniqueId)
	end
end

net.Receive("dropItem", function(len, ply)
	local itemId = net.ReadInt(8)
	local itemType = net.ReadString()
	
	ply:dropItem(itemId, itemType)
end)

net.Receive("equipItem", function(len, ply)
	local itemId = net.ReadInt(8)
	local itemType = net.ReadString()
	
	ply:equipItem(itemId, itemType)
end)

net.Receive("unequipItem", function(len, ply)
	local itemId = net.ReadInt(8)
	local itemType = net.ReadString()
	
	ply:unequipItem(itemId, itemType)
end)