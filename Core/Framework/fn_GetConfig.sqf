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

	_module = _this select 0;
	_config = _this select 1;

	if (["GOL_FRAMEWORK", "Modules"] call Bis_fnc_getCfgIsClass) then {
		if (["GOL_FRAMEWORK", "Modules", _module] call Bis_fnc_getCfgIsClass) then {
			["GOL_FRAMEWORK", "Modules", _module, _config] call BIS_fnc_getCfgData;
		} else {
			["GOL_FRAMEWORK", "Modules", _module] call BIS_fnc_getCfgData;
		};
	} else {
		[["Error config: %1 does not exist", _module],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
	};
