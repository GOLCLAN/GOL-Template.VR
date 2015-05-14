// ====================================================================================
// *
// *	Author: GuzzenVonLidl
// *
// *	Description:
// *		Retrieves any config value.
// *
// *	Usage:
// *		["Gear", "Blufor"] call GVL_Fnc_GetConfig
// *
// *	Parameter(s):
// *		#0	String:		Gets the config Value for the framework settings
// *		#1	String:		Gets the sub config Value for the framework settings
// *
// *	Returning Value:
// *		Number - Config value
// ====================================================================================

	private ["_DebugName","_module","_config"];

	_DebugName = "GVL_Fnc_GetConfig";
	scriptName _DebugName;

	_module = _this select 0;
	_config = _this select 1;

	if (["GVL_FRAMEWORK", "Modules"] call Bis_fnc_getCfgIsClass) then {
		if (["GVL_FRAMEWORK", "Modules", _module] call Bis_fnc_getCfgIsClass) then {
			["GVL_FRAMEWORK", "Modules", _module, _config] call BIS_fnc_getCfgData;
		} else {
			["GVL_FRAMEWORK", "Modules", _module] call BIS_fnc_getCfgData;
		};
	} else {
		[["Error config: %1 does not exist", _module],[_DebugName,__FILE__,__LINE__],"log"] call GVL_Fnc_DebugLog;
	};
