// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Spawning in a group and attacking a area
// *		AI will spawn and move straight towards the enemy in normal speed, once contact is meet they will spread out
// *
// *	Usage:
// *		["Spawn", "objective_1", 0.3] call GVL_Fnc_AI_Inf_Attack;
// *
// *	Parameters:
// *		0:	String:		Spawning Location, either marker or object
// *		1:	String:		Attacking Location, either marker or object
// *		2:	Boolean:	Advanced attack mode
// *		3:	Number:		Unit Skill (Optional)
// *
// *	Returning Value:
// *		None
// *
// ================================================================

	sleep 0.5;

	_typeOfObjective = [_this, 0, "patrol", [""]] call BIS_fnc_param;
	_objectParams = [_this, 1] call BIS_fnc_param;

	switch (_typeOfObjective) do {

	    case "attack": {
			_attackPos = [_objectParams] call GVL_Fnc_GetPos;
			_newGrp addWaypoint [_attackPos, 0];
			[_newGrp, 0] setWaypointType "SAD";
			[_newGrp, 0] setWaypointCombatMode "RED";
			[_newGrp, 0] setWaypointBehaviour "COMBAT";
	    };

	    case "attackadv": {
			_area = [_objectParams, 0, _newGrpUnit, [[],"",objNull]] call bis_fnc_paramIn;
			_radius = [_objectParams, 1, 100, [0]] call bis_fnc_paramIn;
			[_newGrpUnit, _area, _radius] call CBA_fnc_taskAttack;
	    };

	    case "buildings": {
			[_newGrp] spawn CBA_fnc_searchNearby
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

	};
