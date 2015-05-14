
		private ["_DebugName"];
		_DebugName = "GVL-coreLoop";
		scriptName _DebugName;

		if (isServer) then {
			[] spawn {
				{ _x disableai "MOVE"; }ForEach (playableUnits + switchableUnits);
				[500] spawn GVL_Fnc_LightningRandom;
				while {true} do {
//					sleep 10;
					if (fog > 0.02) then {setviewDistance (viewDistance * (1 - fog))};
					[] call GVL_fnc_Curator_Setskill;
					sleep 10;
					[] call GVL_Fnc_Curator_Units;
					sleep 10;
					if (isMultiplayer) then {
						[] call GVL_fnc_Curator_AddPlayers;
					};
				};
			};
			[] spawn {
				GVL_PersistentArray = [];
				GVL_CacheObject_Rescan = false;
				GVL_CacheVehicle_Rescan = false;
				publicVariable "GVL_PersistentArray";
				publicVariable "GVL_CacheObject_Rescan";
				publicVariable "GVL_CacheVehicle_Rescan";
				while {true} do {
					_players = [];
					if (isMultiplayer) then {
						_players = (call CBA_fnc_players);
					} else {
						_players = switchableUnits;
					};
					if !(cameraOn in _players) then {	_players pushBack cameraOn;	};
					GVL_PlayerList = _players;
					publicVariable "GVL_PlayerList";
					sleep 5;
				};
			};
		};

		private ["_DebugName"];
		_DebugName = "GVL-coreLoop";
		scriptName _DebugName;
		["PreInit INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GVL_Fnc_DebugLog;
