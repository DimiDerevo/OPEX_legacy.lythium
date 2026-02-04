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

params ["_target"];

private _inventory = assignedItems _target + uniformItems _target + vestItems _target + backpackItems _target;
private _hasMap = false;
{
	if (_x in _inventory) then {_hasMap = true};
} forEach parseSimpleArray DD_markers_MapClassnames;
_hasMap;