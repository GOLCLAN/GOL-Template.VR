/*	================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		Gets the correct respawn marker for the side the player is on

	Usage:
		[_unit] call GOL_Fnc_GetSide;

	Parameters:
		#0:	OBJECT - Gets side of player

	Returning Value:
		Respawn marker name

// ================================================================ */

	private ["_unit","_returnValue","_DebugName"];

	_unit = (_this select 0);

	switch (side _unit) do {

		case blufor: {
			_returnValue = "respawn_west";
		};

		case opfor: {
			_returnValue = "respawn_east";
		};

		case independent: {
			_returnValue = "respawn_resistance";
		};

		case civilian: {
			_returnValue = "respawn_civilian";
		};

		case sideEnemy: {
			_unit addRating 10000;
			_returnValue = [_unit] call GOL_Fnc_GetSide;
		};

		default {
			_DebugName = "GOL_Fnc_GetSide";
			scriptName _DebugName;
			[["%1 No respawn maker assigned/found!", (typeName _unit)],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		};

	};
	_returnValue
