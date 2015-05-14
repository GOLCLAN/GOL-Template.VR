
// ================================================================
	private ["_LogicCenter","_moduleGroup","_module"];
	_LogicCenter = createCenter sideLogic;
	_moduleGroup = createGroup _LogicCenter;

// ================================================================

	if (isClass(configFile>>"CfgPatches">>"asr_ai3_main") && ["ASR_Config"] call GOL_Fnc_GetConfig == 1) then {
//
	/*
		ASR AI3 settings
		for most settings, 0 = disabled, 1 = enabled
		Mission makers can control these features by setting these global variables in init.sqf
	*/

	// =================================
		asr_ai3_main_enabled 		= 1;		// All the other settings matter only if we have 1 here; set 0 to disable all scripted features
		asr_ai3_main_radionet 		= 0;		// AI groups share known enemy locations over radio
		asr_ai3_main_radiorange 	= 200;		// Maximum range for AI radios
		asr_ai3_main_seekcover 		= 1;		// Set to 1 if AI should move to near cover in combat when they're exposed in the open, 0 to disable.
		asr_ai3_main_throwsmoke		= 0.2;		// AI throws smoke when advancing to cover (set 0 to disable or a number up to 1 to enable, higher number means better chance to do it)
		asr_ai3_main_reactions 		= [1,1,1];	// Infantry groups will randomly react with basic, scripted, random actions, to detecting the enemy or being shot at;
		//	format: [enableAttack,enableDefend,enableSupport]
		asr_ai3_main_usebuildings 	= 0;		// Chance the AI group will enter nearby buildings when in combat mode (0 to 1 values, 0 will disable the feature)
		asr_ai3_main_getinweapons 	= 0.5;		// Chance the AI group will mount nearby static and vehicle weapons in combat (0 to 1 values, 0 will disable the feature)
		asr_ai3_main_packNVG		= 1;		// Automatically un-equip NVG during the day (store them in the vest/backpack) and re-equip when it gets dark
		asr_ai3_main_dayscope		= 1;		// Prevent AI from using scope fire modes at night (reduced engagement range and accuracy); requires ASDG JR to work
		asr_ai3_main_debug 			= 0;		// Log extra debugging info to RPT, create debug markers and hints (1-enabled, 0-disabled)
//			Server Settings
		asr_ai3_main_setskills 		= 0;		// Override AI skills based on their unit type (faction, training etc.; 0 - disabled, 1 - enabled)
		asr_ai3_main_dynsvd 		= 1;		// Enable dynamic view distance adjustment based on day/night and fog thickness on dedicated servers and headless clients
		asr_ai3_main_gunshothearing = 0.25;		// Gunshot hearing range coefficient (applied to shooter's weapon sound range; 0 will disable the feature)
		asr_ai3_main_joinlast 		= 0;		// Groups left with only this number of units will merge with nearest group of the same faction (set to 0 to disable)
		asr_ai3_main_removegimps	= 120;		// Units unable to walk for this time will separate from their group to prevent slowing it down (time in seconds, set 0 to disable)

		[] spawn {
			publicVariable "asr_ai3_main_enabled";
			publicVariable "asr_ai3_main_radionet";
			publicVariable "asr_ai3_main_radiorange";
			publicVariable "asr_ai3_main_seekcover";
			publicVariable "asr_ai3_main_throwsmoke";
			publicVariable "asr_ai3_main_reactions";
			publicVariable "asr_ai3_main_usebuildings";
			publicVariable "asr_ai3_main_getinweapons";
			publicVariable "asr_ai3_main_packNVG";
			publicVariable "asr_ai3_main_dayscope";
			publicVariable "asr_ai3_main_debug";

			publicVariable "asr_ai3_main_setskills";
			publicVariable "asr_ai3_main_dynsvd";
			publicVariable "asr_ai3_main_gunshothearing";
			publicVariable "asr_ai3_main_joinlast";
			publicVariable "asr_ai3_main_removegimps";
		};
	};

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

	if (["Cache","Enabled"] call GOL_Fnc_GetConfig == 1) then {
//		[GOL_Gamelogic] call GOL_Fnc_FPS_Manager;
	};

	if (["Lightning"] call GOL_Fnc_GetConfig == 1) then {
		GOL_Lightning_Active = true;
	};

	GOL_Gamelogic_Local = "Logic" createVehicleLocal [0,0,0];

// ================================================================

private ["_DebugName"];
_DebugName = "GOL-Modules";
scriptName _DebugName;

["FRAMEWORK MODULES INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
