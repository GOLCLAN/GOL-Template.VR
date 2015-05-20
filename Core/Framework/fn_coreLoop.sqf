
		private ["_DebugName"];
		_DebugName = "GOL-coreLoop";
		scriptName _DebugName;
		if (isServer) then {
			GOL_PersistentArray = [];
			GOL_CacheObject_Rescan = false;
			GOL_CacheVehicle_Rescan = false;
			[] spawn {
				publicVariable "GOL_PersistentArray";
				publicVariable "GOL_CacheObject_Rescan";
				publicVariable "GOL_CacheVehicle_Rescan";
//				[500] spawn GOL_Fnc_LightningRandom;
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

		private ["_DebugName"];
		_DebugName = "GOL-coreLoop";
		scriptName _DebugName;
		["PreInit INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
