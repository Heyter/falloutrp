util.AddNetworkString("loadVehicles")
util.AddNetworkString("spawnVehicle")

net.Receive("spawnVehicle", function(len, ply)
    local vehicle = net.ReadString()

    ply:spawnVehicle(vehicle)
end)

function VEHICLES:getData(name)
    return self.types[name]
end

local meta = FindMetaTable("Player")

function meta:spawnVehicle(name)
    if !self.vehicles[name].owned then
        local active = self.activeVehicle

        if active then
            active:Remove()
            self.activeVehicle = nil
        end

        local data = VEHICLES:getData(name)

        local car = ents.Create(data.class)
        car:SetModel(data.model)
        car:SetKeyValue("vehiclescript", data.script)
        car:SetPos(self:GetPos())
        car:Spawn()
    end
end

function meta:updateVehiclesClient()
    net.Start("loadVehicles")
        net.WriteTable(self.vehicles)
    net.Send(self)
end

function meta:loadVehicles(questId)
    self.vehicles = {}

    MySQLite.query("SELECT airboat, jeep FROM vehicles WHERE steamid = '" ..self:SteamID() .."'", function(results)
        if results then
            for k,v in pairs(results) do
                self.vehicles.airboat = {
                    owned = tobool(v.airboat)
                }
                self.vehicles.jeep = {
                    owned = tobool(v.jeep)
                }
            end
        else
            MySQLite.query("INSERT INTO vehicles (steamid, airboat, jeep) VALUES ('" ..self:SteamID() .."', 0, 0)")
        end

        self:updateVehiclesClient()
    end)
end

function meta:unlockVehicle(name)
    self.vehicles[name].owned = true

    MySQLite.query("UPDATE vehicles SET " ..name .." = 1 WHERE steamid = '" ..self:SteamID() .."'")

    self:updateVehiclesClient()
end
