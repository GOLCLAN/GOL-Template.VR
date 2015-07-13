/*	================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		TelePort player to a object

	Usage:
		[player, gol_flag] call GOL_fnc_Teleport;
		player addAction ["Teleport1",{[player,gol_flag] call GOL_Fnc_Teleport}];

	Parameters:
		#0:	String:		Unit
		#1:	String:		Target

	Returning Value:
		None

// ================================================================ */

	private ["_unit","_dest","_Teleportar","_freeCargoPositions"];

	_unit = [_this, 0, player, [objNull]] call BIS_fnc_param;
	_dest = [_this, 1, objNull, [objNull,""]] call BIS_fnc_param;

	_Teleportar = {
		if (typeName _dest isEqualTo "STRING") Then {
			_unit setPos ([[getMarkerPos _dest select 0, getMarkerPos _dest select 1, (getMarkerPos _dest select 2) + 0.1], 5, markerDir _dest - 180] call BIS_fnc_relPos);
		};

		if (typeName _dest isEqualTo "OBJECT") Then {
			_unit setPos ([[getPosATL _dest select 0, getPosATL _dest select 1, (getPosATL _dest select 2) + 0.1], 5, getDir _dest - 180] call BIS_fnc_relPos);
			player setDir ([player, _dest] call BIS_fnc_dirTo);
		};

	};

	if (_dest isKindOf "LandVehicle" || _dest isKindOf "Air" || _dest isKindOf "Ship") Then {
		_freeCargoPositions = _dest emptyPositions "Cargo";
		if (_freeCargoPositions > 0) Then {
			["Teleported to MHQ's cargo", 5] call GOL_Fnc_Hint;
			_unit moveInCargo _dest;
		} else {
			if (!isengineOn _dest || (speed _dest) isEqualTo 0) Then {
				["The MHQ is stationary", 5] call GOL_Fnc_Hint;
				[] call _Teleportar;
			} else {
				["The MHQ is filed up & on the move, wait until they stop and try again", 5] call GOL_Fnc_Hint;
			};
		};
	} else {
		[] call _Teleportar;
	};
