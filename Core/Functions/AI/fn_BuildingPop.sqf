/*	====================================================================================

	Author: GuzzenVonLidl

	Description:
		Collects all positions and selects a random one to place a unit in

	Usage:
		["marker1", 17, 75] spawn GOL_Fnc_BuildingPop;

	Parameter(s):
		#0	OBJECT || STRING || ARRAY:	Center Location of buildings/positions
		#1	NUMBER:	Amount of ai spawn
		#2	NUMBER:	Radius of area	(Optional: Default: 50)
		#3	BOOL:	Exact positions only and not just building in area (Optional: Default: false)

	Returning Value:
		Nothing
// ==================================================================================== */

	if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs after and not players

	private ["_DebugName","_marker","_number","_radius","_distance","_markerLocation","_buildingArray","_newGrp","_spawnLocation","_newGrpUnit","_dir"];

	_DebugName = "GOL_Fnc_BuildingPop";
	scriptName _DebugName;

	_marker = [_this, 0, "", [[],"",objNull]] call BIS_fnc_param;
	_number = [_this, 1, 2, [0]] call BIS_fnc_param;
	_radius = [_this, 2, 50, [0]] call BIS_fnc_param;
	_distance = [_this, 3, false, [true]] call BIS_fnc_param;
	_markerLocation = [_marker] call GOL_Fnc_GetPos;
	_buildingArray = [];
	_newGrp = CreateGroup EnemySide;

	{
		if (count ([_x,1] call BIS_fnc_buildingPositions) >= 1) then {
				_buildingArray = (_buildingArray + ([_x] call BIS_fnc_buildingPositions));
		};
	} forEach (nearestObjects [_markerLocation, ["house"], _radius]);

	if (_distance) then {
		{
			if ((_markerLocation distance _x) > _radius) then {
				_buildingArray = _buildingArray - [_x];
			};
		} forEach _buildingArray;
	};

	for "_i" from 0 to _number step 1 do {
		if ((count _buildingArray) == 0) exitWith {false};
		sleep 1;
		_spawnLocation = _buildingArray call BIS_fnc_selectRandom;
		_newGrpUnit = _newGrp createUnit [(EnemyUnits call BIS_fnc_selectRandom), _spawnLocation, [], 0, "NONE"];
		_dir = floor(random 360);
		_newGrpUnit setPosATL _spawnLocation;
		_newGrpUnit setFormDir _dir;
		_newGrpUnit SetDir _dir;
		_newGrpUnit setRank "PRIVATE";
		_newGrpUnit setSkill 0.3;
		_newGrpUnit forceSpeed GOL_UnitVarMove;
		_newGrpUnit setVariable ["GOL_Caching", true, true];
		doStop _newGrpUnit;
		_buildingArray = _buildingArray - [_spawnLocation];
	};
