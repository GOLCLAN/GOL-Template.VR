// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Copies position and direction in a array and should be used together with "GOL_Fnc_AI_Static_Group"
// *		Function saves a maximum of 10 positions at once
// *
// *	Usage:
// *		["up"] call GOL_Fnc_CopyLocation;
// *
// *	Parameters:
// *		0: String-Boolean: Position
// *
// *	Returning Value:
// *		Position is stored in your clipboard
// *		Past it in to a document to store it
// *
// ================================================================

	if (isMultiplayer) exitWith {false};

	if (isNil "GOL_Copy_Location_Array") Then {
		GOL_Copy_Location_Array = [];
	};

	private ["_switch","_DebugName","_positionsCopyed"];

	_switch = [_this, 0, "up", [true,""]] call BIS_fnc_param;

	if (typeName _switch == "") Then {	tolower (_switch);	};

	_DebugName = "GOL_Fnc_CopyLocation";
	scriptName _DebugName;

	_positionsCopyed = {
		[["%1 Positions Copied",(count GOL_Copy_Location_Array)],[_DebugName,__FILE__,__LINE__],"both"] call GOL_Fnc_DebugLog;
		copyToClipboard (format ["%1 call GOL_Fnc_AI_Inf_Group_Static;", str(GOL_Copy_Location_Array)]);
	};

	switch (_switch) do {

	    case true: {
			GOL_Copy_Location_Array = [];
			[["Positions Cleared",(count GOL_Copy_Location_Array)],[_DebugName,__FILE__,__LINE__],"both"] call GOL_Fnc_DebugLog;
	    };

	    case "auto": {
			GOL_Copy_Location_Array pushBack [getPosATL player, getDir player, "Auto"];
			[] call _positionsCopyed;
	    };

	    case "up": {
			GOL_Copy_Location_Array pushBack [getPosATL player, getDir player, "UP"];
			[] call _positionsCopyed;
	    };

	    case "mid": {
			GOL_Copy_Location_Array pushBack [getPosATL player, getDir player, "Middle"];
			[] call _positionsCopyed;
	    };

	    case "low": {
			GOL_Copy_Location_Array pushBack [getPosATL player, getDir player, "Down"];
			[] call _positionsCopyed;
	    };

	    default {
			GOL_Copy_Location_Array pushBack [getPosATL player, getDir player, (["UP","UP","Middle","Auto"] call BIS_fnc_selectRandom)];
			[] call _positionsCopyed;
	    };
	};
