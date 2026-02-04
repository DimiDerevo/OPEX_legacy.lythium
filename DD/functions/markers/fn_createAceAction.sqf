// private _action = [
// 	"DD_markers_mainMapSharingActionNode", // 0: Action name <STRING>
// 	"Map Sharing", // 1: Name of the action shown in the menu <STRING>
// 	"", // 2: Icon file path or Array of icon file path and hex color ("" for default icon) <STRING or ARRAY>
// 	{}, // 3: Statement <CODE>
// 	{[_target] call DD_fnc_hasMap && [_player] call DD_fnc_hasMap}, // 4: Condition <CODE>
// 	{}, // 5: Insert children code <CODE> (default: {})
// 	[], // 6: Action parameters <ANY> (default: [])
// 	{[0, 0, 0]}, // 7: Position (Position array, Position code or Selection Name) <ARRAY or CODE or STRING> (default: {[0, 0, 0]})
// 	2, // 8: Distance <NUMBER> (default: 2)
// 	[false, false, false, false, false], // 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (default: all false)
// 	{} // 10: Modifier function <CODE> (default: {})
// ] call ace_interact_menu_fnc_createAction;

// private _mainMapSharingActionNode = [
// 	"CAManBase", // 0: TypeOf of the class <STRING>
//   	0, // 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
//   	["ACE_MainActions"], // 2: Parent path of the new action <ARRAY>
//   	_action, // 3: Action <ARRAY>
//   	true // 4: Use Inheritance <BOOL> (default: false)
//   	 // 5: Classes excluded from inheritance (children included) <ARRAY> (default: [])
// ] call ace_interact_menu_fnc_addActionToClass;


//if (DD_markers_Debug = true) then {["DEBUG", ["Creating ACE Actions Started"]] call DD_fnc_diagLog};

private _action = "";

// Note: PtT = PlayerToTarget, TtP = TargetToPlayer

//==============================================================================
//	Normal interactions
//==============================================================================

