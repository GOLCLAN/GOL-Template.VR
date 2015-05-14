// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Copies position and direction in a array and should be used together with "GVL_Fnc_AI_Static_Group"
// *		Function saves a maximum of 10 positions at once
// *
// *	Usage:
// *		["up"] call GVL_Fnc_CopyLocation;
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

	if (isNil "GVL_Copy_Location_Array") Then {
		GVL_Copy_Location_Array = [];
	};

	private ["_switch","_DebugName","_positionsCopyed"];

	_switch = [_this, 0, "up", [true,""]] call BIS_fnc_param;

	if (typeName _switch == "") Then {	tolower (_switch);	};

	_DebugName = "GVL_Fnc_CopyLocation";
	scriptName _DebugName;

	_positionsCopyed = {
		[["%1 Positions Copied",(count GVL_Copy_Location_Array)],[_DebugName,__FILE__,__LINE__],"both"] call GVL_Fnc_DebugLog;
		copyToClipboard (format ["%1 call GVL_Fnc_AI_Inf_Group_Static;", str(GVL_Copy_Location_Array)]);
	};

	switch (_switch) do {

	    case true: {
			GVL_Copy_Location_Array = [];
			[["Positions Cleared",(count GVL_Copy_Location_Array)],[_DebugName,__FILE__,__LINE__],"both"] call GVL_Fnc_DebugLog;
	    };

	    case "auto": {
			GVL_Copy_Location_Array pushBack [getPosATL player, getDir player, "Auto"];
			[] call _positionsCopyed;
	    };

	    case "up": {
			GVL_Copy_Location_Array pushBack [getPosATL player, getDir player, "UP"];
			[] call _positionsCopyed;
	    };

	    case "mid": {
			GVL_Copy_Location_Array pushBack [getPosATL player, getDir player, "Middle"];
			[] call _positionsCopyed;
	    };

	    case "low": {
			GVL_Copy_Location_Array pushBack [getPosATL player, getDir player, "Down"];
			[] call _positionsCopyed;
	    };

	    default {
			GVL_Copy_Location_Array pushBack [getPosATL player, getDir player, "Up"];
			[] call _positionsCopyed;
	    };
	};
