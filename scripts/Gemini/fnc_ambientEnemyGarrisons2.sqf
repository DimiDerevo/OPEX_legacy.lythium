params ["_index"];

// CHECKING IF AT LEAST ONE REQUIRED LOCATION EXISTS
if (count (OPEX_locations_industrial + OPEX_locations_military + OPEX_locations_isolated) == 0) exitWith {};

if (OPEX_playingPlayers isEqualTo []) exitWith {};
private _player = selectRandom OPEX_playingPlayers;

// LOOKING FOR A RANDOM LOCATION AROUND SELECTED PLAYER
private _locationPos = [["industry", "military", "isolated"], _player] call Gemini_fnc_findPos;
if (_locationPos isEqualTo [0,0,0]) exitWith {};
_locationSize = ((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 0) max ((triggerArea ((_locationPos nearObjects ["EmptyDetector", 5]) select 0)) select 1);


// SPAWNING FLAG
private _flagPos = ["land", _locationPos, 1, _locationSize / 2, 3] call Gemini_fnc_findPos;
if (_flagPos isEqualTo [0,0,0]) exitWith {};
private _flag = [OPEX_enemy_flag, _flagPos] call Gemini_fnc_createVehicle;
_flag setFlagTexture OPEX_enemy_flagTexture;

// SPAWNING ENEMIES
[_flag, _locationSize, random 8, OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill] call Gemini_fnc_spawnUnitsStandingInside;
[_flag, 15, 2 + (round random 3), OPEX_enemy_side1, OPEX_enemy_units, OPEX_enemy_AIskill] call Gemini_fnc_spawnUnitsStandingOutside;
for "_i" from 1 to (ceil (random 2)) do {[OPEX_enemy_side1, ["infantry"], ceil (random 5), _flag, [20, 75], "talk", [], OPEX_enemy_AIskill, 50] call Gemini_fnc_spawnSquad};
for "_i" from 1 to (ceil (random 2)) do {[OPEX_enemy_side1, ["infantry", "infantry", "infantry", "infantry", "infantry", "motorized"], selectRandom [2, 3, 4, 5], _flag, [random _locationSize, _locationSize * 5], "patrol", _flag, OPEX_enemy_AIskill, 50] call Gemini_fnc_spawnSquad};

OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) + 1)];

// SPAWNING STATIC DEFENSE
[position _flag, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, random 360, _locationSize * 2, ceil (random 3), 75] call Gemini_fnc_spawnStaticDefense;

// SPAWNING EMPTY VEHICLES
[OPEX_enemy_armored + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, position _flag, _locationSize, [OPEX_enemy_units, ceil (random 3)], 50] call Gemini_fnc_spawnVehicle;
[OPEX_enemy_armored + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, position _flag, _locationSize, [OPEX_enemy_units, ceil (random 3)], 50] call Gemini_fnc_spawnVehicle;
[OPEX_enemy_armored + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles + OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, position _flag, _locationSize, [OPEX_enemy_units, ceil (random 3)], 50] call Gemini_fnc_spawnVehicle;

// SPAWNING DECORATIONS
private _lightSource = [["Campfire_burning_F", "MetalBarrel_burning_F"], ["land", _flag, 1, 10, 2] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle;
private _clutterCutter = ["Land_ClutterCutter_large_F", _lightSource] call Gemini_fnc_createVehicle;
for "_i" from 1 to (round random 2) do {private _barrel = [["Land_MetalBarrel_empty_F", "Land_BarrelTrash_F", "Land_BarrelEmpty_F", "Land_BarrelEmpty_grey_F"], ["land", _flag, 1, 15, 2] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle};
for "_i" from 1 to (round random 2) do {private _woodPile = [["Land_WoodenLog_F", "Land_WoodPile_F", "Land_WoodPile_large_F"], ["land", _flag, 1, 10, 2] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle};
if (count ((position _flag) nearObjects ["Building", _locationSize]) <= 5) then	{
	for "_i" from 1 to (round random 5) do {private _tent = [["Land_TentA_F", "Land_TentDome_F"], ["land", _flag, 1, 20, 3] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle;
	["Land_ClutterCutter_large_F", _tent] call Gemini_fnc_createVehicle};
	for "_i" from 1 to (round random 5) do {private _sleepingBag = [["Land_Sleeping_bag_F", "Land_Sleeping_bag_folded_F", "Land_Sleeping_bag_blue_F", "Land_Sleeping_bag_blue_folded_F", "Land_Sleeping_bag_brown_F", "Land_Sleeping_bag_brown_folded_F"], ["land", _flag, 1, 15, 2] call Gemini_fnc_findPos] call Gemini_fnc_createVehicle;
	["Land_ClutterCutter_large_F", _sleepingBag] call Gemini_fnc_createVehicle};
};

[_locationPos, _index] spawn {
	params ["_locationPos", "_index"];
	waitUntil {sleep 5; (_locationPos call Gemini_fnc_isUnplayedArea)};
	OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) - 1)];
};

// DEBUGGING
if (OPEX_debug) then {
	systemChat "AMBIENT GARRISON READY !";
	[[format ["OPEX_debugMarker_ambient_%1", random 100000], getPosATL _flag, "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "GARRISON"], "zeus", "distance"] spawn Gemini_fnc_createMarker2;
};
