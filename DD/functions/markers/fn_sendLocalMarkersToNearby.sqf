/*
	Author: 
		DimiDerevo
	
	Description:
		Collects all user created local markers and sends them to a remote client
	
	Parameter(s):
		0: Unit recieving marker data <OBJECT>
		1: Unit sending marker data <OBJECT>
	
	Returns:
		NOTHING 
		
	Example:
		[_target, _player] call DD_fnc_sendLocalMarkersToTarget;
*/

params [
	["_shareType", -1, [-1]],
	["_player", ""]
];

private _nearTargets = [];

if !(isNull objectParent _player) then {
	{
		if (alive _x && _x != _player) then { _nearTargets pushBackUnique _x};
	} forEach crew vehicle player;
} else {
	{
		if (alive _x && _x != _player) then {_nearTargets pushBackUnique _x};
	} forEach nearestObjects [_player, ["CAManBase"], DD_markers_RangedShareDistance, false];
};

_localMarkers = [] call DD_fnc_collectMarkers;

if (DD_markers_Debug) then {["DEBUG", ["Ranged sharing targets: ", _nearTargets]] call DD_fnc_diagLog};
if (count _nearTargets > 0) then {[[_shareType, "", _player, _localMarkers],"DD\functions\markers\fn_recieveRemoteMarkers.sqf"] remoteExec ["execVM", _nearTargets]};