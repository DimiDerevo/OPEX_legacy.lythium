/*
	example:
	[<object or position>, <markertype>, <markercolor>, <markertext>, <markerlifetime>] call Gemini_fnc_createMarker;

*/

// =========================================================================================================
// STARTING SCRIPT EXECUTION (SERVER ONLY)
// =========================================================================================================

	if (!isServer) exitWith {};

// =========================================================================================================
// CHECKING PARAMETERS
// =========================================================================================================

	params [
		["_markerData", [], [[]]],
		["_showTo", "all", [""]],
		["_markerLifetime", "distance", [""]],
		["_followUnit", objNull, [objNull, grpNull]]
	];
	_markerData params [
		["_markerName", "", [""]],
		["_markerPos", [0,0,0], [[]]], 
		["_markerShape", "ICON", [""]],
		["_markerType", "mil_dot", [""]],
		["_markerSize", [1,1], [[]]],
		["_markerDir", 0, [0]],
		["_markerBrush", "Solid", [""]],
		["_markerColor", "Default", [""]],
		["_markerAlpha", 1, [0]],
		["_markerText","", [""]]
	];
	_showTo = toLower _showTo;
	private _showTargets = [];

// =========================================================================================================
// CREATING MARKER
// =========================================================================================================
	if (_markerName == "") then {_markerName = format ["OPEX_marker_unnamed_%1", ceil random 100000]};
	private _markerName = createMarkerLocal [_markerName, _markerPos];

	_markerName setMarkerShapeLocal _markerShape;

	if (!isClass (configFile >> "CfgMarkerColors" >> _markerColor)) then {_markerColor = "Default"};
	_markerName setMarkerColorLocal _markerColor;

	if (!isClass (configFile >> "CfgMarkers" >> _markerType)) then {_markerType = "mil_dot"};
	_markerName setMarkerTypeLocal _markerType;

	_markerName setMarkerSizeLocal _markerSize;
	_markerName setMarkerBrushLocal _markerBrush;
	_markerName setMarkerDirLocal _markerDir;
	if (_markerText != "") then {_markerName setMarkerTextLocal _markerText};

	switch (_showTo) do {
		case "all": {_showTargets = (call BIS_fnc_listPlayers)};
		case "west": {_showTargets = (call BIS_fnc_listPlayers) select {side _x == west}};
		case "east": {_showTargets = (call BIS_fnc_listPlayers) select {side _x == east}};
		case "indep": {_showTargets = (call BIS_fnc_listPlayers) select {side _x == resistance}};
		case "civ": {_showTargets = (call BIS_fnc_listPlayers) select {side _x == civilian}};
		case "zeus": {_showTargets = OPEX_Zeuses};
	};
	_markerName setMarkerAlpha 0;
	[_markerName, _markerAlpha] remoteExec ["setMarkerAlphaLocal", _showTargets];

	if (_followUnit isNotEqualTo objNull) then {
		switch (typeName _followUnit) do {
			case "OBJECT": {
				[_markerName, _followUnit, _showTargets] spawn {
					params ["_markerName", "_followUnit", "_showTargets"];
					while {alive _followUnit} do {sleep 1;[_markerName, getPosATL _followUnit] remoteExec ["setMarkerPoslocal", _showTargets]};
					deleteMarker _markerName;
				};
			};
			case "GROUP": {
				[_markerName, _followUnit, _showTargets] spawn {
					params ["_markerName", "_followUnit", "_showTargets"];
					while {_followUnit isNotEqualTo grpNull} do {sleep 1;[_markerName, getPosATL (leader _followUnit)] remoteExec ["setMarkerPoslocal", _showTargets]};
					deleteMarker _markerName;
				};
			};
		};
	};

	[_markerName, _markerLifetime] call Gemini_fnc_setLifeTime; // setting marker life time

// =================================================================================================
// RETURNING CREATED MARKER
// =================================================================================================

	_markerName