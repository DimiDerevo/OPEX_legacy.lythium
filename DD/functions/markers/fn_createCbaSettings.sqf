//==============================================================================
//	General
//==============================================================================

[
    "DD_markers_EnableMapSharing", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
   	[localize "STR_DD_markers_EnableMapSharing_name", localize "STR_DD_markers_EnableMapSharing_desc"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [localize "STR_DD_markers_CBACategory_name", localize "STR_DD_markers_CBASubCategory1_name"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting: [min, max, default, number of shown trailing decimals]
    1 // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    "DD_markers_noTelepathicChannels", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "EDITBOX", // setting type
    [localize "STR_DD_markers_noTelepathicChannels_name", localize "STR_DD_markers_noTelepathicChannels_desc"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [localize "STR_DD_markers_CBACategory_name", localize "STR_DD_markers_CBASubCategory1_name"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    "[0, 1, 2, 3, 4, 5]", // data for this setting: [min, max, default, number of shown trailing decimals]
    1 // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

//==============================================================================
//	Direct Share
//==============================================================================

[
    "DD_markers_EnableDirectSharePtT", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
   	[localize "STR_DD_markers_EnableDirectSharePtT_name", localize "STR_DD_markers_EnableDirectSharePtT_desc"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [localize "STR_DD_markers_CBACategory_name", localize "STR_DD_markers_CBASubCategory2_name"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting: [min, max, default, number of shown trailing decimals]
    1 // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    "DD_markers_EnableDirectShareTtP", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
   	[localize "STR_DD_markers_EnableDirectShareTtP_name", localize "STR_DD_markers_EnableDirectShareTtP_desc"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [localize "STR_DD_markers_CBACategory_name", localize "STR_DD_markers_CBASubCategory2_name"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting: [min, max, default, number of shown trailing decimals]
    1 // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    "DD_markers_DirectShareDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    [localize "STR_DD_markers_DirectShareDistance_name", localize "STR_DD_markers_DirectShareDistance_desc"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [localize "STR_DD_markers_CBACategory_name", localize "STR_DD_markers_CBASubCategory2_name"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [1, 10, 2, 0], // data for this setting: [min, max, default, number of shown trailing decimals]
    1 // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

//==============================================================================
//	Ranged Share
//==============================================================================

[
    "DD_markers_EnableRangedShare", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    [localize "STR_DD_markers_EnableRangedShare_name", localize "STR_DD_markers_EnableRangedShare_desc"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [localize "STR_DD_markers_CBACategory_name", localize "STR_DD_markers_CBASubCategory3_name"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting: [min, max, default, number of shown trailing decimals]
    1 // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    "DD_markers_RangedShareDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    [localize "STR_DD_markers_RangedShareDistance_name", localize "STR_DD_markers_RangedShareDistance_desc"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [localize "STR_DD_markers_CBACategory_name", localize "STR_DD_markers_CBASubCategory3_name"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [1, 25, 6, 0], // data for this setting: [min, max, default, number of shown trailing decimals]
    1 // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

//==============================================================================
//	Compatibility
//==============================================================================

[
    "DD_markers_MapClassnames", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "EDITBOX", // setting type
    [localize "STR_DD_markers_MapClassnames_name", localize "STR_DD_markers_MapClassnames_desc"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [localize "STR_DD_markers_CBACategory_name", localize "STR_DD_markers_CBASubCategory4_name"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    '["ItemMap", "vn_b_item_map", "vn_o_item_map", "ItemGPS", "I_UavTerminal", "C_UavTerminal", "O_UavTerminal", "I_E_UavTerminal", "B_UavTerminal", "ACE_microDAGR"]', // data for this setting: [min, max, default, number of shown trailing decimals]
    1 // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

//==============================================================================
//	Debug
//==============================================================================

[
    "DD_markers_Debug", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    [localize "STR_DD_markers_Debug_name", localize "STR_DD_markers_Debug_desc"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [localize "STR_DD_markers_CBACategory_name", localize "STR_DD_markers_CBASubCategory5_name"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting: [min, max, default, number of shown trailing decimals]
    0 // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;