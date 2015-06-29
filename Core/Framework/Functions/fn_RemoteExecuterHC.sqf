// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Function that executes a script of function remotely for whatever client you want
// *		This was made for simple usage of Headless Client spawning
// *
// *	Usage:
// *		[[Params for what being executed],"What to be Executed","how it show be executed"] call GOL_fnc_RemoteExecuterHC;
// *		[["Condition"],"Code"] call GOL_fnc_RemoteExecuterHC;
// *		[[1],GOL_Enemies,"spawn"] call GOL_fnc_RemoteExecuterHC;
// *		[["Spawn", 3, "defend", ["obj_1", 50, false], true, 0.3],GOL_fnc_AI_Inf_Group,"call"] call GOL_fnc_RemoteExecuterHC;
// *
// *	Parameters:
// *	0:	-	Array:	This is the array of whatever you are executing.
// *			In other words, if you are executing something that needs params this is where you should put them
// *	1:	-	String:	What to be executed, Name of Function or path for Script
// *	2:	-	String:	This indicates how @Param:0 is to be executed
// *			-	Script = 0
// *			-	function - Call  = 1
// *			-	function - Spawn = 2 - Default Value
// *			-	function - Code  = 3
// *
// *
// *	Returning Value:
// *		Nothing
// *
// ================================================================

	if (!isServer) exitWith {false};		// Ensures only server runs

	if (HeadlessVariable && isMultiplayer) Then {
		[[[(_this select 0),(_this select 1),(_this select 2)], {

			private ["_function","_type","_params","_caller","_Script","_execute"];
			_params = [_this, 0, []] call BIS_fnc_param;	//	Spawns Script or Function with params
			_function = [_this, 1, "", ["",{}]] call BIS_fnc_param;	//	What to be executed
			_type = toLower ([_this, 2, "spawn", [""]] call BIS_fnc_param);	//	Decides if it is a Script / Function

			//	SCRIPTS
			if (_type isEqualTo "execVM" || _type isEqualTo "exec") then {
				_Script call compile _function;
				_execute = _params execVM _Script;
			};
			//	Functions - Call
			if (_type isEqualTo "call") then {
				_execute = _params call _function;
			};
			//	Functions - Spawn
			if (_type isEqualTo "spawn") then {
				_execute = _params spawn _function;
			};
			//	Functions - Code
			if (_type isEqualTo "code") then {
				_execute = _function;
			};
		}], "BIS_fnc_call", HCSlot] call BIS_fnc_MP;

	} else {

		private ["_function","_type","_params","_caller","_Script","_execute"];
		_params = [_this, 0, []] call BIS_fnc_param;	//	Spawns Script or Function with params
		_function = [_this, 1, "", ["",{}]] call BIS_fnc_param;	//	What to be executed
		_type = toLower ([_this, 2, "spawn", [""]] call BIS_fnc_param);	//	Decides if it is a Script / Function

		//	SCRIPTS
		if (_type isEqualTo "execVM" || _type isEqualTo "exec") then {
			_Script call compile _function;
			_execute = _params execVM _Script;
		};
		//	Functions - Call
		if (_type isEqualTo "call") then {
			_execute = _params call _function;
		};
		//	Functions - Spawn
		if (_type isEqualTo "spawn") then {
			_execute = _params spawn _function;
		};
		//	Functions - Code
		if (_type isEqualTo "code") then {
			_execute = _function;
		};
	};
