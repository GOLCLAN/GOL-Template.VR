
		private _DebugName = "GOL-coreLoop";
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
				{
					_x disableai "MOVE";
					if ({isPlayer _x} count units group _x == 0) then {
//						deleteVehicle _x;
					};
					if !(side _x == side player) then {
						deleteVehicle _x;
					};
				}ForEach (playableUnits + switchableUnits);
				while {true} do {
					private _players = (call GOL_Fnc_Players);
					if !(_players isEqualTo GOL_PlayerList) then {
						GOL_PlayerList = _players;
						publicVariable "GOL_PlayerList";
					};
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
				private _time = time;
				waitUntil {sleep 0.1; !isNull player; time > (_time + 5)};
				if (!isNil {(player getVariable "GOL_Loadout")}) then {
					if (leader player == player) then {
						player setGroupIdGlobal [((player getVariable "GOL_Loadout") select 1)];
					};
				};

				if ((player getVariable "GOL_Player") select 2) then {	// JIP
					{
						[_x] call GOL_Fnc_MHQActions;
					} forEach MHQArray;
				};

			};
		};

		private _DebugName = "GOL-coreLoop";
		scriptName _DebugName;
		["PreInit INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
