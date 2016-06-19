/*	================================================================
	AUTHOR: GuzzenVonLidl
	Description:
		Copies position and direction in a array and should be used together with "GOL_Fnc_CreateAIStatic"
		Function can saves unlimited amount of units without clearing the array however recommended that you keep it less then 10 / group
	Usage:
		[""] call GOL_Fnc_CopyLocation;		// Copy players stance, if crouched ai will be 2
		["m2"] call GOL_Fnc_CopyLocation;	// Place static m2
		[true] call GOL_Fnc_CopyLocation;	// Clear array
	Parameters:
		#0: String-Boolean: Position
			Available static commands:
				USMC:		m2,m2tri,mk19,tow
				Russians:	kord,kordtri,ags,metis,igla
				Guerrillas:	dshkm,dshkmtri,spg9,zu23
	Returning Value:
		Position is stored in your clipboard
		Past it in to a document to store it
// ================================================================ */

	if (isMultiplayer) exitWith {false};

	private ["_switch","_DebugName","_positionsCopyed","_type","_mrk","_pos"];
	if (isNil "GOL_Copy_Location_Array") then {
		GOL_Copy_Location_Array = [];
		GOL_Copy_Location_Array_Markers = [];
	};

	_switch = [_this, 0, "", [true,""]] call BIS_fnc_param;
	if (typeName _switch isEqualTo "") Then {	tolower (_switch);	};

	_DebugName = "GOL_Fnc_CopyLocation";
	scriptName _DebugName;

	_positionsCopyed = {
		[["%1 Positions Copied",(count GOL_Copy_Location_Array)],[_DebugName,__FILE__,__LINE__],"both"] call GOL_Fnc_DebugLog;
		copyToClipboard (format ["%1 spawn GOL_Fnc_CreateAIStatic;", str(GOL_Copy_Location_Array)]);
	};

	switch (_switch) do {

		case "mortar": {
			_type = "B_Mortar_01_F";
		};

// ================================================================
//		USMC
		case "m2": {
			_type = "CUP_B_M2StaticMG_US";
		};
		case "m2tri": {
			_type = "CUP_B_M2StaticMG_MiniTripod_US";
		};
		case "mk19": {
			_type = "CUP_B_M119_US";
		};
		case "tow": {
			_type = "CUP_B_TOW_TriPod_US";
		};
		
// ================================================================
//		Russian
		case "kord": {
			_type = "CUP_O_KORD_high_RU";
		};
		case "kordtri": {
			_type = "CUP_O_KORD_RU";
		};
		case "ags": {
			_type = "CUP_O_D30_AT_RU";
		};
		case "metis": {
			_type = "CUP_O_Metis_RU";
		};
		case "igla": {
			_type = "CUP_O_ZU23_RU";
		};

// ================================================================

		case "auto": {
			_type = "Auto";
		};

		case "up": {
			_type = "UP";
		};

		case "mid": {
			_type = "Middle";
		};

		case "low": {
			_type = "Down";
		};

// ================================================================

		case true: {
			GOL_Copy_Location_Array = [];
			{
				deleteMarkerLocal _x;
			} forEach GOL_Copy_Location_Array_Markers;
			GOL_Copy_Location_Array_Markers = [];
			["Positions Cleared",[_DebugName,__FILE__,__LINE__],"both"] call GOL_Fnc_DebugLog;
			_type = true;
		};

		case "map": {
			if !(visibleMap) then {
				openMap true;
			};
			["GOL_CopyWaypoints", "onMapSingleClick", {
				GOL_Copy_Location_Array pushBack _pos;
				copyToClipboard (format ["%1", str(GOL_Copy_Location_Array)]);
				[["%1 Positions Copied",(count GOL_Copy_Location_Array)],[_DebugName,__FILE__,__LINE__],"both"] call GOL_Fnc_DebugLog;
				_mrk = createMarkerLocal [format ["GOL_Copy_Location_Array_Markers_%1", (count GOL_Copy_Location_Array_Markers)], _pos];
				_mrk setMarkerShapeLocal "ICON";
				_mrk setMarkerTypeLocal "hd_dot";
				_mrk setMarkerColor "ColorOrange";
				GOL_Copy_Location_Array_Markers pushBack _mrk;
			}] call BIS_fnc_addStackedEventHandler;

			[] spawn {
				waitUntil {sleep 1; !visibleMap};
				["GOL_CopyWaypoints", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
			};
		};

// ================================================================

		case "": {
			switch (stance player) do {
				case ("STAND"): {
					_type = "UP";
				};
				case ("CROUCH"): {
					_type = "Middle";
				};
				case ("PRONE"): {
					_type = "Down";
				};
				default {
					_type = "Auto";
				};
			};
		};

		default {
			_type = _switch;
		};
	};

	if (typeName _type == "STRING") then {
		GOL_Copy_Location_Array pushBack [getPosATL player, getDir player, _type];
		[] call _positionsCopyed;
		_mrk = createMarkerLocal [format ["GOL_Copy_Location_Array_Markers_%1", (count GOL_Copy_Location_Array_Markers)], getPosATL player];
		_mrk setMarkerShapeLocal "ICON";
		_mrk setMarkerTypeLocal "hd_dot";
		_mrk setMarkerColor "ColorOrange";
		GOL_Copy_Location_Array_Markers pushBack _mrk;
	};