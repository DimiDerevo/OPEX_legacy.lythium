/*
	Author: 
		Killzone_Kid, modified by LAxemann and DimiDerevo
	
	Description:
		Creates marker from serialized data
	
	Parameter(s):
		0: STRING - marker data from DD_fnc_markerToString
	
	Returns:
		STRING - created or edited marker
	
	Example:
		TODO: Adjust example
		["|marker_0|[4359.1,4093.51,0]|mil_objective|ICON|[1,1]|0|Solid|Default|1|An objective|2|0|3|_newMarker_0"] call RR_mapStuff_fnc_stringToMarker;
*/

params [["_markerData","",[""]]];

if (_markerData isEqualTo "") exitWith  {
	if (DD_markers_Debug) then {['ERROR', ['Marker data is empty, aborting marker creation']] call DD_fnc_diagLog};
};

_markerData splitString (_markerData select [0,1]) params [
	"_markerName", 
	"_markerPos", 
	"_markerShape",
	"_markerTypeOrPolyline",
	"_markerSize",
	"_markerDir",
	"_markerBrush",
	"_markerColor",
	"_markerAlpha",
	"_markerCreatorID",
	"_markerID",
	"_markerChannel",
	["_markerText",""]
];
_polylineArray = [];

_exit = false;
if (_markerShape isEqualTo "POLYLINE") then {
	_polylineArray = parseSimpleArray _markerTypeOrPolyline;
	if !(count _polylineArray >= 4 && count _polylineArray mod 2 == 0) then {_exit = true};
};
if (_exit) exitWith {if (DD_markers_Debug) then {['ERROR', ['Polyline data is invalid, aborting marker creation']] call DD_fnc_diagLog}};

createMarkerLocal [_markerName, parseSimpleArray _markerPos, parseNumber _markerChannel, player];

_markerName setMarkerShapeLocal _markerShape;

private _config = configFile >> "CfgMarkerColors" >> _markerColor;
	if (!isClass _config) then {
		_markerColor = configFile >> "CfgMarkerColors" >> "Default";
		if (DD_markers_Debug) then {['WARNING', ['CfgMarkerColors not found, changed to Default']] call DD_fnc_diagLog};
	};
_markerName setMarkerColorLocal _markerColor;

_markerName setMarkerAlphaLocal parseNumber _markerAlpha;

switch (_markerShape) do {
	case "POLYLINE": {
			_markerName setMarkerPolylineLocal _polylineArray;
		};
	default {
		_config = configFile >> "CfgMarkers" >> _markerTypeOrPolyline;
		if (!isClass _config) then {
			_markerTypeOrPolyline = configFile >> "CfgMarkers" >> "MilDot";
			if (DD_markers_Debug) then {['WARNING', ['CfgMarker not found, changed to milDot']] call DD_fnc_diagLog};
		};
		_markerName setMarkerTypeLocal _markerTypeOrPolyline;

		_markerName setMarkerSizeLocal parseSimpleArray _markerSize;
		_markerName setMarkerBrushLocal _markerBrush;
		_markerName setMarkerTextLocal _markerText;
		_markerName setMarkerDirLocal parseNumber _markerDir;
	};
};

if (isClass (configFile >> "CfgPatches" >> "ace_markers")) then {
	ace_markers_userPlacedMarkers pushBack _markerName;
};

_markerName 