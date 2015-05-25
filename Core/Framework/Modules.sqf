
// ================================================================
	private ["_LogicCenter","_moduleGroup","_module"];
	_LogicCenter = createCenter sideLogic;
	_moduleGroup = createGroup _LogicCenter;

// ================================================================

	if (isClass(configFile>>"CfgPatches">>"ACE_Respawn")) then {
		_module = _moduleGroup createUnit ["ACE_ModuleRespawn", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["RemoveDeadBodiesDisconnected", true, true];
		_module setVariable ["SavePreDeathGear", true, true];
			GOL_Module_Respawn = _module;
		[] spawn { publicVariable "GOL_Module_Respawn"; };
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Medical")) then {
		_module = _moduleGroup createUnit ["ACE_moduleMedicalSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["level", 1, true];
		_module setVariable ["medicSetting", 0, true];
		_module setVariable ["allowLitterCreation", true, true];
		_module setVariable ["litterCleanUpDelay", 1200, true];
		_module setVariable ["enableScreams", true, true];
		_module setVariable ["playerDamageThreshold", 1, true];
		_module setVariable ["AIDamageThreshold", 1, true];
		_module setVariable ["enableUnconsciousnessAI", false, true]; // 0
		_module setVariable ["preventInstaDeath", false, true];
		_module setVariable ["bleedingCoefficient", 1.5, true];
		_module setVariable ["painCoefficient", 1.5, true];
		_module setVariable ["keepLocalSettingsSynced", true, true];
			GOL_Module_MedicalBasic = _module;

		_module = _moduleGroup createUnit ["ACE_moduleAdvancedMedicalSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["enableFor", 0, true];
		_module setVariable ["enableAdvancedWounds", false, true];
		_module setVariable ["enableVehicleCrashes", true, true];
		_module setVariable ["medicSetting_PAK", 1, true];	// 0
		_module setVariable ["consumeItem_PAK", 1, true];
		_module setVariable ["useLocation_PAK", 0, true];
		_module setVariable ["medicSetting_SurgicalKit", 1, true];
		_module setVariable ["consumeItem_SurgicalKit", 1, true];
		_module setVariable ["useLocation_SurgicalKit", 0, true];
			GOL_Module_MedicalAdv = _module;

		_module = _moduleGroup createUnit ["ACE_moduleReviveSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["enableRevive", 0, true];
		_module setVariable ["maxReviveTime", 120, true];
		_module setVariable ["amountOfReviveLives", -1, true];
			GOL_Module_MedicalRevive = _module;
			ace_medical_setting_allowSharedEquipment = false;
		[] spawn {
			publicVariable "ace_medical_setting_allowSharedEquipment";
			publicVariable "GOL_Module_MedicalBasic";
			publicVariable "GOL_Module_MedicalAdv";
			publicVariable "GOL_Module_MedicalRevive";
		};
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_WindDeflection")) then {
		_module = _moduleGroup createUnit ["ACE_WindDeflection_ModuleSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["enabled", true, true];
		_module setVariable ["vehicleEnabled", true, true];
		_module setVariable ["simulationInterval", 0.05, true];
		_module setVariable ["simulationRadius", 3000, true];
			GOL_Module_Wind = _module;
		[] spawn { publicVariable "GOL_Module_Wind"; };
	};

/*
	if (isClass(configFile>>"CfgPatches">>"ACE_Advanced_Ballistics")) then {
		_module = _moduleGroup createUnit ["ACE_Advanced_Ballistics_ModuleSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["enabled", true, true];
		_module setVariable ["alwaysSimulateForSnipers", true, true];
		_module setVariable ["disabledInFullAutoMode", true, true];
		_module setVariable ["onlyActiveForLocalPlayers", true, true];
		_module setVariable ["ammoTemperatureEnabled", true, true];
		_module setVariable ["barrelLengthInfluenceEnabledd", true, true];
		_module setVariable ["bulletTraceEnabled", false, true];
		_module setVariable ["simulationInterval", 0.05, true];
		_module setVariable ["simulationRadius", 2000, true];
	};
*/

	if (isClass(configFile>>"CfgPatches">>"ACE_Map")) then {
		_module = _moduleGroup createUnit ["ACE_ModuleMap", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["MapIllumination", true, true];
		_module setVariable ["MapShake", true, true];
		_module setVariable ["MapLimitZoom", false, true];
		_module setVariable ["MapShowCursorCoordinates", false, true];
			ace_maptools_EveryoneCanDrawOnBriefing = false;
			GOL_Module_Map = _module;
		[] spawn {
			publicVariable "ace_maptools_EveryoneCanDrawOnBriefing";
			publicVariable "GOL_Module_Map";
		};
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_MK6Mortar")) then {
		_module = _moduleGroup createUnit ["ACE_MK6Mortar_Module", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["airResistanceEnabled", true, true];
		_module setVariable ["allowComputerRangefinder", false, true];
		_module setVariable ["allowCompass", true, true];
			GOL_Module_Mortar = _module;
		[] spawn { publicVariable "GOL_Module_Mortar"; };
	};

// *	================================================================
// *		DONT EDIT ANYTHING BELOW
// *	================================================================

	if (isClass(configFile>>"CfgPatches">>"ACE_NameTags")) then {
		_module = _moduleGroup createUnit ["ACE_ModuleNameTags", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["PlayerNamesViewDistance", 15, true];	// GOL Default distance
		_module setVariable ["showNamesForAI", false, true];	// GOL Default distance
		_module setVariable ["showVehicleCrewInfo", true, true];	// GOL Default distance
		_module setVariable ["showCursorTagForVehicles", false, true];	// GOL Default distance
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Dragging")) then {
		ACE_maxWeightDrag = 100000; // Removes weight limit
		ACE_maxWeightCarry = ACE_maxWeightDrag; // Removes weight limit
		publicVariable "ACE_maxWeightDrag";
		publicVariable "ACE_maxWeightCarry";
	};

/*			Is it even working??
	if (isClass(configFile>>"CfgPatches">>"ACE_Explosives")) then {	// Dont touch, we dont have any specialist so its just annoying
		_module = _moduleGroup createUnit ["ACE_ModuleExplosive", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["RequireSpecialist", false, true];
		_module setVariable ["PunishNonSpecialists", false, true];
	};
*/

	if (isClass(configFile>>"CfgPatches">>"ACE_Hearing")) then {
		_module = _moduleGroup createUnit ["ACE_ModuleHearing", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["EnableCombatDeafness", true, true];
		_module setVariable ["EarplugsVolume", 0.5, true];
		_module setVariable ["UnconsciousnessVolume", 0.4, true];
		_module setVariable ["DisableEarRinging", false, true];
			GOL_Module_Hearing = _module;
		[] spawn { publicVariable "GOL_Module_Hearing"; };
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Weather")) then {
		_module = _moduleGroup createUnit ["ACE_Weather_ModuleSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["enableServerController", true, true];
		_module setVariable ["useACEWeather", true, true];
		_module setVariable ["syncRain", true, true];
		_module setVariable ["syncWind", true, true];
		_module setVariable ["syncMisc", true, true];
		_module setVariable ["serverUpdateInterval", 60, true];
			GOL_Module_Weather = _module;
		[] spawn { publicVariable "GOL_Module_Weather"; };
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_ViewDistance")) then {
		_module = _moduleGroup createUnit ["ACE_ViewDistance_ModuleSettings", [0,0,0],[],0.5,"NONE"];
		_module setVariable ["moduleViewDistanceEnabled", true, true];
		_module setVariable ["moduleViewDistanceLimit", 10000, true];
			GOL_Module_ViewDistance = _module;
		[] spawn { publicVariable "GOL_Module_ViewDistance"; };
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

		_module = _moduleGroup createUnit["ModuleCurator_F",[0,0,0],[],0,"NONE"];
		_module setVariable ["Owner", "#adminLogged", true];
		_module setVariable ["Name", "Admin", true];
		_module setVariable ["Addons", 2, true];
		_module setVariable ["Forced", 0, true];
		_module setvariable ["bis_fnc_curatorSystem_points",10000];

		GOL_ZeuzModuleAdminLogged = _module;
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

	private ["_DebugName"];
	_DebugName = "GOL-Modules";
	scriptName _DebugName;

	["FRAMEWORK MODULES INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
