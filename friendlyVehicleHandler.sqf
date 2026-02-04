// _this execVM "friendlyVehicleHandler.sqf";

params ["_vehicle"];

_class = typeOf _vehicle;

if (_class in OPEX_friendly_vehicle_variants) then {
	_intersect = -1;
	_intersect = OPEX_friendly_vehicle_variants findIf {_class == _x };
	if (_intersect > -1) then {
		OPEX_friendly_vehicle_variants deleteAt _intersect;
		[systemChat format ["%1 was removed from the faction.", _class]]remoteExec ["execVM", 0];
		};
} else {
	OPEX_friendly_vehicle_variants pushBackUnique _class;
	[systemChat format ["%1 was added to faction.", _class]]remoteExec ["execVM", 0];
};