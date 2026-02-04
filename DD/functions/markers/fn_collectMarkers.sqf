/*
	Author: 
		DimiDerevo
	
	Description:
		-
	
	Parameter(s):
		0: STRING - 
	
	Returns:
		STRING - created marker 
		
	
	Example:

*/

_markersInArea = allMapMarkers;
_collectedMarkers = [];

{
	// Current result is saved in variable _x
	if (_x select [0,15] == "_USER_DEFINED #") then {
		_collectedMarkers pushBack (_x call DD_fnc_markerToString);
	};
} forEach _markersInArea;

if (DD_markers_Debug) then {["DEBUG", ["Local markers collected: ", _collectedMarkers]] call DD_fnc_diagLog};

_collectedMarkers;