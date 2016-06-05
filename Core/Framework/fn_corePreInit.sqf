
		private ["_DebugName"];
		_DebugName = "GOL-corePreInit";
		scriptName _DebugName;

// *	Add entry where mission starts .rpt file
		diag_log text "";
		[["|------  %1. %2 ------|", missionName, worldName],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		["------ Framework PreInit ------",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		diag_log text "";
		[["IsMultiplayer:	%1", isMultiplayer],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		[["IsServer:	%1", isServer],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		[["IsDedicated:	%1", isDedicated],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		[["Headless Client:	%1", !isServer && !hasInterface],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		[["HasInterface:	%1", hasInterface],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		[["Isnull Player:	%1", isNull player],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		diag_log text "";

// *	BIS Variables
		enableSaving [false, false];
		enableEngineArtillery false;
		enableSentences false;
		enableRadio false;

// *	GOL Variables
		startTime = time;
		if (isServer) then {
			GOL_Buildings = (compile preprocessFileLineNumbers "mission\Buildings.sqf");
			GOL_Enemies = (compile preprocessFileLineNumbers "mission\BadGuys.sqf");
			GOL_ObjectSurfaceNormal = true;
			GOL_UnitVarMove = ([0,0,-1] call BIS_fnc_selectRandom);
			publicVariable "GOL_Buildings";
			publicVariable "GOL_Enemies";
			publicVariable "GOL_ObjectSurfaceNormal";
			publicVariable "GOL_UnitVarMove";
		};

		if (hasInterface) then {	// * Client
			0 fadeRadio 0;
		} else {					// * Server & Headless
			setViewDistance 1000;	// * View distance, affects AI and performance
			setObjectViewDistance 1000;	// * Object distance, affects AI and performance
			setTerrainGrid	25;	// * Terrain grid (grass)
		};

// ================================================================

		if (isServer) then {
			#include "Includes\Version.hpp"
			#include "Includes\Params.sqf"

			private ["_LogicCenter","_moduleGroup","_module"];
			_LogicCenter = createCenter sideLogic;
			_moduleGroup = createGroup _LogicCenter;
		// ================================================================
			if (isClass(configFile>>"CfgPatches">>"ACE_OptionsMenu")) then {
				_module = _moduleGroup createUnit ["ACE_moduleAllowConfigExport", [0,0,0],[],0.5,"NONE"];
				_module setVariable ["allowconfigurationExport", true];
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
			};
			if (["Cache","Enabled"] call GOL_Fnc_GetConfig isEqualTo 1) then {
				[GOL_Gamelogic] call GOL_Fnc_FPS_Manager;
			};
			if (["Lightning"] call GOL_Fnc_GetConfig isEqualTo 1) then {
				GOL_Lightning_Active = true;
			};

			if (isClass(configFile>>"CfgPatches">>"DAC_Source")) then {
				if (["DAC_Config"] call GOL_Fnc_GetConfig isEqualTo 1) then {
					_module = _moduleGroup createUnit ["DAC_Source_Extern", [0,0,0],[],0.5,"NONE"];
				};
			};

		};

		private ["_DebugName"];
		_DebugName = "GOL-corePreInit";
		scriptName _DebugName;
		["PreInit INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
