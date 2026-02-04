/*
	Author: 
		Killzone_Kid, modified by LAxemann and DimiDerevo
	
	Description:
		Serializes marker to string for storage
	
	Parameter(s):
		0: STRING - existing marker name
		1: STRING (Optional) - a single data delimiter character. Default "|"
	
	Returns:
		STRING - serialized marker to be used with DD_fnc_stringToMarker
		or 
		"" on error
	
	Example:
		["marker_0"] call RR_mapStuff_fnc_markerToString;
		["marker_1", ":"] call RR_mapStuff_fnc_markerToString;
*/

params [["_markerName", "", [""]], ["_delimiter", "|", [""]]];


// Position
toFixed 4;
private _markerPosition = str markerPos [_markerName, true];
toFixed -1;

// Shape and Type/Polyline Array (Polyline or icon)
private _markerShape = markerShape _markerName;
private _markerTypeOrPolyline = "";
if (_markerShape isEqualTo "POLYLINE") then {
	_markerTypeOrPolyline = markerPolyline _markerName;
} else {
	_markerTypeOrPolyline = markerType _markerName;
};

// Size
_markerSize = str markerSize _markerName;
// Dir
_markerDir = str markerDir _markerName;
// Brush
_markerBrush = markerBrush _markerName;
// Color
_markerColor = markerColor _markerName;
// Alpha
_markerAlpha = str markerAlpha _markerName;

// Additional data
_markerCreatorID = "2";
_markerID = "0";
_markerChannel = "0";
if (_markerName select [0,15] == "_USER_DEFINED #") then {
	_str = _markerName splitString ("#/");
	_markerCreatorID = _str#1;
	_markerID = _str#2;
	_markerChannel = _str#3;
};

// Text
_markerText = markerText _markerName;

[
	"",
	_markerName,
	_markerPosition,
	_markerShape,
	_markerTypeOrPolyline,
	_markerSize,
	_markerDir,
	_markerBrush,
	_markerColor,
	_markerAlpha,
	_markerCreatorID,
	_markerID,
	_markerChannel,
	_markerText
] joinString _delimiter;
