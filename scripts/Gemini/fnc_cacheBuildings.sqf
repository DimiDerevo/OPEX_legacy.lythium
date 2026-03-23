private _isEnterable = {[_x, 3] call BIS_fnc_isBuildingEnterable};
private _isNotBlacklisted = {!((typeOf _x) in ["Land_HouseV2_03", "Land_Nasypka", "Land_Pier_F", "Land_Radar_F"])};
private _isNotMilitary = {!((["cargo", typeOf _x] call BIS_fnc_inString) || (["office", typeOf _x] call BIS_fnc_inString))};
private _isNotInSafeArea = {!([_x] call Gemini_fnc_isInSafeLocation)};
private _allConditions = {call _isEnterable && call _isNotBlacklisted && call _isNotMilitary  && call _isNotInSafeArea};

private _selectedBuildings = [];
{
	if (_x call _allConditions) then {_selectedBuildings pushBackUnique [str (getPosWorld _x), true]};
} forEach (nearestTerrainObjects [[worldSize / 2, worldSize / 2, 0], ["House"], sqrt 2 / 2 * worldSize]);
OPEX_validBuildings = createHashMapFromArray _selectedBuildings;