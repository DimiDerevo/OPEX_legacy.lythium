params ["_index"];

// GETTING SPOTTED PLAYERS
if (OPEX_playingPlayers isEqualTo []) exitWith {};
private _spottedPlayers = [];
{if (OPEX_enemy_side1 knowsAbout _x > 3.5) then {_spottedPlayers append [_x]}} forEach OPEX_playingPlayers;
if (_spottedPlayers isEqualTo []) exitWith {};

// SELECTING A RANDOM PLAYER
private _player = selectRandom _spottedPlayers;
private _reinforcePos = getPosATL _player;

// SPAWNING ENEMIES
private _squad = [OPEX_enemy_side1, ["infantry", "infantry", "infantry", "infantry", "infantry", "motorized", "motorized", "motorized", "motorized", "motorized", "motorized", "armored"], selectRandom [3,3,3,5,5,5,5,5,8], _player, [OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi], "attack", [_reinforcePos#0 + (random 250) - (random 250), _reinforcePos#1 + (random 250) - (random 250), _reinforcePos#2], OPEX_enemy_AIskill, 100] call Gemini_fnc_spawnSquad;
if (isNil "_squad") exitWith {};

OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) + 1)];

[_squad, _index] spawn {
	params ["_squad", "_index"];
	waitUntil {sleep 5; (!([leader _squad] call Gemini_fnc_isPlayerNearby)) || (count units _squad == 0)};
	OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) - 1)];
};

// DEBUGGING
if (OPEX_debug) then {
	systemChat "AMBIENT REINFORCEMENTS READY !";
	[[format ["OPEX_debugMarker_ambient_%1", random 100000], getPosATL (leader _squad), "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "REINFORCEMENTS"], "zeus", "distance", _squad] spawn Gemini_fnc_createMarker2;
};
