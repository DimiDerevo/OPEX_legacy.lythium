params ["_vehicle", ["_loadoutTypeOverride", ""]];

private _loadout = [];

if (_loadoutTypeOverride isEqualTo "") then {
    if (typeOf _vehicle in OPEX_vehicleTypeDingo#0) then        {_loadout = OPEX_vehicleTypeDingo#1};
    if (typeOf _vehicle in OPEX_vehicleTypeEagle#0) then        {_loadout = OPEX_vehicleTypeEagle#1};
    if (typeOf _vehicle in OPEX_vehicleTypeFuchs#0) then        {_loadout = OPEX_vehicleTypeFuchs#1};
    if (typeOf _vehicle in OPEX_vehicleTypeMarder#0) then       {_loadout = OPEX_vehicleTypeMarder#1};
    if (typeOf _vehicle in OPEX_vehicleTypeFuchsEngi#0) then    {_loadout = OPEX_vehicleTypeFuchsEngi#1};
    if (typeOf _vehicle in OPEX_vehicleTypeFuchsMed#0) then     {_loadout = OPEX_vehicleTypeFuchsMed#1};
    if (typeOf _vehicle in OPEX_vehicleTypeTruck#0) then        {_loadout = OPEX_vehicleTypeTruck#1};
    if (typeOf _vehicle in OPEX_vehicleTypeHeli#0) then         {_loadout = OPEX_vehicleTypeHeli#1};
} else {
    switch (toLower _loadoutTypeOverride) do {
        case "dingo":           {_loadout = OPEX_vehicleTypeDingo#1};
        case "eagle":           {_loadout = OPEX_vehicleTypeEagle#1};
        case "fuchs":           {_loadout = OPEX_vehicleTypeFuchs#1};
        case "marder":          {_loadout = OPEX_vehicleTypeMarder#1};
        case "fuchsengi":       {_loadout = OPEX_vehicleTypeFuchsEngi#1};
        case "fuchsmed":        {_loadout = OPEX_vehicleTypeFuchsMed#1};
        case "truck":           {_loadout = OPEX_vehicleTypeTruck#1};
        case "heli":            {_loadout = OPEX_vehicleTypeHeli#1};
        case "defaulttruck":    {_loadout = OPEX_loadoutHeliDefault#1};
        case "defaultheli":     {_loadout = OPEX_loadoutCarDefault#1};
    };
};

if (_loadout isEqualTo []) then {
    if (_vehicle isKindOf "Helicopter") then {_loadout = OPEX_loadoutHeliDefault};
    if (_vehicle isKindOf "LandVehicle") then {_loadout = OPEX_loadoutCarDefault};
};

if (_loadout isNotEqualTo []) then {
    if (_loadout#0 isNotEqualTo []) then {{_vehicle addItemCargoGlobal [_x#0, _x#1]} forEach _loadout#0};
    if (_loadout#1 isNotEqualTo []) then {{_vehicle addBackpackCargoGlobal [_x#0, _x#1]} forEach _loadout#1};
};