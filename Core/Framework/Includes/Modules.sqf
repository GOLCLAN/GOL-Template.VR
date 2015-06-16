
// ================================================================
	private ["_LogicCenter","_moduleGroup","_module"];
	_LogicCenter = createCenter sideLogic;
	_moduleGroup = createGroup _LogicCenter;

// ================================================================

	if (isClass(configFile>>"CfgPatches">>"ACE_Respawn")) then {
		ace_respawn_RemoveDeadBodiesDisconnected = true;
		ace_respawn_SavePreDeathGear = true;
		[] spawn {
			publicVariable "ace_respawn_RemoveDeadBodiesDisconnected";
			publicVariable "ace_respawn_SavePreDeathGear";
		};
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Medical")) then {

//		ACE 3 Medical
		ace_medical_level = 1;
		ace_medical_medicSetting = 1;
		ace_medical_allowLitterCreation = true;
		ace_medical_litterCleanUpDelay = 1200;
		ace_medical_enableScreams = true;
		ace_medical_playerDamageThreshold = 1.5;
		ace_medical_AIDamageThreshold = 1;
		ace_medical_enableUnconsciousnessAI = 2;
		ace_medical_preventInstaDeath = false;
		ace_medical_bleedingCoefficient = 2.0;
		ace_medical_painCoefficient = 1.5;
		ace_medical_keepLocalSettingsSynced = true;
		ace_medical_enableoverdosing = true;
		ace_medical_setting_allowSharedEquipment = true;

		ace_medical_healHitPointAfterAdvBandage = true; // New
		ace_medical_allowUnconsciousAnimationOnTreatment = true;    // New
		ace_medical_moveUnitsFromGroupOnUnconscious = true; // New

//		ACE 3 Advanced Medical
		ace_medical_enableFor = 1;	// 0
		ace_medical_enableadvancedwounds = false;
		ace_medical_enableVehicleCrashes = true;
		ace_medical_medicSetting_PAK = 0;
		ace_medical_medicSetting_SurgicalKit = 0;
		ace_medical_consumeItem_PAK = 1;
		ace_medical_consumeItem_SurgicalKit = 0;
		ace_medical_useLocation_PAK = 0;
		ace_medical_useLocation_SurgicalKit = 0;

//		ACE 3 Revive Settings
		ace_medical_enableRevive = 0;
		ace_medical_maxReviveTime = 120;
		ace_medical_amountOfReviveLives = -1;
		[] spawn {
			publicVariable "ace_medical_level";
			publicVariable "ace_medical_medicSetting";
			publicVariable "ace_medical_allowLitterCreation";
			publicVariable "ace_medical_litterCleanUpDelay";
			publicVariable "ace_medical_enableScreams";
			publicVariable "ace_medical_playerDamageThreshold";
			publicVariable "ace_medical_AIDamageThreshold";
			publicVariable "ace_medical_enableUnconsciousnessAI";
			publicVariable "ace_medical_preventInstaDeath";
			publicVariable "ace_medical_bleedingCoefficient";
			publicVariable "ace_medical_painCoefficient";
			publicVariable "ace_medical_keepLocalSettingsSynced";
			publicVariable "ace_medical_enableoverdosing";
			publicVariable "ace_medical_setting_allowSharedEquipment";

			publicVariable "ace_medical_enableFor";
			publicVariable "ace_medical_enableadvancedwounds";
			publicVariable "ace_medical_enableVehicleCrashes";
			publicVariable "ace_medical_medicSetting_PAK";
			publicVariable "ace_medical_medicSetting_SurgicalKit";
			publicVariable "ace_medical_consumeItem_PAK";
			publicVariable "ace_medical_consumeItem_SurgicalKit";
			publicVariable "ace_medical_useLocation_PAK";
			publicVariable "ace_medical_useLocation_SurgicalKit";

			publicVariable "ace_medical_enableRevive";
			publicVariable "ace_medical_maxReviveTime";
			publicVariable "ace_medical_amountOfReviveLives";

		};

	};

