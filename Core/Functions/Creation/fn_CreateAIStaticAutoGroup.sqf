/*	================================================================
	AUTHOR: R4IDER

	Description:
		Spawns units in positions from one big array and automatically groups them for you.

	Usage:
		[[[461.042,1304.65,0.00143862],330,"UP"],[[461.042,1304.65,0.00143862],330,"Middle"]] call GOL_Fnc_CreateAIStaticAutoGroup;

	Parameters:
		#0:	Array:	Position, direction and stance

	Returning Value:
		None

// ================================================================ */

	if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs after and not players

	private ["_newGrp","_spawnLocation","_dir","_stance","_randomSelection","_newGrpUnit"];
	
	_count = count _this;
	_team = _count / 3; _team = floor _team;
	if (_team > 4) then { _team = 4; };
	_loop = 1;

	sleep 1;
	{
		if (_loop == 1) then {
			_newGrp = CreateGroup EnemySide;
		};
		if (_loop == _team) then {
			_loop = 0;
		};
		_spawnLocation = (_x select 0);
		_dir = (_x select 1);
		_stance = (_x select 2);
		if (isNil "_stance") then { _stance = "AUTO"; };
		if (_stance == "random") then {
			_stance = ["MIDDLE","UP"] call BIS_fnc_selectRandom;
		};
		
		_randomSelection = (EnemyUnits call BIS_fnc_selectRandom);
		
		_newGrpUnit = _newGrp createUnit [_randomSelection, _spawnLocation, [], 0, "NONE"];
		_newGrpUnit setPosATL _spawnLocation;
		_newGrpUnit setFormDir _dir;
		_newGrpUnit SetDir _dir;
		sleep 0.1;
		_newGrpUnit SetDir _dir;
		_newGrpUnit setPosATL _spawnLocation;
		_newGrpUnit setRank "PRIVATE";
		_newGrpUnit setSkill 0.5;
		_newGrpUnit setUnitPos _stance;
		_newGrpUnit forceSpeed GOL_UnitVarMove; // 2 out of 3 time unit will be static
		_newGrpUnit setVariable ["GOL_Caching", true, true];
		doStop _newGrpUnit;

		_stance = nil;
		_loop = _loop + 1;
		//hint format["%1 - %2", _team, _loop];
		sleep 1;
	} forEach _this;
