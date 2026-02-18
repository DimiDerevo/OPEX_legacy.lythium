if (!isServer) exitWith {};
private _allPlayers = [];
private _playersToAdd = [];

while {true} do
	{
		sleep 5; // updating list every 5 seconds
		_allPlayers = (call BIS_fnc_listPlayers) - entities "HeadlessClient_F";
		{
			{if !(alive _x) then {OPEX_playingPlayers deleteAt _forEachIndex}} forEachReversed OPEX_playingPlayers; 
			OPEX_playingPlayers deleteAt (_allPlayers inAreaArrayIndexes _x);
			_playersToAdd = _allPlayers - (_allPlayers inAreaArray _x);
			OPEX_playingPlayers insert [0, _playersToAdd , true];
		} forEach OPEX_locations_safe;
		publicVariable "OPEX_playingPlayers";

		OPEX_Zeuses = (call BIS_fnc_listPlayers) select {!(isNull getAssignedCuratorLogic _x)};
		publicVariable "OPEX_Zeuses";
	};