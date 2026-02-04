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

// Channels:
// 0 = Global
// 1 = side
// 2 = Command
// 3 = Group
// 4 = Vehicle
// 5 = Direct

["INFO", ["Init Started"]] call DD_fnc_diagLog;

[] call DD_fnc_createCbaSettings;
[] call DD_fnc_createAceAction;

DD_markers_CounterLocal = 0;
DD_markers_AllowRecieving = false;
DD_markers_AllowCopying = false;

addMissionEventHandler ["MarkerCreated", {
	params ["_marker", "_channelNumber", "_owner", "_local"];

	if(!_local && _owner != player  && _channelNumber in parseSimpleArray DD_markers_noTelepathicChannels) then {
		deleteMarkerLocal _marker;
		if (DD_markers_Debug) then {["DEBUG", ["Remote marker in channel ID ", _channelNumber, "deleted by script: ", _marker]] call DD_fnc_diagLog};
	};
}];

// [] spawn {
// 	if (isServer && hasInterface) then {
//         [] spawn {
//             waitUntil {!isNull (findDisplay 52)}; 
//             {
// 				if (_x select [0,15] == "_USER_DEFINED #") then {deleteMarkerLocal _x;};
// 			} forEach allMapMarkers;
//         };
//     };
//     if (!isServer) then {
//         [] spawn {
//             waitUntil {!isNull (findDisplay 53)}; 
//             {
// 				if (_x select [0,15] == "_USER_DEFINED #") then {deleteMarkerLocal _x;};
// 			} forEach allMapMarkers;
//         };
//     };
//     [] spawn {
//         waitUntil {!isNull (findDisplay 12)}; 
//         {
// 			if (_x select [0,15] == "_USER_DEFINED #") then {deleteMarkerLocal _x;};
// 		} forEach allMapMarkers;
//     };
// };

["INFO", ["Init Finished"]] call DD_fnc_diagLog;