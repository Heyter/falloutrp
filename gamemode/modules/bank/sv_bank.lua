
util.AddNetworkString("loadBank")

local meta = FindMetaTable("Player")

function meta:loadBankCount()
	self.loadBankedCount = self.loadBankedCount + 1
	
	if self.loadBankedCount == 5 then // weapons, apparel, aid, misc, and ammo were all loaded
		self:sendBank()
	end
end

// Get data from all item tables for specific player
function meta:loadBank()
	self.loadBankedCount = 0
	
	self.bank = {
		weapons = {},
		apparel = {},
		aid = {},
		misc = {},
		ammo = {}
	}
	
	self:loadBankWeapons()
	self:loadBankApparel()
	self:loadBankAid()
	self:loadBankMisc()
	self:loadBankAmmo()
end

// Run this in the last query you run when loading the bank
function meta:sendBank()
	net.Start("loadBank")
		net.WriteTable(self.bank)
	net.Send(self)
end

function meta:loadBankWeapons()
	MySQLite.query("SELECT * FROM weapons WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k, v in pairs(results) do
				self.bank["weapons"][v.uniqueid] = {
					classid = v.classid,
					damage = v.damage,
					durability = v.durability,
					uniqueid = v.uniqueid
				}
			end
		end
		
		self:loadBankCount()
	end)	
end

function meta:loadBankApparel()
	MySQLite.query("SELECT * FROM apparel WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k, v in pairs(results) do
				self.bank["apparel"][v.uniqueid] = {
					classid = v.classid,
					damageThreshold = v.damageThreshold,
					damageReflection = v.damageReflection,
					bonusHp = v.bonusHp,
					durability = v.durability,
					equipped = tobool(v.equipped),
					uniqueid = v.uniqueid
				}
			end
		end
	
		self:loadBankCount()
	end)	
end

function meta:loadBankAid()
	// Get aid
	MySQLite.query("SELECT * FROM aid WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k,v in pairs(results) do
				self.inventory["aid"][v.uniqueid] = {
					classid = v.classid,
					uniqueid = v.uniqueid,
					quantity = v.quantity
				}
			end
		end
		
		self:loadBankCount()
	end)	
end

function meta:loadBankAmmo()
	// Get ammo
	MySQLite.query("SELECT * FROM ammo WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k,v in pairs(results) do
				self.bank["ammo"][v.uniqueid] = {
					classid = v.classid,
					uniqueid = v.uniqueid,
					quantity = v.quantity
				}
			end
		end
		
		self:loadBankCount()
	end)	
end

function meta:loadBankMisc()
	// Get misc
	MySQLite.query("SELECT * FROM misc WHERE steamid = '" ..self:SteamID() .."' AND banked = 1", function(results)
		if results then
			for k,v in pairs(results) do
				self.bank["misc"][v.uniqueid] = {
					classid = v.classid,
					uniqueid = v.uniqueid,
					quantity = v.quantity
				}
			end
		end
		
		self:loadBankCount()
	end)	
end