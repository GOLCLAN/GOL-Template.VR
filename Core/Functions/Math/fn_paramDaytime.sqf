/*	================================================================
	AUTHOR: Karel Moricky	MODIFIED: GuzzenVonLidl


	Description:
		Sets the time of day by hour, does not effect day, month, year or minute

	Usage:
		[5] call GOL_Fnc_paramDaytime;

	Parameters:
		#0:	NUMBER - Sets time of day by hour

	Returning Value:
		Date

// ================================================================ */

private ["_hour","_date"];
_hour = [_this,0,daytime,[0]] call bis_fnc_param;
_date = date;
_date set [3,_hour];
[_date] call bis_fnc_setDate;
_date
