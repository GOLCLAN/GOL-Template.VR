/*	================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		Spawns units in positions from one big array.
		Function allows a maximum of 10 units and should be used together with "GOL_Fnc_CopyLocation"

	Usage:
		[[[461.042,1304.65,0.00143862],330,"UP"],[[461.042,1304.65,0.00143862],330,"Middle"]] call GOL_Fnc_CreateAIStatic;
		[[[438.991,1276.77,0.00143909],358.391,"B_G_Offroad_01_armed_F"]] spawn GOL_Fnc_CreateAIStatic;

	Parameters:
		#0:	Array:	Position, direction and stance

	Returning Value:
		None

// ================================================================ */

	if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs after and not players

	private ["_newGrp","_spawnLocation","_dir","_stance","_vehClass","_randomSelection","_newGrpUnit","_veh"];

	sleep 1;
	_newGrp = CreateGroup EnemySide;
	{
		_spawnLocation = (_x select 0);
		_dir = (_x select 1);
		if ((_x select 2) in ["Auto","UP","Middle","Down"]) then {
			_stance = (_x select 2);
		} else {
			_vehClass = (_x select 2);
		};

		if (isNil "_stance") then { _stance = "Auto"; };
		_randomSelection = (EnemyUnits call BIS_fnc_selectRandom);
		_newGrpUnit = _newGrp createUnit [_randomSelection, _spawnLocation, [], 0, "NONE"];
			_newGrpUnit setPosATL _spawnLocation;
			_newGrpUnit setFormDir _dir;
			_newGrpUnit SetDir _dir;
			sleep 0.1;
			_newGrpUnit SetDir _dir;
			_newGrpUnit setPosATL _spawnLocation;
			_newGrpUnit setRank "PRIVATE";
			_newGrpUnit setSkill 0.4;
			_newGrpUnit setUnitPos _stance;
			_newGrpUnit forceSpeed GOL_UnitVarMove; // 2 out of 3 time unit will be static
			_newGrpUnit setVariable ["GOL_Caching", true, true];
			doStop _newGrpUnit;

		if (!isNil "_vehClass") then {
			_veh = _vehClass createVehicle _spawnLocation;
			_veh setPosATL _spawnLocation;
			_veh SetDir (_dir + ([floor(random 90),floor(-random 90)] call BIS_fnc_selectRandom));
			_newGrpUnit moveInGunner _veh;
			_newGrpUnit assignAsGunner _veh;
		};
		_stance = nil;
		_vehClass = nil;
		sleep 1;
	} forEach _this;
