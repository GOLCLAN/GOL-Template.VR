/*	================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		Spawning in a vehicle and then patrols or attacks a location

	Usage:
		["B_G_Offroad_01_armed_F","zone1", "attack", ["zone2","zone3","zone1"], true, 90] spawn GOL_Fnc_AI_Vehicle;
		["B_G_Offroad_01_armed_F","zone1", "attackadv", [["zone2","zone3","zone1"],100], true] spawn GOL_Fnc_AI_Vehicle;
		["B_G_Offroad_01_armed_F","zone1", "patrol", ["zone2",50,10], true] spawn GOL_Fnc_AI_Vehicle;
		["B_G_Offroad_01_armed_F","zone1", "patroladv", [[400.816,1364.48,0],"zone2","zone3","zone1"], true] spawn GOL_Fnc_AI_Vehicle;

	Parameters:
		#0:	String:		Classname of what vehicle to spawn
		#1:	Array|String|Object:		Spawning Location, either marker or object

		#2:	String:		What the group should do when it spawns
				-	"attack":		Makes ai attack a specific area
				-	"attackadv":	Makes ai attack a area but will do so more cearful then the one above
				-	"patrol":		Makes ai patrol and get random WP
				-	"patroladv":	Makes ai patrol with predefined WP from the editor

		#3:	-	This one relies soly on the param above.
			Array:	-	If "attack" is selected above then
				#0: Array - this is a array of waypoints to move to, last one is a attack order
			Array:	-	If "attackadv" is selected above then
				#0: Array - Same as above however last WP will be moved to with extreme caution
			Array:	-	If "patrol" is selected above then
				#0: String - Patroling area,		(Default: spawn position of group)
				#1: Number - Radius to patrol,	(Default: 300)
				#2: Number - waypoints given to the group,	(Default: 10)
			Array:	-	If "patroladv" is selected above then
				#0: Array - this is a array of waypoints to patrol
		4:	Boolean:	Fill all available cargo space Default: False (Optional)
		5:	Number:	Sets the direction of the vehicle: Default Random 360 (Optional)

	Returning Value:
		None

// ================================================================	*/

	if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs after and not players

	private ["_vehicle","_spawnLocation","_typeOfObjective","_objectParams","_enableCargo","_spawn","_cargo","_veh","_freeCommanderPositions","_freeGunnerPositions","_freeCargoPositions","_newGrp","_randomSelection","_newGrpUnit"];
	_vehicle = [_this, 0, "", [[],"",objNull]] call BIS_fnc_param;
	_spawnLocation = [_this, 1, "", [[],"",objNull]] call BIS_fnc_param;
	_typeOfObjective = [_this, 2, "patrol", [""]] call BIS_fnc_param;
	_objectParams = [_this, 3] call BIS_fnc_param;
	_enableCargo = [_this, 4, false, [true]] call BIS_fnc_param;
	_direction = [_this, 5, (floor(random 360)), [0]] call BIS_fnc_param;

	_spawn = [_spawnLocation] call GOL_Fnc_GetPos;

	_veh = createVehicle [_vehicle, _spawn, [], 0, "None"];
	_veh setDir _direction;
		_freeCommanderPositions = _veh emptyPositions "Commander";
		_freeGunnerPositions = _veh emptyPositions "Gunner";
		_freeCargoPositions = _veh emptyPositions "Cargo";
	_newGrp = CreateGroup EnemySide;
	_randomSelection = EnemyUnits call BIS_fnc_selectRandom;
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
	if (_enableCargo) then {
		for "_i" from 1 to ( _freeCargoPositions)do {
			sleep 1;
			_randomSelection = EnemyUnits call BIS_fnc_selectRandom;
			_newGrpUnit = _newGrp createUnit [_randomSelection, _spawn, [], 10, "FORM"];
			_newGrpUnit setRank "PRIVATE";
			_newGrpUnit setSkill 0.2;
			_newGrpUnit addPrimaryWeaponItem "acc_flashlight";
			_newGrpUnit moveInCargo _veh;
		};
	};
	(group _newGrpUnit) enableGunLights "forceOn";

	#include "waypoints.sqf"

	(group _newGrpUnit)
