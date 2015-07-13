/*	================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		Spawning in a group and attack, patrol or defend a area

	Usage:
		["zone1", 3, "attack", ["zone2","zone3"]] spawn GOL_fnc_AI_Inf_Group;
		["zone1", 3, "attackadv", [["zone2","zone3"], 50]] spawn GOL_fnc_AI_Inf_Group;
		["zone1", 3, "patrol", ["zone1", 50,10]] spawn GOL_fnc_AI_Inf_Group;
		["zone1", 3, "patroladv", [[400.816,1364.48,0],"zone2","zone3","zone1"]] spawn GOL_fnc_AI_Inf_Group;

	Parameters:
		NOTE: if param have a Default it is also optional
		#0:	String:		Spawning Location, either marker or object
		#1:	Number:		Amount of enemies to spawn

		#2:	String:		What the group should do when it spawns
				-	"attack":	Makes ai attack a specific area
				-	"attackadv":	Makes ai attack a area but will do so more cearful then the one above
				-	"defend":	Makes ai defend defend a area
				-	"patrol":	Makes ai patrol when they spawn

		#3:	-	This one relies soly on the param above.

			String: -	If "attack" is selected above then
				#0: String - Attacking area

			Array:	-	If "attackadv" is selected above then
				#0: String - Attacking area
				#1: Number - Area to search around target,	(Default: 100)

			Array:	-	If "defend" is selected above then
				#0: String - Defending area,	(Default: spawn position of group)
				#1: Number - Area to around target to defend,	(Default: 100)
				#2: Boolean - Group will mount nearby static machine guns, occupy nearby buildings and patrol area, (Default: True)

			Array:	-	If "patrol" is selected above then
				#0: String - Patroling area,		(Default: spawn position of group)
				#1: Number - Radius to patrol,	(Default: 300)
				#2: Number - waypoints given to the group,	(Default: 10)

		#4:	Boolean:	Force flashlights when night (Default: true)
		#5:	Number:		Unit Skill (Default: 0.2)

	Returning Value:
		None

// ================================================================ */

	if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs after and not players

	private ["_spawnLocation","_number","_waypoints","_flashlight","_skill","_spawn","_newGrp","_randomSelection","_newGrpUnit","_attackPos","_wp"];

	_spawnLocation = [_this, 0, "", [[],"",objNull]] call BIS_fnc_param;
	_number = [_this, 1, 2, [0]] call BIS_fnc_param;
	_typeOfObjective = [_this, 2, "patrol", [""]] call BIS_fnc_param;
	_objectParams = [_this, 3] call BIS_fnc_param;
	_flashlight = [_this, 4, true, [true]] call BIS_fnc_param;
	_skill = [_this, 5, 0.2, [0]] call BIS_fnc_param;

	_spawn = [_spawnLocation] call GOL_Fnc_GetPos;

	_newGrp = CreateGroup EnemySide;
	for "_i" from 1 to _number do {
		sleep (0.5 + (random 1));
		_randomSelection = EnemyUnits call BIS_fnc_selectRandom;
		_newGrpUnit = _newGrp createUnit [_randomSelection, _spawn, [], 10, "FORM"];
			_newGrpUnit setRank "PRIVATE";
			_newGrpUnit setSkill 0.3;
			_newGrpUnit addPrimaryWeaponItem "acc_flashlight";
			_newGrpUnit setVariable ["GOL_Caching", true, true];
	};

	#include "waypoints.sqf"

	(group _newGrpUnit) enableGunLights "forceOn";
	(group _newGrpUnit)
