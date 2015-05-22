
		private ["_DebugName"];
		_DebugName = "GOL-coreLoop";
		scriptName _DebugName;
		if (isServer) then {
			{
				if ((local _x) && (!isNil {(_x getVariable "GOL_Loadout")})) then {
					[_x] call GOL_Fnc_GearHandler;
				};
			} forEach allUnits;
			GOL_PersistentArray = [];
			GOL_CacheObject_Rescan = false;
			GOL_CacheVehicle_Rescan = false;
			[] spawn {
				publicVariable "GOL_PersistentArray";
				publicVariable "GOL_CacheObject_Rescan";
				publicVariable "GOL_CacheVehicle_Rescan";
				{ _x disableai "MOVE"; }ForEach (playableUnits + switchableUnits);
				while {true} do {	// sleeps to prevent exectuted of everything at the sametime
					sleep 10;
					if (fog > 0.02) then {setviewDistance (viewDistance * (1 - fog))};
					[] call GOL_fnc_Curator_Setskill;
					sleep 10;
					[] call GOL_Fnc_Curator_Units;
					sleep 10;
					if (isMultiplayer) then {
						[] call GOL_fnc_Curator_AddPlayers;
					};
				};
			};

		};
		if (hasInterface) then {
			[] spawn {
				private ["_time"];
				_time = time;
				waitUntil {sleep 0.1; !isNull player; time > (_time + 5)};
				if (!isNil {(player getVariable "GOL_Loadout")}) then {
					[[[player], { (_this select 0) setGroupId [((_this select 0) getVariable "GOL_Loadout") select 1]; }], "bis_fnc_call", true, true] call BIS_fnc_MP;
					[player, (player getVariable "GOL_GroupColor")] call ACE_Interaction_fnc_joinTeam;
				};
				if ((player getVariable "GOL_Player") select 2) then {	// JIP
					{
						[_x] call GOL_Fnc_MHQActions;
					} forEach MHQArray;
				};
			};
		};

		private ["_DebugName"];
		_DebugName = "GOL-coreLoop";
		scriptName _DebugName;
		["PreInit INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
