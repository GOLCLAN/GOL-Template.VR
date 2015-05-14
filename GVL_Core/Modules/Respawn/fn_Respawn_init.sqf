
	if (isServer) then {
		GVL_RespawnLimit_ServerConnections = [];
		GVL_RespawnLimit_ServerDead = [];
		GVL_RespawnLimit_ServerDeadPermanent = [];
		GVL_Gamelogic setVariable ["GVL_PlayerUID", [], true];

		addMissionEventHandler ["HandleDisconnect",{
			_player = _this select 0;
			_playerUID = _this select 2;
			GVL_Gamelogic setVariable [format ["Gear_%1", _playerUID], ([_player] call AGM_Respawn_fnc_getAllGear), true];
			GVL_Gamelogic setVariable [format ["Pos_%1", _playerUID], [(getPosATL _player),(getDir _player)], true];
			(GVL_Gamelogic getVariable "GVL_PlayerUID") pushBack _playerUID;
		}];

		if (!isnil {getMarkerPos "jail"}) then {
			private ["_mrk","_mrkpos","_mrkdir","_pos"];
			_mrk = "jail";
			_mrkpos = getMarkerPos _mrk;
			_mrkdir = markerDir _mrk;
			for "_i" from 1 to 8 step 1 do {
				_pos = [getMarkerPos _mrk, 6.7, _mrkdir] call bis_fnc_relpos;
				_wall = "Land_CncWall4_F" createVehicle _pos;
				_wall setPosATL [(_pos select 0),(_pos select 1),(_pos select 2) - 0.2];
				_wall setDir _mrkdir;
				_mrkdir = _mrkdir + 45;
		    };
			for "_i" from 1 to 8 step 1 do {
				_pos = [getMarkerPos _mrk, 5, _mrkdir] call bis_fnc_relpos;
				_wall = "Land_CncWall4_F" createVehicle _pos;
				_wall setPosATL [(_pos select 0),(_pos select 1),(_pos select 2) + 2];
				_wall setDir _mrkdir;
				[_wall, 90, 180] call BIS_fnc_setPitchBank;
				_mrkdir = _mrkdir + 45;
		    };
		};
	};

	if (hasInterface) then {
		GVL_Spectator_Enabled = false;
		[] spawn {
		    if ([] call BIS_fnc_didJIP) then { waitUntil {sleep 1; !isNull player;}; };
	    	sleep 2;

			if (isNil "GVL_Gear_Respawn") Then {			// Slight bug, nesasary to fix the respawn gear atm
				if (!isNil {player getVariable "GVL_Loadout"}) Then {
					GVL_Gear_Respawn = player addEventHandler ["respawn", { [player, player getVariable "GVL_Loadout"] call GVL_Fnc_GearHandler; } ];
				};
			};

			if (["RespawnLimit","Enabled"] call GVL_Fnc_GetConfig == 1) Then {
				player setVariable ["GVL_RespawnLimit_Lives", (["RespawnLimit","Tickets"] call GVL_Fnc_GetConfig), true];

				player addEventHandler ["Respawn",{
					[[player], "GVL_Fnc_serverRespawn", false] call BIS_fnc_MP;
				}];

				[[[player], {
					private ["_player","_playerUID","_typeofConnection","_deaths"];
					_player = _this select 0;
					_playerUID = _player getVariable "GVL_Player" select 1;

					if ((_playerUID in GVL_RespawnLimit_ServerConnections)) then {
						_typeofConnection = "reconnect";
						if (_playerUID in GVL_RespawnLimit_ServerDeadPermanent) then {
							_typeofConnection = "reslot";
						};
					} else {
						if !(_playerUID in GVL_RespawnLimit_ServerConnections) then {
							GVL_RespawnLimit_ServerConnections pushBack _playerUID;
							_typeofConnection = "newplayer";
						};
					};

				    if (_playerUID in GVL_RespawnLimit_ServerDead) then {
						_deaths = {_x == _playerUID} count GVL_RespawnLimit_ServerDead;
						_player setVariable ["GVL_RespawnLimit_Lives", ((["RespawnLimit","Tickets"] call GVL_Fnc_GetConfig) - (_deaths)), true];
				    };
					[[_typeofConnection], "GVL_Fnc_Connection", _player] call BIS_fnc_MP;
				}], "bis_fnc_call", false] call BIS_fnc_MP;
			};
		};
	};

	private ["_DebugName"];
	_DebugName = "GVL-RespawnModule";
	scriptName _DebugName;

	["Respawn Module INITIALIZED",[_DebugName,__FILE__,__LINE__],"log"] call GVL_Fnc_DebugLog;
