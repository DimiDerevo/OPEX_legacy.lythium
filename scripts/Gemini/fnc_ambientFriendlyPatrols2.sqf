params ["_index"];

if ((OPEX_assignedTask) && (OPEX_taskID == "06")) exitWith {};
if (OPEX_playingPlayers isEqualTo []) exitWith {};
private _player = selectRandom OPEX_playingPlayers;

// SPAWNING FRIENDS
private _squad = [OPEX_friendly_side1, ["infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "infantry", "motorized", "motorized", "armored"], selectRandom [4,8], _player, [OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi], "patrol", _player, OPEX_friendly_AIskill, 100] call Gemini_fnc_spawnSquad;
if (isNil "_squad") exitWith {};

OPEX_ambientFriendData#_index#1 set [0, ((OPEX_ambientFriendData#_index#1#0) + 1)];

[_squad, _index] spawn {
	params ["_squad", "_index"];
	waitUntil {sleep 5; (!([leader _squad] call Gemini_fnc_isPlayerNearby)) || (count units _squad == 0)};
	OPEX_ambientFriendData#_index#1 set [0, ((OPEX_ambientFriendData#_index#1#0) - 1)];
};

// SENDING RADIO MESSAGE + CREATING MARKER TO INFORM PLAYERS THAT A FRIEND PATROL IS NEARBY
{if (_x distance2D _player <= OPEX_spawnDistanceMini / 3) then {["Base", "STR_radio_friendliesNearby"] remoteExec ["Gemini_fnc_commandChat", _x]}} forEach OPEX_playingPlayers; // TODO: Inform all players about firendly patrol operating in area with general position

// DEBUGGING
if (OPEX_debug) then {
	systemChat "AMBIENT PATROL READY !";
	[[format ["OPEX_debugMarker_ambient_%1", random 100000], getPosATL (leader _squad), "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorBlue", 1, "PATROL"], "zeus", "distance", _squad] spawn Gemini_fnc_createMarker2;
};