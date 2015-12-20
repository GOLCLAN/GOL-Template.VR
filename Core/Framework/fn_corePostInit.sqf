
		private ["_DebugName"];
		_DebugName = "GOL-corePostInit";
		scriptName _DebugName;

		["------ Framework PostInit ------",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;

		[] call GOL_Fnc_HeadlessClient;

		#define QUOTE(var1) #var1
		#define DOUBLES(var1,var2) ##var1##_##var2
		#define MakePublic(Variable, Value) missionNamespace setVariable [QUOTE(Variable), Value, isServer];

		if (isServer) then {
			[] call GOL_Fnc_EnemyFactions;
		};

		#include "Includes\Modules.sqf"
		#include "Includes\RadioSettings.sqf"
		if (hasInterface) then {
// *		Loads Mandatory Player functions
			#include "Includes\Init.sqf"
			player addRating 100000;
			player setVariable ["BIS_noCoreConversations", true, true];
			player setVariable ["BIS_enableRandomization", false, true];

			if (isNil {player getVariable "GOL_Player"}) then {
				player setVariable ["GOL_Player", [player,(getPlayerUID player),didJIP,time], true];
			};
			[] spawn GOL_Fnc_AudioDetectorAI;
		};

		[] spawn GOL_Fnc_CoreLoop;
		[] execVM "Core\Functions\AI\MissionFunctions.sqf";

		private ["_DebugName"];
		_DebugName = "GOL-corePostInit";
		scriptName _DebugName;

		["PostInit INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
