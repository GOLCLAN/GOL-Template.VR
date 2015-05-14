
	if (!hasInterface) exitWith {false};
	if ([] call BIS_fnc_didJIP) then {
	    waitUntil {sleep 0.1; !isNull player};
	};
    waitUntil {time > 0};
	private ["_time","_DebugName"];

	If (!isMultiplayer) exitWith {
		player enableSimulation true;
		disableUserInput false;
	};
	player enableSimulation false;
	disableUserInput true;

	_time = [_this, 0, 10, [0]] call BIS_fnc_Param;

	titleText ["Please wait in order to allow the game to synchronize with all players.", "BLACK FADED",0];

    waitUntil {sleep 0.1; !isNull AGM_player};
	[_time, [], "{}", "Loading mission", "{ [_time - time] Spawn GVL_Fnc_PlayerSync; }"] call AGM_Core_fnc_progressBar;

	sleep (_time);
	titleText ["","PLAIN",0];
	GVL_playerSync = true;

	//==============================================================================

	// Mission starts here.
	player enableSimulation true;
	disableUserInput false;

    [[[player], { (_this select 0) setGroupId [((_this select 0) getVariable "GVL_GroupID")]; }], "bis_fnc_call", true, true] call BIS_fnc_MP;
	_DebugName = "GVL-PlayerSync";
	scriptName _DebugName;
	[["Completed after %1 Seconds",time - startTime],[_DebugName,__FILE__,__LINE__],"log"] call GVL_Fnc_DebugLog;
