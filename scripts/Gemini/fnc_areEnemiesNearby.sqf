params [
	["_pos", [], [[]], [2,3]],
	["_sidesToCheck", []],
	["_radius", OPEX_spawnDistanceMini, [0]]
];

if ((allUnits findIf {((side _x) in _sidesToCheck) && {(_x distance2d _pos) < _radius}}) isEqualTo -1) then {
	false
} else {
	true
};