
		private ["_DebugName"];
		_DebugName = "GOL-corePostInit";
		scriptName _DebugName;

		["------ Framework PostInit ------",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;

		[] call GOL_Fnc_HeadlessClient;
		[] call GOL_Fnc_radioSettings;
		[] call GOL_Fnc_NotesInit;
		[(["Default_AI"] call GOL_Fnc_GetConfig)] call GOL_Fnc_EnemyFactions;
		[] spawn GOL_Fnc_CoreLoop;
		[] spawn GOL_Fnc_AudioDetectorAI;
		[] spawn GOL_Fnc_MissionFunctions;

		if (hasInterface) then {
// *		Loads Mandatory Player functions
			player addRating 100000;
			player setVariable ["BIS_noCoreConversations", true, true];
			player setVariable ["BIS_enableRandomization", false, true];
			GOL_Gamelogic_Local = "Logic" createVehicleLocal [0,0,0];

			if (isNil {player getVariable "GOL_Player"}) then {
				player setVariable ["GOL_Player", [player,(getPlayerUID player),([] call BIS_fnc_didJIP),time], true];
			};
			[] spawn {
				sleep 5;
//			    [[[player], { (_this select 0) setGroupId [((_this select 0) getVariable "GOL_GroupID")]; }], "bis_fnc_call", true, true] call BIS_fnc_MP;
				waitUntil {sleep 0.1; isnil "GOL_PlayerList"};
				{
			    	_x setGroupId [(_x getVariable "GOL_GroupID")];
				} forEach GOL_PlayerList;
			};
		};

		if (isServer) then {
			if (("GOL_Params_FTL_Teleport" call BIS_fnc_getParamValue) == 1) then {
				GOL_Allow_FTL_Teleport = true;
			} else {
				GOL_Allow_FTL_Teleport = false;
			};
			GOL_FTL_Distance_TP = "GOL_Params_Teleport_Distance" call BIS_fnc_getParamValue;

			publicVariable "GOL_Allow_FTL_Teleport";
			publicVariable "GOL_FTL_Distance_TP";
		};

		private ["_DebugName"];
		_DebugName = "GOL-corePostInit";
		scriptName _DebugName;

		["PostInit INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
