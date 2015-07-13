
	switch (_typeOfObjective) do {

		case "attack": {
			for "_i" from 0 to (count _objectParams - 1) step 1 do {
				_attackPos = [_objectParams select _i] call GOL_Fnc_GetPos;
				_wp = _newGrp addWaypoint [_attackPos, 0];
				_wp setWaypointCombatMode "RED";
				_wp setWaypointSpeed "NORMAL";
				if ((count _objectParams) == _i) then {
					_wp setWaypointBehaviour "COMBAT";
					_wp setWaypointType "SAD";
				} else {
					_wp setWaypointBehaviour "AWARE";
					_wp setWaypointType "MOVE";
				};
			};
		};

		case "attackadv": {
			_waypoints = [_objectParams, 0, "error", [[]]] call bis_fnc_paramIn;
			for "_i" from 0 to (count _waypoints - 1) step 1 do {
				_attackPos = [_waypoints select _i] call GOL_Fnc_GetPos;
				_newGrp addWaypoint [_attackPos, 0];
				[_newGrp, _i] setWaypointCombatMode "RED";
				[_newGrp, _i] setWaypointBehaviour "AWARE";
				[_newGrp, _i] setWaypointType "MOVE";
				[_newGrp, _i] setWaypointSpeed "NORMAL";
				if ((count _waypoints) == _i) then {
					_radius = [_objectParams, 1, 100, [0]] call bis_fnc_paramIn;
					[_newGrpUnit, _waypoints select _i, _radius] call CBA_fnc_taskAttack;
				};
			};
		};

		case "defend": {
			_area = [_objectParams, 0, _newGrpUnit, [[],"",objNull]] call bis_fnc_paramIn;
			_radius = [_objectParams, 1, 100, [0]] call bis_fnc_paramIn;
			_patrol = [_objectParams, 2, true, [true]] call bis_fnc_paramIn;
			[_newGrpUnit, _area, _radius, 3, _patrol] call CBA_fnc_taskDefend;
		};

		case "patrol": {
			_area = [_objectParams, 0, _newGrpUnit, [[],"",objNull]] call bis_fnc_paramIn;
			_radius = [_objectParams, 1, 300, [0]] call bis_fnc_paramIn;
			_waypoints = [_objectParams, 2, 10, [0]] call BIS_fnc_param;
			[_newGrpUnit, _area, _radius, _waypoints, "MOVE", "SAFE", "RED", "LIMITED", "FILE", "", [3,6,9]] call CBA_fnc_taskPatrol;
		};

		case "patroladv": {
			for "_i" from 0 to (count _objectParams) step 1 do {
				if ((count _objectParams) == _i) then {
					_wp = _newGrp addWaypoint [_spawn, 0];
					_wp setWaypointCombatMode "YELLOW";
					_wp setWaypointBehaviour "AWARE";
					_wp setWaypointSpeed "LIMITED";
					_wp setWaypointType "CYCLE";
				} else {
					_attackPos = [_objectParams select _i] call GOL_Fnc_GetPos;
					_wp = _newGrp addWaypoint [_attackPos, 0];
					_wp setWaypointCombatMode "YELLOW";
					_wp setWaypointBehaviour "AWARE";
					_wp setWaypointSpeed "LIMITED";
					_wp setWaypointType "MOVE";
				};
			};
		};
	};
