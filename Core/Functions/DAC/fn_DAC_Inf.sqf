// ================================================================
// *
// *	Description:
// *		All objects from a array will placed on the map
// *
// *	Usage:
// *		["z1",1,"east",0,1,[5,2,25,7]] call GOL_Fnc_DAC_Inf;
// *
// *	Parameters:
// *		0: String: Name of trigger
// *		1: Number: ID of zone (Default 0)
// *		2: String: Side of zone "east" || "west" || "independent"
// *		3: Number: Type of units
// *		4: Number: Behaviour of the group
// *		5: Array: Group size
// *			0: Number: Amount of Groups
// *			1: Number: Group size
// *			2: Number: Waypoints for the zone
// *			3: Number: Waypoints for each group
// *
// *	Returning Value:
// *		Adds each object to a array
// *
// ================================================================

	if (!isServer) exitWith {false};

	_dacZone = _this select 0;
	_id = _this select 1;
	_side = _this select 2;
	_units = _this select 3;
	_behaviour = _this select 4;
	_group = _this select 5;

	switch (_side) do {
	    case "east": {
	    	_side = 0;
	    };
	    case "west": {
	    	_side = 1;
	    };
	    case "independent": {
	    	_side = 2;
	    };
	    default {
	    	_side = 3;
	    };
	};

	[_dacZone,[_id,0,0],[_group],[],[],[],[_side, _units, _behaviour,0]] spawn DAC_Zone;
