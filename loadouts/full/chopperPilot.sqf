// ----------------------------------------------------------------------
// GETTING UNIT
// ----------------------------------------------------------------------

	params ["_unit"];

// ----------------------------------------------------------------------
// REMOVING DEFAULT LOADOUT
// ----------------------------------------------------------------------

	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;
	removeAllContainers _unit;
	

// ----------------------------------------------------------------------
// ADDING CLOTHES
// ----------------------------------------------------------------------

	// UNIFORM
	_unit forceAddUniform (selectRandom OPEX_friendly_heliPilotUniforms);
	[_unit] spawn Gemini_fnc_setUnitInsigna;
	
	// VEST
	_unit addVest (selectRandom OPEX_friendly_beltVests);
	
	// HEADGEAR
	_unit addHeadgear (selectRandom OPEX_friendly_heliPilotHelmets);

// ----------------------------------------------------------------------
// ADDING RIFLE
// ----------------------------------------------------------------------

	// RIFLE
	_rifle = selectRandom OPEX_friendly_compactRifles;
	[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_rifleMagazine = (getArray (configfile >> "CfgWeapons" >> _rifle >> "magazines")) select 0;
	for "_i" from 1 to 3 do {_unit addItemToVest _rifleMagazine};

	// OPTIC
	_unit addPrimaryWeaponItem "BWA3_optic_RSAS";

	// // FLASHLIGHT
	// _compatibleRifleFlashlights = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_flashlights};
	// if (count _compatibleRifleFlashlights > 0) then {if (random 1 > 0.5) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleFlashlights)} else {_unit addItemToBackpack (selectRandom _compatibleRifleFlashlights)}};

	// // SILENCER
	// _compatibleRifleSilencers = ([_rifle, 2] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_rifleSilencers};
	// if (count _compatibleRifleSilencers > 0) then {_unit addItemToBackpack (selectRandom _compatibleRifleSilencers)};


// ----------------------------------------------------------------------
// ADDING HANDGUN
// ----------------------------------------------------------------------

	// // HANDGUN
	// _handgun = selectRandom OPEX_friendly_commonHandguns;
	// [_unit, _handgun] call Gemini_fnc_addLoadedWeapon;

	// // ADDITIONAL MAGAZINES
	// _handgunMagazine = (getArray (configfile >> "CfgWeapons" >> _handgun >> "magazines")) select 0;
	// for "_i" from 1 to 1 do {_unit addItemToVest _handgunMagazine};

// ----------------------------------------------------------------------
// ADDING NVG / BINOCULAR / RADIO / MAP / COMPASS / GPS / WATCH
// ----------------------------------------------------------------------

	// NVG
	_unit linkItem (selectRandom OPEX_friendly_NVGs);

	// RADIO
	_unit addItemToUniform (selectRandom OPEX_friendly_radiosShortDistance);

	// MAP
	_unit linkItem "ItemMap";

	// COMPASS
	_unit linkItem "ItemCompass";

	// GPS
	// _unit linkItem "ItemGPS";

	// WATCH
	_unit linkItem "ItemWatch";

// ----------------------------------------------------------------------
// ADDING OTHER STUFF
// ----------------------------------------------------------------------

	{_unit addItemToUniform _x} forEach OPEX_medical_AI_IFAK;

	// EARPLUGS
	if (count OPEX_friendly_earplugs > 0) then {_unit addItemToUniform (selectRandom OPEX_friendly_earplugs)};

	// IR / CHEMLIGHTS / SMOKE GRENADES
	for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_IRs)};
	for "_i" from 1 to 3 do {_unit addItemToVest (selectRandom OPEX_friendly_chemlights)};
	for "_i" from 1 to 3 do {_unit addItemToVest (selectRandom OPEX_friendly_smokeGrenades_colors)};

// ----------------------------------------------------------------------
// SETTING SKILLS
// ----------------------------------------------------------------------

	_unit setSkill ["spotDistance", 1];

// ----------------------------------------------------------------------
// HOLSTERING WEAPON
// ----------------------------------------------------------------------

	_unit action ["SwitchWeapon", _unit, _unit, 100];