
		private ["_DebugName"];
		_DebugName = "GOL-corePostInit";
		scriptName _DebugName;

		["------ Framework PostInit ------",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;

		[] call GOL_Fnc_HeadlessClient;
		[] call GOL_Fnc_EnemyFactions;
		#include "Includes\RadioSettings.sqf"
		#include "Includes\Init.sqf"
		[] spawn GOL_Fnc_CoreLoop;
		[] spawn GOL_Fnc_AudioDetectorAI;
		[] spawn GOL_Fnc_MissionFunctions;

		if (hasInterface) then {
// *		Loads Mandatory Player functions
			player addRating 100000;
			player setVariable ["BIS_noCoreConversations", true, true];
			player setVariable ["BIS_enableRandomization", false, true];

			if (isNil {player getVariable "GOL_Player"}) then {
				player setVariable ["GOL_Player", [player,(getPlayerUID player),([] call BIS_fnc_didJIP),time], true];
			};
		};

		private ["_DebugName"];
		_DebugName = "GOL-corePostInit";
		scriptName _DebugName;

		["PostInit INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
