
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
			StartUpBadguys = true;
			GOL_Enemies = compile preprocessFileLineNumbers "mission\BadGuys.sqf";
			[] call GOL_Enemies;
			StartUpBadguys = false;
			publicVariable "StartUpBadguys";
		};

		if (hasInterface) then {	// * Client
			setViewDistance 1500;	// * View distance
			setObjectViewDistance 1200;	// * Object distance
			setTerrainGrid	25;		// * Terrain grid (grass)
			0 fadeRadio 0;
		} else {					// * Server & Headless
			setViewDistance 2000;	// * View distance, affects AI and performance
			setObjectViewDistance 1500;	// * Object distance, affects AI and performance
			setTerrainGrid	3.125;	// * Terrain grid (grass)
		};

// ================================================================

		if (isServer) then {
			#include "Version.hpp";
			#include "Modules.sqf";
			[] call GOL_Fnc_Module_Init;
			[] call GOL_Fnc_radioSettings;
		};

		private ["_DebugName"];
		_DebugName = "GOL-corePreInit";
		scriptName _DebugName;
		["PreInit INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
