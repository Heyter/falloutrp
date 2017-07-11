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
    if self.vehicles[name].owned then
        local active = self.activeVehicle

        if IsValid(active) then
            active:Remove()
            self.activeVehicle = nil
        end

        local data = VEHICLES:getData(name)

        local car = ents.Create(data.class)
        car:SetModel(data.model)
        car:SetKeyValue("vehiclescript", data.script)
        local spot = table.Random(VEHICLES.spawns)
        car:SetPos(spot.position)
        car:SetAngles(spot.angle)
        car:Spawn()
        car:Activate()
        car.driverRestricted = self

        timer.Simple(10, function()
            if IsValid(car) then
                car.driverRestricted = nil
            end
        end)

        self.activeVehicle = car
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

hook.Add("PlayerDisconnected", "removeVehicles", function(ply)
    if ply.activeVehicle then
        ply.activeVehicle:Remove()
    end
end)

local function antiCarDM (victim, attacker)
    if (attacker:IsValid()) then
        if (attacker:GetClass() == "prop_vehicle_jeep") or (attacker:GetClass() == "prop_vehicle_airboat") then
            return false
        else
            if (attacker:IsPlayer()) then
                if (attacker:InVehicle()) then
                    return false
                end
            elseif victim.spawnProtected then
                return false
            else
                return true
            end
        end
    end
end
hook.Add("PlayerShouldTakeDamage", "stopVehicleDamage", antiCarDM)

hook.Add("CanPlayerEnterVehicle", "stopVehicleSteal", function(ply, vehicle)
    if vehicle.driverRestricted and vehicle.driverRestricted != ply then
        ply:notify("You cannot enter a recently spawned vehicle that's not yours.", NOTIFY_ERROR, 5)
        return false
    end
end)
