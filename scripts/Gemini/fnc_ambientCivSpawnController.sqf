if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
waitUntil {!isNil "OPEX_validBuildings"};
OPEX_ambientCivilianMan = 0; publicVariable "OPEX_ambientCivilianMan";
OPEX_ambientCivilianManMax = 50; publicVariable "OPEX_ambientCivilianManMax";
OPEX_ambientCivilianCars = 0; publicVariable "OPEX_ambientCivilianCars";
OPEX_ambientCivilianCarsMax = 10; publicVariable "OPEX_ambientCivilianCarsMax";
[] call Gemini_fnc_civilianInteractionsFunctions;

OPEX_ambientCivSpawnHandlerLoop = true;
OPEX_ambientCivSpawnBaseInterval = 10;
private _interval = OPEX_ambientCivSpawnBaseInterval;
private _scriptStartTime = 0;
private _playerCount = 0;
DD_playingPlayersTest = 10;

private _minCivs = 50;
private _maxCivs = 250;
private _maxCivsAtPlayerCount = 15;

private _minCars = 10;
private _maxCars = 20;
private _maxCarsAtPlayerCount = 15;

private _handleMan = [] spawn {};
private _handleCar = [] spawn {};

while {true} do {
    waitUntil {sleep 1; OPEX_playingPlayers isNotEqualTo []};
    if (OPEX_ambientCivSpawnHandlerLoop) then {
        _interval = OPEX_ambientCivSpawnBaseInterval;
        // _playerCount = (count OPEX_playingPlayers) max 1;
        _playerCount = DD_playingPlayersTest max 1;

        OPEX_ambientCivilianManMax = floor (_minCivs + (_maxCivs - _minCivs) * ((_playerCount - 1) / (_maxCivsAtPlayerCount - 1))); publicVariable "OPEX_ambientCivilianManMax";
        OPEX_ambientCivilianCarsMax = floor (_minCars + (_maxCivs - _minCars) * ((_playerCount - 1) / (_maxCarsAtPlayerCount - 1))); publicVariable "OPEX_ambientCivilianCarsMax";

        terminate _handleMan; _handleMan = [] spawn {}; // Resetting script
        terminate _handleCar; _handleCar = [] spawn {}; // Resetting script
        OPEX_ambientCivilianMan = {(alive _x) && (side _x == civilian) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))} count allUnits; publicVariable "OPEX_ambientCivilianMan";

        _scriptStartTime = serverTime;
        if (OPEX_ambientCivilianMan < OPEX_ambientCivilianManMax) then {_handleMan = ([] spawn Gemini_fnc_ambientCivilianLife2)};
        if (OPEX_ambientCivilianCars < OPEX_ambientCivilianCarsMax) then {_handleCar = ([] spawn Gemini_fnc_ambientCivilianCars2)};
    };
    waitUntil {sleep 1; (scriptDone _handleMan && scriptDone _handleCar) || (serverTime > _scriptStartTime + _interval)};
};