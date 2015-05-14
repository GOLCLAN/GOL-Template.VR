// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Spawns a group that will defend a area within a radius.
// *		AI will also patrol in side the area, between buildings
// *
// *	Usage:
// *		["Vehicle", "Spawn", "Attack", true, true] call GVL_Fnc_AI_Vehicle_Attack;
// *
// *	Parameters:
// *		0:	String:	Vehicle that will spawn
// *		1:	String:	Spawning Location, either marker or object
// *		2:	Number:	Attack Area
// *		3:	Boolean:	Fill all available cargo space Default: False (Optional)
// *
// *	Returning Value:
// *		None
// *
// ================================================================

	if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs after and not players
	sleep 1;

	private ["_vehicle","_spawnLocation","_attack","_enableCargo","_cargo","_spawn","_veh","_newGrp","_newGrpUnit","_randomSelection","_freeCommanderPositions","_freeGunnerPositions","_freeCargoPositions"];

	_vehicle = [_this, 0, "I_Quadbike_01_F", [""]] call BIS_fnc_param;
	_spawnLocation = [_this, 1, "", [[],"",objNull]] call BIS_fnc_param;
	_attackLocation = [_this, 2, [0,0,0], [[],"",objNull]] call BIS_fnc_param;
	_enableCargo = [_this, 3, false, [true]] call BIS_fnc_param;

	_spawn = [_spawnLocation] call GVL_Fnc_GetPos;
	_attack = [_attackLocation] call GVL_Fnc_GetPos;

	if (typeName _enableCargo == "BOOL") then {
		_cargo = _enableCargo;
	};

	_veh = createVehicle [_vehicle, _spawn, [], 0, "None"];
		_freeCommanderPositions = _veh emptyPositions "Commander";
		_freeGunnerPositions = _veh emptyPositions "Gunner";
		_freeCargoPositions = _veh emptyPositions "Cargo";
	_newGrp = CreateGroup GVL_AI_Side;
	_randomSelection = GVL_AI_Faction call BIS_fnc_selectRandom;
	_newGrpUnit = _newGrp createUnit [_randomSelection, _spawn, [], 5, "FORM"];
		_newGrpUnit moveInDriver _veh;
	if (_freeGunnerPositions > 0) then {
		_newGrpUnit = _newGrp createUnit [_randomSelection, _spawn, [], 5, "FORM"];
			_newGrpUnit moveInGunner _veh;
	};
	if (_freeCommanderPositions > 0) then {
		_newGrpUnit = _newGrp createUnit [_randomSelection, _spawn, [], 10, "FORM"];
			_newGrpUnit moveInCommander _veh;
	};
	if (_cargo) then {
		for "_i" from 1 to ( _freeCargoPositions)do {
			sleep 0.2;
			_newGrpUnit = _newGrp createUnit [_randomSelection, _spawn, [], 10, "FORM"];
			_newGrpUnit setRank "PRIVATE";
			_newGrpUnit setSkill 0.2;
			_newGrpUnit addPrimaryWeaponItem "acc_flashlight";
			_newGrpUnit moveInCargo _veh;
		};
	};
		(group _newGrpUnit) enableGunLights "forceOn";
		[_newGrpUnit, _attack, 100] call CBA_fnc_taskAttack;
