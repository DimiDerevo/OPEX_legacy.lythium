params ["_index"];

if (OPEX_playingPlayers isEqualTo []) exitWith {};
private _player = selectRandom OPEX_playingPlayers;

// LOOKING FOR A RANDOM ABANDONED AREA AROUND SELECTED PLAYER
private _position = ["land_isolated", _player, OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi * 0.9, 5] call Gemini_fnc_findPos;
if (_position isEqualTo [0,0,0]) exitWith {};
private _lightSourcePos =  ["land", _position, 1, 10, 2] call Gemini_fnc_findPos;
if (_lightSourcePos isEqualTo [0,0,0]) exitWith {};

// SPAWNING BIVOUAC
private _lightSource = [["Campfire_burning_F"], _lightSourcePos] call Gemini_fnc_createVehicle; ["Land_ClutterCutter_large_F", _lightSource] call Gemini_fnc_createVehicle;
for "_i" from 1 to (round random 3) do {private _woodPile = [["Land_WoodenLog_F", "Land_WoodPile_F", "Land_WoodPile_large_F"], ["land", _lightSource, 1, 10, 2] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle};
for "_i" from 1 to (round random 5) do {private _tent = [["Land_TentA_F", "Land_TentDome_F"], ["land", _lightSource, 1, 15, 3] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle; ["Land_ClutterCutter_large_F", _tent] call Gemini_fnc_createVehicle};
for "_i" from 1 to (round random 5) do {private _sleepingBag = [["Land_Sleeping_bag_F", "Land_Sleeping_bag_folded_F", "Land_Sleeping_bag_blue_F", "Land_Sleeping_bag_blue_folded_F", "Land_Sleeping_bag_brown_F", "Land_Sleeping_bag_brown_folded_F"], ["land", _lightSource, 1, 15, 2] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle; ["Land_ClutterCutter_large_F", _sleepingBag] call Gemini_fnc_createVehicle};

// SPAWNING ENEMIES
[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,4,5], _lightSource, [2, 7.5], "talk", [], OPEX_enemy_AIskill, 100] call Gemini_fnc_spawnSquad;
// [OPEX_enemy_side1, ["infantry"], 2, _lightSource, [50, 100], "patrol", _lightSource, OPEX_enemy_AIskill, 75] call Gemini_fnc_spawnSquad;

OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) + 1)];

[_position, _index] spawn {
	params ["_position", "_index"];
	waitUntil {sleep 5; (_position call Gemini_fnc_isUnplayedArea)};
	OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) - 1)];
};

// DEBUGGING
if (OPEX_debug) then {
	systemChat "AMBIENT BIVOUAC READY !";
	[[format ["OPEX_debugMarker_ambient_%1", random 100000], getPosATL _lightSource, "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "BIVOUAC"], "zeus", "distance"] spawn Gemini_fnc_createMarker2;
};