// *	================================================================
// *		DONT EDIT ANYTHING BELOW
// *	================================================================

	if (isClass(configFile>>"CfgPatches">>"ACE_WindDeflection")) then {
		_module = _moduleGroup createUnit ["ACE_WindDeflection_ModuleSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["enabled", true, true];
		_module setVariable ["vehicleEnabled", false, true];
		_module setVariable ["simulationInterval", 0.1, true];
		_module setVariable ["simulationRadius", 1000, true];
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Advanced_Ballistics")) then {
		_module = _moduleGroup createUnit ["ACE_Advanced_Ballistics_ModuleSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["enabled", false, true];
		_module setVariable ["alwaysSimulateForSnipers", false, true];
		_module setVariable ["disabledInFullAutoMode", true, true];
		_module setVariable ["onlyActiveForLocalPlayers", true, true];
		_module setVariable ["ammoTemperatureEnabled", false, true];
		_module setVariable ["barrelLengthInfluenceEnabled", false, true];
		_module setVariable ["bulletTraceEnabled", false, true];
		_module setVariable ["simulationInterval", 1.0, true];
		_module setVariable ["simulationRadius", 50, true];
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Map")) then {
		_module = _moduleGroup createUnit ["ACE_ModuleMap", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["MapIllumination", true, true];
		_module setVariable ["MapShake", true, true];
		_module setVariable ["MapLimitZoom", false, true];
		_module setVariable ["MapShowCursorCoordinates", false, true];
			ace_maptools_EveryoneCanDrawOnBriefing = false;
		[] spawn { publicVariable "ace_maptools_EveryoneCanDrawOnBriefing"; };
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_MK6Mortar")) then {
		_module = _moduleGroup createUnit ["ACE_MK6Mortar_Module", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["airResistanceEnabled", false, true];
		_module setVariable ["allowComputerRangefinder", true, true];
		_module setVariable ["allowCompass", true, true];
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_NameTags")) then {
		_module = _moduleGroup createUnit ["ACE_ModuleNameTags", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["PlayerNamesViewDistance", 15, true];	// GOL Default distance
		_module setVariable ["showNamesForAI", false, true];
		_module setVariable ["showVehicleCrewInfo", false, true];
		_module setVariable ["showCursorTagForVehicles", true, true];
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Dragging")) then {
		ACE_maxWeightDrag = 100000; // Removes weight limit
		ACE_maxWeightCarry = ACE_maxWeightDrag; // Removes weight limit
		publicVariable "ACE_maxWeightDrag";
		publicVariable "ACE_maxWeightCarry";
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Hearing")) then {
		_module = _moduleGroup createUnit ["ACE_ModuleHearing", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["EnableCombatDeafness", true, true];
		_module setVariable ["EarplugsVolume", 0.7, true];
		_module setVariable ["UnconsciousnessVolume", 0.5, true];
		_module setVariable ["DisableEarRinging", false, true];
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Weather")) then {
		_module = _moduleGroup createUnit ["ACE_Weather_ModuleSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["enableServerController", true, true];
		_module setVariable ["useACEWeather", true, true];
		_module setVariable ["syncRain", true, true];
		_module setVariable ["syncWind", true, true];
		_module setVariable ["syncMisc", true, true];
		_module setVariable ["serverUpdateInterval", 60, true];
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Zeus")) then {
		_module = _moduleGroup createUnit ["ACE_moduleZeusSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["zeusAscension", 0, true];
		_module setVariable ["zeusBird", 0, true];
		_module setVariable ["remoteWind", 0, true];
		_module setVariable ["radioOrdnance", 0, true];
		_module setVariable ["revealMines", 0, true];
	};

	if (isClass(configFile>>"CfgPatches">>"DAC_Source")) then {
		if (["DAC_Config"] call GOL_Fnc_GetConfig isEqualTo 1) then {
			_module = _moduleGroup createUnit ["DAC_Source_Extern", [0,0,0],[],0.5,"NONE"];
		};
	};

	if (isClass(configFile>>"CfgPatches">>"A3_Modules_F_Curator")) then {
		GOL_ZeuzModuleAdminLogged = _moduleGroup createUnit["ModuleCurator_F",[0,0,0],[],0,"NONE"];
		GOL_ZeuzModuleAdminLogged setVariable ["Owner", "#adminLogged", true];
		GOL_ZeuzModuleAdminLogged setVariable ["Name", "AdminZeus", true];
		GOL_ZeuzModuleAdminLogged setVariable ["Addons", 3, true];
		GOL_ZeuzModuleAdminLogged setVariable ["Forced", 0, true];
		GOL_ZeuzModuleAdminLogged setVariable ["birdType", "", true];
		GOL_ZeuzModuleAdminLogged setVariable ["showNotification", false, true];
		GOL_Gamelogic = _moduleGroup createUnit["Logic",[0,0,0],[],0,"NONE"];
		[] spawn {
			publicVariable "GOL_ZeuzModuleAdminLogged";
			publicVariable "GOL_Gamelogic";
		};
	};

	if (["Cache","Enabled"] call GOL_Fnc_GetConfig isEqualTo 1) then {
		[GOL_Gamelogic] call GOL_Fnc_FPS_Manager;
	};

	if (["Lightning"] call GOL_Fnc_GetConfig isEqualTo 1) then {
		GOL_Lightning_Active = true;
	};

	GOL_Gamelogic_Local = "Logic" createVehicleLocal [0,0,0];

// ================================================================

	["FRAMEWORK MODULES INITIALIZED",["GOL-Modules",__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
