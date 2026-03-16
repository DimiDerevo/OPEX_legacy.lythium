params ["_index"];

if (OPEX_playingPlayers isEqualTo []) exitWith {};
private _player = selectRandom OPEX_playingPlayers;
private _type = ["infantry"];
if (count ((getPosATL _player) nearRoads  OPEX_spawnDistanceMaxi) > 100) then {
	if (random 100 < 10) then {_type = ["motorized"]};
};
private _squad = [
	OPEX_enemy_side1, 
	_type, 
	selectRandom [4], 
	_player, 
	[OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi], 
	"patrol", 
	_player, 
	OPEX_enemy_AIskill, 
	100
] call Gemini_fnc_spawnSquad;
if (isNil "_squad") exitWith {};
OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) + 1)];

[_squad, _index] spawn {
	params ["_squad", "_index"];
	waitUntil {sleep 5; (!([leader _squad] call Gemini_fnc_isPlayerNearby)) || (count units _squad == 0)};
	OPEX_ambientEnemyData#_index#1 set [0, ((OPEX_ambientEnemyData#_index#1#0) - 1)];
};

if (OPEX_debug) then {
	systemChat "AMBIENT PATROL READY !";
	[[format ["OPEX_debugMarker_ambient_%1", random 100000], getPosATL (leader _squad), "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "PATROL"], "zeus", "distance", _squad] spawn Gemini_fnc_createMarker2;
};