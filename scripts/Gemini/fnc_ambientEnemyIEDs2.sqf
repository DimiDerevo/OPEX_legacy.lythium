private _player = selectRandom OPEX_playingPlayers;

// LOOKING FOR A RANDOM ROAD AROUND SELECTED PLAYER
private _roadPos = ["road", _player, OPEX_spawnDistanceMini, OPEX_spawnDistanceMaxi * 0.9] call Gemini_fnc_findPos;
if (_roadPos isEqualTo [0,0,0]) exitWith {};
private _road = (_roadPos nearRoads 15) select 0;
_roadPos = (_road modelToWorld [((boundingBox _road) select 1 select 0) * 0.9, 0, 0]); // returning a position at the side of the road

// SPAWNING IED
private _IED = createMine [selectRandom ["IEDLandBig_F", "IEDLandSmall_F", "IEDUrbanBig_F", "IEDUrbanSmall_F"], _roadPos, [], 0];
_IED setPosATL [(getPos _IED select 0), (getPos _IED select 1), 0];

// SETTING IED TYPE
private _triggerType = selectRandom ["none","cellphone","remote","proximity","proximity"];
switch _triggerType do
	{
		case "none"			:	{[_IED, position _IED] spawn OPEX_IED_trigger_none};
		case "remote"		:	{[_IED, position _IED] spawn OPEX_IED_trigger_remote};
		case "cellphone"	:	{[_IED, position _IED] spawn OPEX_IED_trigger_cellphone};
		case "proximity"	:	{[_IED, position _IED] spawn OPEX_IED_trigger_proximity};
		case default			{[_IED, position _IED] spawn OPEX_IED_trigger_none};
	};

OPEX_ambientEnemyIEDs = OPEX_ambientEnemyIEDs + 1; publicVariable "OPEX_ambientEnemyIEDs";

[_roadPos, _IED] spawn {
	params ["_roadPos", "_IED"];
	waitUntil {sleep 5; ((_roadPos call Gemini_fnc_isUnplayedArea) || (!alive _IED))};
	OPEX_ambientEnemyIEDs = OPEX_ambientEnemyIEDs - 1; publicVariable "OPEX_ambientEnemyIEDs";
};

// DEBUGGING
if (OPEX_debug) then
	{
		systemChat "AMBIENT IED READY !";
		switch _triggerType do
			{
				case "none"			:	{[[format ["OPEX_debugMarker_ambient_%1", random 100000], _roadPos, "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "IED (no trigger)"], "zeus", "distance"] spawn Gemini_fnc_createMarker2};
				case "remote"		:	{[[format ["OPEX_debugMarker_ambient_%1", random 100000], _roadPos, "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "IED (remote trigger)"], "zeus", "distance"] spawn Gemini_fnc_createMarker2};
				case "cellphone"	:	{[[format ["OPEX_debugMarker_ambient_%1", random 100000], _roadPos, "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "IED (cellphone trigger)"], "zeus", "distance"] spawn Gemini_fnc_createMarker2};
				case "proximity"	:	{[[format ["OPEX_debugMarker_ambient_%1", random 100000], _roadPos, "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "IED (proximity trigger)"], "zeus", "distance"] spawn Gemini_fnc_createMarker2};
				case default			{[[format ["OPEX_debugMarker_ambient_%1", random 100000], _roadPos, "ICON", "mil_warning", [0.8, 0.8], 0, "Solid", "ColorRed", 1, "IED (no trigger)"], "zeus", "distance"] spawn Gemini_fnc_createMarker2};
			};
	};