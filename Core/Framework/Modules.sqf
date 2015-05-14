
// ================================================================
	private ["_LogicCenter","_moduleGroup","_module"];
	_LogicCenter = createCenter sideLogic;
	_moduleGroup = createGroup _LogicCenter;

// ================================================================
	if (isClass(configFile>>"CfgPatches">>"ace_dragging")) then {
		ACE_maxWeightDrag = 50000; // Removes weight limit
	};

	if (isClass(configFile>>"CfgPatches">>"A3_Modules_F_Curator")) then {

		_module = _moduleGroup createUnit["ModuleCurator_F",[0,0,0],[],0,"NONE"];
		_module setVariable ["Owner", "#adminLogged", true];
		_module setVariable ["Name", "Admin", true];
		_module setVariable ["Addons", 2, true];
		_module setVariable ["Forced", 0, true];
		_module setvariable ["birdType","LaserTargetCBase", true];
		_module setvariable ["bis_fnc_curatorSystem_points",1000];

			GOL_ZeuzModuleAdminLogged = _module;
			GOL_Gamelogic = _moduleGroup createUnit["Logic",[0,0,0],[],0,"NONE"];
		[] spawn {
			publicVariable "GOL_ZeuzModuleAdminLogged";
			publicVariable "GOL_Gamelogic";
		};
	};
//	[GOL_Gamelogic] call GOL_Fnc_CacheObjects;
//	[GOL_Gamelogic] call GOL_Fnc_CacheVehicles;
/*
	if (["Cache","Enabled"] call GOL_Fnc_GetConfig == 1) then {
		[GOL_Gamelogic] call GOL_Fnc_FPS_Manager;
	};

	if (["Lightning"] call GOL_Fnc_GetConfig == 1) then {
		GOL_Lightning_Active = true;
	};
*/
	GOL_Gamelogic_Local = "Logic" createVehicleLocal [0,0,0];

// ================================================================

	private ["_DebugName"];
	_DebugName = "GOL-Modules";
	scriptName _DebugName;

	["FRAMEWORK MODULES INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
