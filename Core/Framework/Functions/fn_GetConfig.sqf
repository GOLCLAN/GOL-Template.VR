// ====================================================================================
// *
// *	Author: GuzzenVonLidl
// *
// *	Description:
// *		Retrieves any config value.
// *
// *	Usage:
// *		["Gear", "Blufor"] call GOL_Fnc_GetConfig
// *
// *	Parameter(s):
// *		#0	String:		Gets the config Value for the framework settings
// *		#1	String:		Gets the sub config Value for the framework settings
// *
// *	Returning Value:
// *		Number - Config value
// ====================================================================================

	private ["_DebugName","_module","_config"];

	_DebugName = "GOL_Fnc_GetConfig";
	scriptName _DebugName;

	_module = (_this select 0);
	_config = (_this select 1);

	switch (count _this) do {

		case 1: {
			["GOL_FRAMEWORK", "Modules", _module] call BIS_fnc_getCfgData;
		};

		case 2: {
			["GOL_FRAMEWORK", "Modules", _module, _config] call BIS_fnc_getCfgData;
		};

		default {
			if !(isClass (missionConfigFile >> "GOL_FRAMEWORK" >> "Modules" >> _module)) exitWith {
				[["Error config: %1 does not exist", _module],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
				false
			};
		};
	};
