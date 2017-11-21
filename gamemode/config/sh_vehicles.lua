VEHICLES = VEHICLES or {}

VEHICLES.types = {
    ["jeep"] = {
        model = "models/buggy.mdl",
        script = "scripts/vehicles/jeep_test.txt",
        class = "prop_vehicle_jeep_old",
    },
    ["airboat"] = {
        model = "models/airboat.mdl",
        script = "scripts/vehicles/airboat.txt",
        class = "prop_vehicle_airboat",
    }
}

VEHICLES.spawns = {
    {position = Vector(-6572, 4346, 49), angle = Angle(0, 0, 0)},
    {position = Vector(-6701, 4346, 49), angle = Angle(0, 0, 0)},
    {position = Vector(-6824, 4346, 49), angle = Angle(0, 0, 0)},
}
