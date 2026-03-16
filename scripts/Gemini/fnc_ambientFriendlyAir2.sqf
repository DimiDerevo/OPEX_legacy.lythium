params ["_index"];

if (OPEX_playingPlayers isEqualTo []) exitWith {};
private _player = selectRandom OPEX_playingPlayers;

// LOOKING FOR A RANDOM POSITION AROUND SELECTED PLAYER
private _position = ["any", _player, OPEX_spawnDistanceMaxi, OPEX_spawnDistanceMaxi * 2] call Gemini_fnc_findPos;
if (_position isEqualTo [0,0,0]) exitWith {};

// RANDOMLY SELECTING CHOPPER OR AIRCRAFT
private ["_class", "_height"];
private _airTypes = [
	"plane", 1,
	"heli", 1
];
switch (selectRandomWeighted _airTypes) do {
	case "plane"	:{_class = selectRandom OPEX_friendly_aircrafts; _height = selectRandom [1000,1200,1400,1600]};
	case "heli"		:{_class = selectRandom OPEX_friendly_choppers; _height = selectRandom [300,450,600]};
	default			 {_class = selectRandom OPEX_friendly_choppers; _height = 600};
};

private _generalDir = random 360;
private _startPos = _player getPos [OPEX_spawnDistanceMaxi * (2 + random 2), _generalDir - (random 50) + (random 50) - 180]; _startPos set [2, _height];
private _endPos = _player getPos [OPEX_spawnDistanceMaxi * 10, _generalDir - (random 50) + (random 50)]; _endPos set [2, _height];
private _az = [_startPos, _endPos] call BIS_fnc_dirTo;

// CALCULATING DESTINATION
private _vehicle = ([_startPos, _az, _class, west] call BIS_fnc_spawnVehicle) select 0;
OPEX_ambientFriendData#_index#1 set [0, ((OPEX_ambientFriendData#_index#1#0) + 1)];
[_vehicle, "distance"] call Gemini_fnc_setLifeTime;

private _markerStart = "";
private _markerEnd = "";
// DEBUGGING
if (OPEX_debug) then {
	systemChat "AMBIENT AIR READY !";
	_markerStart = [[format ["OPEX_debugMarker_ambient_%1", random 100000], _startPos, "ICON", "mil_start", [0.8, 0.8], 0, "Solid", "ColorBlue", 1, "AIR"], "zeus", "unlimited", _vehicle] call Gemini_fnc_createMarker2;
	_markerStart = [[format ["OPEX_debugMarker_ambient_%1", random 100000], _startPos, "ICON", "mil_start", [0.8, 0.8], 0, "Solid", "ColorBlue", 1, "AIR START"], "zeus", "unlimited"] call Gemini_fnc_createMarker2;
	_markerEnd = [[format ["OPEX_debugMarker_ambient_%1", random 100000], _endPos, "ICON", "mil_end", [0.8, 0.8], 0, "Solid", "ColorBlue", 1, "AIR END"], "zeus", "unlimited"] call Gemini_fnc_createMarker2;
};

[_vehicle, _markerStart, _markerEnd, _index] spawn {
	params ["_vehicle", "_markerStart", "_markerEnd", "_index"];
	waitUntil {sleep 5; (!alive _vehicle)};
	deleteMarker _markerStart; deleteMarker _markerEnd;
	OPEX_ambientFriendData#_index#1 set [0, ((OPEX_ambientFriendData#_index#1#0) - 1)];
};

_vehicle doMove _endPos;
sleep 1;
_vehicle flyInHeight _height;
_vehicle allowFleeing 0;
_vehicle disableAI "target";
_vehicle disableAI "autoTarget";
_vehicle setSkill 1;
//_vehicle setCaptive true;
[_vehicle, _endPos] spawn {
	sleep 1;
	deleteWaypoint [(group driver (_this select 0)), 0];
	_wp = (group driver (_this select 0)) addWaypoint [(_this select 1), 0];
	_wp setWaypointType "move";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointCombatMode "WHITE";
	_wp setWaypointSpeed (selectRandom ["normal", "full", "full"]);
};