// Main node
_action = ["DD_markers_MainActionNode_action", localize "STR_DD_markers_MainActionNode_action_name", "",
	{},
	{[_target] call DD_fnc_hasMap && [_player] call DD_fnc_hasMap && DD_markers_EnableMapSharing && DD_markers_EnableDirectSharePtT || DD_markers_EnableDirectShareTtP},
	{}, [], {[0, 0, 0]}, DD_markers_DirectShareDistance,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_MainActionNode = [
	"CAManBase", 0,
	["ACE_MainActions"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

// Share map
_action = ["DD_markers_DirectShare_PtT_action", localize "STR_DD_markers_DirectShare_PtT_action_name", "",
	{[0, _target, _player] call DD_fnc_sendLocalMarkersToTarget},
	{[_target] call DD_fnc_hasMap && [_player] call DD_fnc_hasMap && DD_markers_EnableMapSharing && DD_markers_EnableDirectSharePtT},
	{}, [], {[0, 0, 0]}, DD_markers_DirectShareDistance,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_DirectShare_PtT = [
	"CAManBase", 0,
	["ACE_MainActions", "DD_markers_MainActionNode_action"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

// Copy map
_action = ["DD_markers_DirectShare_TtP_action", localize "STR_DD_markers_DirectShare_TtP_action_name", "",
	{[1, _target, _player] call DD_fnc_requestRemoteMarkersFromTarget},
	{[_target] call DD_fnc_hasMap && [_player] call DD_fnc_hasMap && DD_markers_EnableMapSharing && DD_markers_EnableDirectShareTtP},
	{}, [], {[0, 0, 0]}, DD_markers_DirectShareDistance,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_DirectShare_TtP = [
	"CAManBase", 0,
	["ACE_MainActions", "DD_markers_MainActionNode_action"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

//==============================================================================
//	Self Interactions
//==============================================================================

// Main node
_action = ["DD_markers_MainSelfActionNode_action", localize "STR_DD_markers_MainSelfActionNode_action_name", "",
	{},
	{DD_markers_EnableMapSharing},
	{}, [], {[0, 0, 0]}, 2,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_MainSelfActionNode = [
	"CAManBase", 1,
	["ACE_SelfActions"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

// Settings node
_action = ["DD_markers_Settings_action", localize "STR_DD_markers_Settings_action_name", "",
	{},
	{DD_markers_EnableMapSharing},
	{}, [], {[0, 0, 0]}, 2,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_Settings = [
	"CAManBase", 1,
	["ACE_SelfActions", "DD_markers_MainSelfActionNode_action"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

// Allow Recieving
_action = ["DD_markers_AllowRecieving_action", localize "STR_DD_markers_AllowRecieving_action_name", "",
	{DD_markers_AllowRecieving = true; hint localize "STR_DD_markers_AllowRecieving_action_desc";},
	{DD_markers_EnableMapSharing && DD_markers_AllowRecieving == false},
	{}, [], {[0, 0, 0]}, 2,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_AllowRecieving = [
	"CAManBase", 1,
	["ACE_SelfActions", "DD_markers_MainSelfActionNode_action", "DD_markers_Settings_action"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

// Disallow Recieving
_action = ["DD_markers_DisallowRecieving_action", localize "STR_DD_markers_DisallowRecieving_action_name", "",
	{DD_markers_AllowRecieving = false; hint localize "STR_DD_markers_DisallowRecieving_action_desc";},
	{DD_markers_EnableMapSharing && DD_markers_AllowRecieving == true},
	{}, [], {[0, 0, 0]}, 2,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_DisallowRecieving = [
	"CAManBase", 1,
	["ACE_SelfActions", "DD_markers_MainSelfActionNode_action", "DD_markers_Settings_action"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

// Allow Copying
_action = ["DD_markers_AllowCopying_action", localize "STR_DD_markers_AllowCopying_action_name", "",
	{DD_markers_AllowCopying = true; hint localize "STR_DD_markers_AllowCopying_action_desc";},
	{DD_markers_EnableMapSharing && DD_markers_AllowCopying == false},
	{}, [], {[0, 0, 0]}, 2,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_AllowCopying = [
	"CAManBase", 1,
	["ACE_SelfActions", "DD_markers_MainSelfActionNode_action", "DD_markers_Settings_action"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

// Disallow Copying
_action = ["DD_markers_DisallowCopying_action", localize "STR_DD_markers_DisallowCopying_action_name", "",
	{DD_markers_AllowCopying = false; hint localize "STR_DD_markers_DisallowCopying_action_desc";},
	{DD_markers_EnableMapSharing && DD_markers_AllowCopying == true},
	{}, [], {[0, 0, 0]}, 2,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_DisallowCopying = [
	"CAManBase", 1,
	["ACE_SelfActions", "DD_markers_MainSelfActionNode_action", "DD_markers_Settings_action"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

// Share Map Nearby
_action = ["DD_markers_ShareMapNearby_action", localize "STR_DD_markers_ShareMapNearby_action_name", "",
	{},
	{DD_markers_EnableMapSharing && DD_markers_EnableRangedShare && [_player] call DD_fnc_hasMap},
	{}, [], {[0, 0, 0]}, 2,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_ShareMapNearby = [
	"CAManBase", 1,
	["ACE_SelfActions", "DD_markers_MainSelfActionNode_action"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

// Confirm Share
_action = ["DD_markers_ShareMapNearbyConfirm_action", localize "STR_DD_markers_ShareMapNearbyConfirm_action_name", "",
	{[2, _player] call DD_fnc_sendLocalMarkersToNearby},
	{DD_markers_EnableMapSharing && DD_markers_EnableRangedShare && [_player] call DD_fnc_hasMap},
	{}, [], {[0, 0, 0]}, 2,
	[false, false, false, false, false], {}
] call ace_interact_menu_fnc_createAction;
DD_markers_AceInteract_ShareMapNearbyConfirm = [
	"CAManBase", 1,
	["ACE_SelfActions", "DD_markers_MainSelfActionNode_action", "DD_markers_ShareMapNearby_action"],
	_action, true
] call ace_interact_menu_fnc_addActionToClass;

//if (DD_markers_Debug) then {["DEBUG", ["Creating ACE Actions Finished"]] call DD_fnc_diagLog};