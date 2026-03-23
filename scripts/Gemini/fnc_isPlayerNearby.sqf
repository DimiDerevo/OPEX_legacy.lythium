private _entity = param [0, objNull, [objNull, []]];
private _distance = param [1, OPEX_spawnDistanceMaxi * 1.1, [0]]; if (typeName _entity isEqualTo "OBJECT") then {if (_entity isKindOf "Air") then {_distance = _distance * 4}};
private _pos = if (_entity isEqualType objNull) then {getPosATL _entity} else {_entity};
//if ({(_x distance2D _entity <= _distance) && (_x in _allPlayers)} count (allUnits) > 0) then {true} else {false};

if (count (OPEX_playingPlayers inAreaArray [_pos, _distance, _distance]) > 0) then {true} else {false};