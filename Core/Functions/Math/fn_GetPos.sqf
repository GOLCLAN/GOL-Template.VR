/* ================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		Gets location of a marker, object or array ([0,0,0])

	Usage:
		[MHQ] call GOL_Fnc_GetPos;	// Object
		["Hello"] call GOL_Fnc_GetPos;	// Marker

	Parameters:
		#0:	OBJECT || STRING || ARRAY - Gets location from a place

	Returning Value:
		Position

// ================================================================ */

	private ["_type","_returnValue","_DebugName"];

	_type = _this select 0;

	switch (typeName _type) do {

		case "STRING": {
			if ((getMarkerPos _type) isEqualTo [0,0,0]) then {
				systemChat format ["Marker %1 does not exist, Returning [0,0,0] Instead", _type];
				_returnValue = getMarkerPos _type;
			} else {
				_returnValue = getMarkerPos _type;
			};
		};

		case "OBJECT": {
			_returnValue = getPosATL _type;
		};

		case "GROUP": {
			_returnValue = getPosATL (leader _type);
		};

		case "LOCATION": {
			_returnValue = position _type;
		};

		case "ARRAY": {
			_returnValue = _type;
		};

		default {
			_DebugName = "GOL_Fnc_GetPos";
			scriptName _DebugName;
			[["%1 was passed to this function, only accepts STRING, OBJECT, GROUP, LOCATION or ARRAY", (typeName _type)],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		};

	};

	_returnValue
