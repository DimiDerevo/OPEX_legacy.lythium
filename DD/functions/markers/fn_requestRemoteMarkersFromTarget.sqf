/*
	Author: 
		DimiDerevo
	
	Description:
		Collects all user created local markers and sends them to a remote client
	
	Parameter(s):
		0: Unit recieving request <OBJECT>
		1: Unit sending request <OBJECT>
	
	Returns:
		NOTHING 
		
	Example:
		[_target, _player] call DD_fnc_requestRemoteMarkersFromTarget;
*/

params [
	["_shareType", -1, [-1]],
	"_target",
	"_player"
];

if (DD_markers_Debug) then {["DEBUG", ["Requested remote markers from: ", _target]] call DD_fnc_diagLog};

[[_shareType, _player, _target],"DD\functions\markers\fn_sendLocalMarkersToTarget.sqf"] remoteExec ["execVM",_target];