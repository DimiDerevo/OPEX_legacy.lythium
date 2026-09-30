params [
	["_roads", [], [[]]]
];

// Filtered by road width
_roads select {((getRoadInfo _x)#1) isNotEqualTo 0};