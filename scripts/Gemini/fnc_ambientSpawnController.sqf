params ["_index"];

if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
waitUntil {!isNil "OPEX_validBuildings"};


[] call Gemini_fnc_ambientEnemyIEDsInit;
OPEX_ambientSpawnHandlerLoop = true;
OPEX_ambientSpawnBaseInterval = 20;
DD_playingPlayersTest = 10;
private _handle = [] spawn {};
private _interval = OPEX_ambientSpawnBaseInterval;
private _newSpawnType = "";
private _playerCount = 0;
private _newType = "";

OPEX_ambientEnemyData = [
//  ["name",    [current, max], [limit, coef, time multi, base weight]], weight
    ["Patrol",          [0, 2], [6, 0.70, 1.0, 1.0]],                    1.0,
    ["Bivouac",         [0, 1], [3, 0.30, 2.0, 0.8]],                    0.8,
    ["Ambush",          [0, 1], [3, 0.30, 1.5, 0.5]],                    0.5,
    ["Cache",           [0, 1], [3, 0.20, 2.0, 0.3]],                    0.3,
    ["Garrison",        [0, 1], [3, 0.20, 2.5, 0.3]],                    0.3,
    ["Roadblock",       [0, 1], [3, 0.20, 1.5, 0.3]],                    0.3,
    ["Reinforcement",   [0, 2], [6, 0.60, 1.0, 0.5]],                    0.5,
    ["IED",             [0, 2], [5, 0.50, 1.5, 0.5]],                    0.5
];

OPEX_ambientFriendData = [
//  ["name",    [current, max], [limit, coef, time multi, base weight]], weight
    ["Patrol",          [0, 1], [3, 0.30, 1.0, 0.8]],                    0.8,
    ["Roadblock",       [0, 1], [2, 0.15, 1.5, 0.1]],                    0.1,
    ["Air",             [0, 1], [1, 0.10, 1.0, 0.1]],                    0.1
];

while {true} do {
    waitUntil {sleep 1; OPEX_playingPlayers isNotEqualTo []};
    if (OPEX_ambientSpawnHandlerLoop) then {

        _playerCount = (count OPEX_playingPlayers) max 1;
        //_playerCount = DD_playingPlayersTest max 1;
        for "_i" from 0 to ((count OPEX_ambientEnemyData) - 1) step 2 do {
            OPEX_ambientEnemyData#_i#1 set [1, round (OPEX_ambientEnemyData#_i#2#0 min (1 + OPEX_ambientEnemyData#_i#2#1 * (_playerCount - 1) ^ 0.7))]; // Updating new max enemy type count based on player count
            OPEX_ambientEnemyData set [_i+1, 0 max (OPEX_ambientEnemyData#_i#2#3 * (linearConversion [OPEX_ambientEnemyData#_i#1#1, 0, OPEX_ambientEnemyData#_i#1#0, 0, 1, true]))]; // Updating weight of enemy type based on current amount of this type
        };
        for "_i" from 0 to ((count OPEX_ambientFriendData) - 1) step 2 do {
            OPEX_ambientFriendData#_i#1 set [1, round (OPEX_ambientFriendData#_i#2#0 min (1 + OPEX_ambientFriendData#_i#2#1 * (_playerCount - 1) ^ 0.5))]; // Updating new max friend type count based on player count
            OPEX_ambientFriendData set [_i+1, 0 max (OPEX_ambientFriendData#_i#2#3 * (linearConversion [OPEX_ambientFriendData#_i#1#1, 0, OPEX_ambientFriendData#_i#1#0, 0, 1, true]))]; // Updating weight of friend type based on current amount of this type
        };

        _interval = OPEX_ambientSpawnBaseInterval;
        terminate _handle; // Resetting script
        
        switch (["east", "west"] selectRandomWeighted [0.9, 0.1]) do {
            case "east": {
                switch ((selectRandomWeighted OPEX_ambientEnemyData)#0) do {
                    case (OPEX_ambientEnemyData#00#0):    {if (OPEX_ambientEnemyData#00#1#0 < OPEX_ambientEnemyData#00#1#1) then  {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientEnemyData#00#2#2; _handle = ([00] spawn Gemini_fnc_ambientEnemyPatrols2)}};
                    case (OPEX_ambientEnemyData#02#0):    {if (OPEX_ambientEnemyData#02#1#0 < OPEX_ambientEnemyData#02#1#1) then  {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientEnemyData#02#2#2; _handle = ([02] spawn Gemini_fnc_ambientEnemyBivouacs2)}};
                    case (OPEX_ambientEnemyData#04#0):    {if (OPEX_ambientEnemyData#04#1#0 < OPEX_ambientEnemyData#04#1#1) then  {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientEnemyData#04#2#2; _handle = ([04] spawn Gemini_fnc_ambientEnemyAmbushes2)}};
                    case (OPEX_ambientEnemyData#06#0):    {if (OPEX_ambientEnemyData#06#1#0 < OPEX_ambientEnemyData#06#1#1) then  {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientEnemyData#06#2#2; _handle = ([06] spawn Gemini_fnc_ambientEnemyCaches2)}};
                    case (OPEX_ambientEnemyData#08#0):    {if (OPEX_ambientEnemyData#08#1#0 < OPEX_ambientEnemyData#08#1#1) then  {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientEnemyData#08#2#2; _handle = ([08] spawn Gemini_fnc_ambientEnemyGarrisons2)}};
                    case (OPEX_ambientEnemyData#10#0):    {if (OPEX_ambientEnemyData#10#1#0 < OPEX_ambientEnemyData#10#1#1) then  {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientEnemyData#10#2#2; _handle = ([10] spawn Gemini_fnc_ambientEnemyRoadblocks2)}};
                    case (OPEX_ambientEnemyData#12#0):    {if (OPEX_ambientEnemyData#12#1#0 < OPEX_ambientEnemyData#12#1#1) then  {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientEnemyData#12#2#2; _handle = ([12] spawn Gemini_fnc_ambientEnemyReinforcements2)}};
                    case (OPEX_ambientEnemyData#14#0):    {if (OPEX_ambientEnemyData#14#1#0 < OPEX_ambientEnemyData#14#1#1) then  {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientEnemyData#14#2#2; _handle = ([14] spawn Gemini_fnc_ambientEnemyIEDs2)}};
                };  
            };
            case "west": {
                switch ((selectRandomWeighted OPEX_ambientFriendData)#0) do {
                    case (OPEX_ambientFriendData#00#0):    {if ((OPEX_ambientFriendData#00#1#0 < OPEX_ambientFriendData#00#1#1) && !(OPEX_taskID == "06")) then     {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientFriendData#00#2#2; _handle = ([00] spawn Gemini_fnc_ambientFriendlyPatrols2)}};
                    case (OPEX_ambientFriendData#02#0):    {if (OPEX_ambientFriendData#02#1#0 < OPEX_ambientFriendData#02#1#1) then                                 {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientFriendData#02#2#2; _handle = ([02] spawn Gemini_fnc_ambientFriendlyRoadblocks2)}};
                    case (OPEX_ambientFriendData#04#0):    {if (OPEX_ambientFriendData#04#1#0 < OPEX_ambientFriendData#04#1#1) then                                 {_interval = OPEX_ambientSpawnBaseInterval * OPEX_ambientFriendData#04#2#2; _handle = ([04] spawn Gemini_fnc_ambientFriendlyAir2)}};
                };
            };
        };
    };
    sleep _interval;
};