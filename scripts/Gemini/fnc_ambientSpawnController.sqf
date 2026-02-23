if (!isServer) exitWith {};
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_playingPlayers"};
waitUntil {!isNil "OPEX_spawnDistanceMaxi"};
OPEX_ambientEnemyPatrols = 0; publicVariable "OPEX_ambientEnemyPatrols";
OPEX_ambientEnemyPatrolsMax = 3; publicVariable "OPEX_ambientEnemyPatrolsMax";
OPEX_ambientEnemyBivouacs = 0; publicVariable "OPEX_ambientEnemyBivouacs";
OPEX_ambientEnemyBivouacsMax = 2; publicVariable "OPEX_ambientEnemyBivouacsMax";
OPEX_ambientEnemyAmbushes = 0; publicVariable "OPEX_ambientEnemyAmbushes";
OPEX_ambientEnemyAmbushesMax = 2; publicVariable "OPEX_ambientEnemyAmbushesMax";
OPEX_ambientEnemyCaches = 0; publicVariable "OPEX_ambientEnemyCaches";
OPEX_ambientEnemyCachesMax = 1; publicVariable "OPEX_ambientEnemyCachesMax";
OPEX_ambientEnemyGarrisons = 0; publicVariable "OPEX_ambientEnemyGarrisons";
OPEX_ambientEnemyGarrisonsMax = 1; publicVariable "OPEX_ambientEnemyGarrisonsMax";
OPEX_ambientEnemyRoadblock = 0; publicVariable "OPEX_ambientEnemyRoadblock";
OPEX_ambientEnemyRoadblockMax = 1; publicVariable "OPEX_ambientEnemyRoadblockMax";
OPEX_ambientEnemyReinforcements = 0; publicVariable "OPEX_ambientEnemyReinforcements";
OPEX_ambientEnemyReinforcementsMax = 3; publicVariable "OPEX_ambientEnemyReinforcementsMax";
OPEX_ambientEnemyIEDs = 0; publicVariable "OPEX_ambientEnemyIEDs";
OPEX_ambientEnemyIEDsMax = 2; publicVariable "OPEX_ambientEnemyIEDsMax";

OPEX_ambientFriendlyPatrols = 0; publicVariable "OPEX_ambientFriendlyPatrols";
OPEX_ambientFriendlyPatrolsMax = 3; publicVariable "OPEX_ambientFriendlyPatrolsMax";
OPEX_ambientFriendlyRoadblock = 0; publicVariable "OPEX_ambientFriendlyRoadblock";
OPEX_ambientFriendlyRoadblockMax = 3; publicVariable "OPEX_ambientFriendlyRoadblockMax";
OPEX_ambientFriendlyAir = 0; publicVariable "OPEX_ambientFriendlyAir";
OPEX_ambientFriendlyAirMax = 1; publicVariable "OPEX_ambientFriendlyAirMax";

[] spawn Gemini_fnc_ambientEnemyIEDsInit;

OPEX_ambientSpawnHandlerLoop = true;
OPEX_ambientSpawnBaseInterval = 10;
private _interval = OPEX_ambientSpawnBaseInterval;

private _handle = [] spawn {};
private _ambientSpawnSides = [
    "west", 0.2,
    "east", 0.8
];
private _ambientEnemyTypes = [
    "Ambush", 0.5,
    "Bivouac", 0.8,
    "Cache", 0.3,
    "Garrison", 0.3,
    "IED", 0.5,
    "Patrol", 1,
    "Reinforcement", 0.5,
    "Roadblock", 0.3
];
private _ambientFriendTypes = [
    "Patrol", 0.6,
    "Roadblock", 0.2,
    "Air", 0.2
];
private _ambientCivTypes = [
    "Man", 1
];

while {true} do {
    waitUntil {OPEX_playingPlayers isNotEqualTo []};
    if (OPEX_ambientSpawnHandlerLoop) then {
        _interval = OPEX_ambientSpawnBaseInterval;
        terminate _handle; _handles = []; // Resetting script

        switch (selectRandomWeighted _ambientSpawnSides) do {
            case "east": {
                switch (selectRandomWeighted _ambientEnemyTypes) do {
                    case "Patrol":          {if (OPEX_ambientEnemyPatrols < OPEX_ambientEnemyPatrolsMax) then               {_handle = ([] spawn Gemini_fnc_ambientEnemyPatrols2)}};
                    case "Bivouac":         {if (OPEX_ambientEnemyBivouacs < OPEX_ambientEnemyBivouacsMax) then             {_handle = ([] spawn Gemini_fnc_ambientEnemyBivouacs2); _interval = OPEX_ambientSpawnBaseInterval * 2}};
                    case "Ambush":          {if (OPEX_ambientEnemyAmbushes < OPEX_ambientEnemyAmbushesMax) then             {_handle = ([] spawn Gemini_fnc_ambientEnemyAmbushes2); _interval = OPEX_ambientSpawnBaseInterval * 1.5}};
                    case "Cache":           {if (OPEX_ambientEnemyCaches < OPEX_ambientEnemyCachesMax) then                 {_handle = ([] spawn Gemini_fnc_ambientEnemyCaches2); _interval = OPEX_ambientSpawnBaseInterval * 2}};
                    case "Garrison":        {if (OPEX_ambientEnemyGarrisons < OPEX_ambientEnemyGarrisonsMax) then           {_handle = ([] spawn Gemini_fnc_ambientEnemyGarrisons2); _interval = OPEX_ambientSpawnBaseInterval * 2.5}};
                    case "Roadblock":       {if (OPEX_ambientEnemyRoadblock < OPEX_ambientEnemyRoadblockMax) then           {_handle = ([] spawn Gemini_fnc_ambientEnemyRoadblocks2); _interval = OPEX_ambientSpawnBaseInterval * 1.5}};
                    case "Reinforcement":   {if (OPEX_ambientEnemyReinforcements < OPEX_ambientEnemyReinforcementsMax) then {_handle = ([] spawn Gemini_fnc_ambientEnemyReinforcements2)}};
                    case "IED":             {if (OPEX_ambientEnemyIEDs < OPEX_ambientEnemyIEDsMax) then                     {_handle = ([] spawn Gemini_fnc_ambientEnemyIEDs2); _interval = OPEX_ambientSpawnBaseInterval * 1.5}};
                };
            };
            case "west": {
                switch (selectRandomWeighted _ambientFriendTypes) do {
                    case "Patrol":          {if ((OPEX_ambientFriendlyPatrols < OPEX_ambientFriendlyPatrolsMax) && !(OPEX_taskID == "06")) then {_handle = ([] spawn Gemini_fnc_ambientFriendlyPatrols2)}};
                    case "Roadblock":       {if (OPEX_ambientFriendlyRoadblock < OPEX_ambientFriendlyRoadblockMax) then                         {_handle = ([] spawn Gemini_fnc_ambientFriendlyRoadblocks2); _interval = OPEX_ambientSpawnBaseInterval * 1.5}};
                    case "Air":             {if (OPEX_ambientFriendlyAir < OPEX_ambientFriendlyAirMax) then                                     {_handle = ([] spawn Gemini_fnc_ambientFriendlyAir2)}};
                };
            };
        };
    };
    sleep _interval;
};