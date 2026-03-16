params ["_index"];

if (OPEX_playingPlayers isEqualTo []) exitWith {};
private _player = selectRandom OPEX_playingPlayers;
private _overwatchPos = [];

// LOOKING FOR A RANDOM ROAD AROUND SELECTED PLAYER
private _roadPos = ["road", _player, OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi * 0.8] call Gemini_fnc_findPos;
if (_roadPos isEqualTo [0,0,0]) exitWith {};

// SPAWNING AMBUSH
for "_i" from 1 to (selectRandom [1,1,1,2,2,2,3]) do {
	_overwatchPos = ["overwatch", _roadPos, 20, 100] call Gemini_fnc_findPos;
	if (_overwatchPos isEqualTo [0,0,0]) exitWith {};
	[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,8], _overwatchPos, [0,0], "hold", _overwatchPos, OPEX_enemy_AIskill, 100] call Gemini_fnc_spawnSquad;
};
OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) + 1)];

[_overwatchPos, _index] spawn {
	params ["_overwatchPos", "_index"];
	waitUntil {sleep 5; (_overwatchPos call Gemini_fnc_isUnplayedArea)};
	OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) - 1)];
};

// DEBUGGING
if (OPEX_debug) then {
	systemChat "AMBIENT AMBUSH READY !";
	[[format ["OPEX_debugMarker_ambient_%1", random 100000], _roadPos, "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "AMBUSH"], "zeus", "distance"] spawn Gemini_fnc_createMarker2;
};
