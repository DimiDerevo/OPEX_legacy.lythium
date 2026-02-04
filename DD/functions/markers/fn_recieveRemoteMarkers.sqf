/*
	Author: 
		DimiDerevo
	
	Description:
		Recieves marker data, generates a new name for local marker and sends to DD_fnc_stringToMarker
	
	Parameter(s):
		0: Array of strings from DD_fnc_sendLocalMarkersToTarget <OBJECT>
	
	Returns:
		NOTHING 
		
	Example:
		[_remoteMarkers] call DD_fnc_recieveRemoteMarkers;
*/

params [
	["_shareType", -1, [-1]],
	["_reciever", ""],
	["_sender", ""],
	["_remoteMarkers", ""]
];

if (DD_markers_Debug) then {["DEBUG", ["Recieving remote markers from ID: ", _sender]] call DD_fnc_diagLog};

//if !([player] call DD_fnc_hasMap) exitWith {};

//==============================================================================
//	Cheking if we should apply remote markers depending on player's settings
//==============================================================================

if (!DD_markers_AllowRecieving && _shareType in [0,2] || !([player] call DD_fnc_hasMap)) exitWith {
	if (!(_sender isEqualTo "") && _shareType == 0) then {[format [localize "STR_DD_markers_recieveRemoteMarkers_RemoteRecieveRefused", name player]] remoteExec ["hint",_sender]};
	if (DD_markers_Debug) then {['DEBUG', ["Remote marker recieving cancelled because local player does not allow recieving or does not have any map items, sender: ", _sender]] call DD_fnc_diagLog};
};

//==============================================================================
//	Getting existing marker names and their positions
//==============================================================================

private _markersAndPos = [];
{
	switch (markerShape _x) do {
		case "POLYLINE": {_markersAndPos pushBack [_x, markerPolyline _x];};
		default {_markersAndPos pushBack [_x, markerPos _x];};
	};
} forEach allMapMarkers;

//==============================================================================
//	Applying markers to map
//==============================================================================

{
	private _localMarkerName = "";
	private _separator = _x select [0, 1];
	private _markerData = _x splitString _separator;
	private _remoteMarkerName = _markerData select 0;
	private _intersectingMarkerIndex = -1;

	// Checking if any existing marker intersects with a new one
	switch (_markerData select 2) do {
		case "POLYLINE": {_intersectingMarkerIndex = _markersAndPos findIf {_x select 1 isEqualTo parseSimpleArray (_markerData select 3)}};
		default {_intersectingMarkerIndex = _markersAndPos findIf {_x select 1 isEqualTo parseSimpleArray (_markerData select 1)}};
	};

	// If new marker intersects with existing then modify it, else create with a local name
	if (_intersectingMarkerIndex >= 0) then {
		_localMarkerName = _markersAndPos select _intersectingMarkerIndex select 0;

		_markerData set [0, ([_separator, _localMarkerName] joinString "")];
		(_markerData joinString _separator) call DD_fnc_stringToMarker;

		if (DD_markers_Debug) then {['DEBUG', ['Modifying existing marker: ', _localMarkerName, ', remote marker data: ', _x]] call DD_fnc_diagLog};
	} else {
		private _oldMarkerName = _markerData select 0 splitString "#/"; // ["_USER_DEFINED #","2","0","3"] or ["_USER_DEFINED #","1234","0","3","2","1","3"]
		_localMarkerName = [["_USER_DEFINED ", _oldMarkerName#1] joinString "#", _oldMarkerName#2, _oldMarkerName#-1, getPlayerID player, DD_markers_CounterLocal, _oldMarkerName#-1] joinString "/";
		DD_markers_CounterLocal = DD_markers_CounterLocal + 1;

		_markerData set [0, ([_separator, _localMarkerName] joinString "")];
		(_markerData joinString _separator) call DD_fnc_stringToMarker;

		if (DD_markers_Debug) then {["DEBUG", ['Creating new marker: ', _localMarkerName, ', remote marker data: ', _x]] call DD_fnc_diagLog};
	};
} forEach _remoteMarkers;

if (count _remoteMarkers > 0) then {
	hint localize "STR_DD_markers_recieveRemoteMarkers_MarkersHaveBeenCopied";
};