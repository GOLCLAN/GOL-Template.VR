// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Spawning in a group and attacking a area
// *		AI will spawn and move straight towards the enemy in normal speed, once contact is meet they will spread out
// *
// *	Usage:
// *		["Spawn", 3, "attack", "obj_1", true, 0.3] call GVL_fnc_AI_Inf_Group;
// *		["Spawn", 3, "attackadv", ["obj_1", 50], true, 0.3] call GVL_fnc_AI_Inf_Group;
// *		["Spawn", 3, "defend", ["obj_1", 50, false], true, 0.3] call GVL_fnc_AI_Inf_Group;
// *		["Spawn", 3, "patrol", ["obj_1", 50, 10], true, 0.3] call GVL_fnc_AI_Inf_Group;
// *
// *	Parameters:
// *		NOTE: if param have a Default it is also optional
// *		0:	String:		Spawning Location, either marker or object
// *		1:	Number:		Amount of enemies to spawn
// *
// *		2:	String:		What the group should do when it spawns
// *				-	"attack":	Makes ai attack a specific area
// *				-	"attackadv":	Makes ai attack a area but will do so more cearful then the one above
// *				-	"defend":	Makes ai defend defend a area
// *				-	"patrol":	Makes ai patrol when they spawn
// *
// *		3:	-	This one relies soly on the param above.
// *
// *			String: -	If "attack" is selected above then
// *				0: String - Attacking area
// *
// *			Array:	-	If "attackadv" is selected above then
// *				0: String - Attacking area
// *				1: Number - Area to search around target,	(Default: 100)
// *
// *			Array:	-	If "defend" is selected above then
// *				0: String - Defending area,	(Default: spawn position of group)
// *				1: Number - Area to around target to defend,	(Default: 100)
// *				2: Boolean - Group will mount nearby static machine guns, occupy nearby buildings and patrol area, (Default: True)
// *
// *			Array:	-	If "patrol" is selected above then
// *				0: String - Patroling area,		(Default: spawn position of group)
// *				1: Number - Radius to patrol,	(Default: 300)
// *				2: Number - waypoints given to the group,	(Default: 10)
// *
// *		4:	Boolean:	Force flashlights when night (Default: true)
// *		5:	Number:		Unit Skill (Default: 0.2)
// *
// *	Returning Value:
// *		None
// *
// ================================================================

	if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs after and not players

	_this spawn {
		private ["_typeOfObjective","_objectParams","_attackPos","_newGrp","_area","_newGrpUnit","_radius","_patrol","_waypoints","_spawnLocation","_number","_skill","_spawn","_randomSelection","_Marker","_flashlight"];

		_spawnLocation = [_this, 0, "", [[],"",objNull]] call BIS_fnc_param;
		_number = [_this, 1, 2, [0]] call BIS_fnc_param;
		_typeOfObjective = [_this, 2, "patrol", [""]] call BIS_fnc_param;
		_objectParams = [_this, 3] call BIS_fnc_param;
		_flashlight = [_this, 4, true, [true]] call BIS_fnc_param;
		_skill = [_this, 5, 0.2, [0]] call BIS_fnc_param;

		_spawn = [_spawnLocation] call GVL_Fnc_GetPos;

		_newGrp = CreateGroup GVL_AI_Side;
		for "_i" from 1 to _number do {
			sleep (0.5 + (random 1));	// Needs checking
			_randomSelection = GVL_AI_Faction call BIS_fnc_selectRandom;
			_newGrpUnit = _newGrp createUnit [_randomSelection, _spawn, [], 10, "FORM"];
				_newGrpUnit setRank "PRIVATE";
				_newGrpUnit setSkill _skill;
				_newGrpUnit addPrimaryWeaponItem "acc_flashlight";

/*
			[_newGrpUnit] spawn {
				_newGrpUnit = _this select 0;
				WaitUntil { sleep 30; !Alive _newGrpUnit; };
				if (!Alive _newGrpUnit) then {
					sleep 10;
					deleteVehicle _newGrpUnit;
				};
			};
*/

		};
		if (_flashlight) Then {
			_newGrp enableGunLights "forceOn";
		};

		[_typeOfObjective, _objectParams] call GVL_fnc_AI_Inf_Group_Commands;

	};
