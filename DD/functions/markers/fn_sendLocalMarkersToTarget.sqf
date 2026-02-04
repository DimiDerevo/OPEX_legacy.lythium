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
	"_target",
	"_player"
];

if (!DD_markers_AllowCopying && _shareType == 1 || !([player] call DD_fnc_hasMap)) exitWith {
	if !(_target isEqualTo "") then {[format [localize "STR_DD_markers_recieveRemoteMarkers_RemoteShareRefused", name _player]] remoteExec ["hint",_target]};
	if (DD_markers_Debug) then {['DEBUG', ["Local marker sending cancelled because local player does not allow copying or does not have any map items, requested by: ", _target]] call DD_fnc_diagLog};
};

_localMarkers = [] call DD_fnc_collectMarkers;

if (DD_markers_Debug) then {["DEBUG", ["Sending local markers to ", _target, ", marker data: ", _localMarkers]] call DD_fnc_diagLog};

[[_shareType, _target, _player, _localMarkers],"DD\functions\markers\fn_recieveRemoteMarkers.sqf"] remoteExec ["execVM",_target];