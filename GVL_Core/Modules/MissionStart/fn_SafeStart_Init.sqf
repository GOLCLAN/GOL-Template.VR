// ====================================================================================
// *
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Defines the vehicle as a mhq and makes you able to teleport to it
// *
// *	Usage:
// *		[this] call GVL_Fnc_MHQ_Init;
// *
// *	Parameters:
// *		0: Vehicle
// *
// *	Returning Value:
// *		None
// *
// ====================================================================================

	if (!isServer) exitWith {false};
	private ["_time"];
	_time = ("GVL_Params_SafeStart" call BIS_fnc_getParamValue);
	if (_time > 0) then {
		GVL_Gamelogic setVariable ["GVL_SafeStart_Active", true, true];
		for "_i" from (_time) to 0 step -1 do {

			if (_i >= 1) then {
				[[[_i], {
					systemChat format ["SAFE START: Time Remaining until weapons are live: %1 min", (_this select 0)];
				}], "bis_fnc_call", true] call BIS_fnc_MP;
			};

			if ((_i == 0) && (GVL_Gamelogic getVariable "GVL_SafeStart_Active")) exitWith {
				GVL_Gamelogic setVariable ["GVL_SafeStart_Active", false, true];
				[[[], {
					systemChat "SAFE START: Is now Active!";
					[] spawn GVL_fnc_SafeStart;
				}], "bis_fnc_call", true] call BIS_fnc_MP;
			};

			sleep 60;
	    };

	} else {
		GVL_Gamelogic setVariable ["GVL_SafeStart_Active", false, true];
	};
