if (OPEX_playingPlayers isEqualTo []) exitWith {};
private _player = selectRandom OPEX_playingPlayers;
private _playerPos = position _player;

private _ambientCivsCount = OPEX_ambientCivilianMan;
private _ambientCivsMaxCount = OPEX_ambientCivilianManMax;

// LOOKING FOR NEARBY BUILDINGS
private _nearbyBuildings = [_player, OPEX_spawnDistanceMaxi] call Gemini_fnc_findBuildings; if (count _nearbyBuildings == 0) exitWith {};

// DEFINING LOCATION POPULATION AMOUNT
private _maxCiviliansPerLocation = 2 max (round (count _nearbyBuildings / 5)); // ratio = 1 civilian for 5 houses
private _maxCiviliansNearby = _maxCiviliansPerLocation min 75; // maximum 75 civilians per location

// CHECKING IF THE LOCATION HASN'T BEEN POPULATED ALREADY
private _nearbyCivilians = (_player nearEntities ["CAManBase", OPEX_spawnDistanceMaxi]) select {(alive _x) && (side _x == civilian) && (!isPlayer _x) && (_x isKindOf "Man") && (!(_x call Gemini_fnc_isInSafeLocation))};
if (count _nearbyCivilians >= _maxCiviliansNearby) exitWith {};

// DEBUGGING
if (OPEX_debug) then {systemChat format ["[AMBIENT CIVILIAN LIFE] ALIVE CIVILIANS: %1/%2 (POTENTIAL: %3)", _ambientCivsCount, _ambientCivsMaxCount, _ambientCivsMaxCount - _ambientCivsCount]};

// POPULATING LOCATION
for "_i" from 1 to ((_maxCiviliansNearby - count _nearbyCivilians) min 30) do {
	sleep 0.1; // TODO: check and maybe remove distance check
	if (_player distance2D _playerPos > 100) exitWith {}; // canceling current spawn process if player has moved too far from its initial position
	if (_ambientCivsCount < _ambientCivsMaxCount) then {
		// LOOKING FOR A POSITION INSIDE A BUILDING
		private _randomBuilding = selectRandom _nearbyBuildings;
		private _buildingPositions = _randomBuilding buildingPos -1;
		private ["_randomPos"];
		if (count _buildingPositions > 0)
		then {_randomPos = selectRandom _buildingPositions}
		else {_randomPos = [[[position _randomBuilding, 50]],["water"]] call BIS_fnc_randomPos};
		// SPAWNING CIVILIAN
		private _civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _randomPos, OPEX_civilian_AIskill] call Gemini_fnc_createUnit;
	};
};