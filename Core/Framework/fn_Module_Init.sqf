
// ================================================================
	private ["_LogicCenter","_moduleGroup","_module"];
	_LogicCenter = createCenter sideLogic;
	_moduleGroup = createGroup _LogicCenter;

// ================================================================

	if (isClass(configFile>>"CfgPatches">>"AGM_Interaction")) then {

		_module = _moduleGroup createUnit ["AGM_ModuleInteraction", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["EnableTeamManagement", true, true];
			GOL_Module_Interaction = _module;
		[] spawn {
			publicVariable "GOL_Module_Interaction";
		};
	};

// ================================================================

	if (isClass(configFile>>"CfgPatches">>"AGM_Logistics")) then {

		_module = _moduleGroup createUnit ["AGM_ModuleRepair", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["TimeRepair", 5, true];
		_module setVariable ["TimeWheelRepair", 5, true];
		_module setVariable ["TimeTrackRepair", 10, true];
		_module setVariable ["MaxDamageRepair", 0.9, true];
			GOL_Module_Logistic = _module;
			AGM_Drag_MaxWeight = 100000;
		[] spawn {
			publicVariable "GOL_Module_Logistic";
			publicVariable "AGM_Drag_MaxWeight";
		};
	};

// ================================================================

	if (isClass(configFile>>"CfgPatches">>"AGM_Medical")) then {

		_module = _moduleGroup createUnit ["AGM_ModuleMedical", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["CoefDamage", 1.0, true];
		_module setVariable ["CoefBleeding", 1.0, true];
		_module setVariable ["CoefPain", 2.0, true];
		_module setVariable ["CoefNonMedic", 1.7, true];
		_module setVariable ["MaxUnconsciousnessTime", -1, true];
		_module setVariable ["TypeMEDEVAC", 1, true];
		_module setVariable ["AllowNonmedics", true, true];
		_module setVariable ["RequireDiagnosis", true, true];
		_module setVariable ["PreventInstaDeath", false, true];
		_module setVariable ["PreventDeathWhileUnconscious", false, true];
		_module setVariable ["SingleBandage", false, true];
		_module setVariable ["AllowChatWhileUnconscious", true, true];
		_module setVariable ["EnableOverdosing", true, true];
		_module setVariable ["RequireMEDEVAC", false, true];
		_module setVariable ["AutomaticWakeup", true, true];
		_module setVariable ["DisableScreams", false, true];
			GOL_Module_Medical = _module;
		[] spawn {
			publicVariable "GOL_Module_Medical";
		};
	};

// ================================================================

	if (isClass(configFile>>"CfgPatches">>"AGM_Respawn")) then {

		_module = _moduleGroup createUnit ["AGM_ModuleRespawn", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["RemoveDeadBodiesDisonncected", false, true];
		_module setVariable ["SavePreDeathGear", false, true];
			GOL_Module_Respawn = _module;
		[] spawn {
			publicVariable "GOL_Module_Respawn";
		};
	};

	if (isClass(configFile>>"CfgPatches">>"AGM_Map")) then {
		_module = _moduleGroup createUnit ["AGM_ModuleBlueForceTracking", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["Interval", 5, true];
		_module setVariable ["HideAiGroups", false, true];
			GOL_Module_BFT = _module;
			AGM_Map_EveryoneCanDrawOnBriefing = false;
		[] spawn {
			publicVariable "GOL_Module_BFT";
			publicVariable "AGM_Map_EveryoneCanDrawOnBriefing";
		};
	};

// ================================================================

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
