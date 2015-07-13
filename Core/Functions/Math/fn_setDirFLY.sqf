/*	================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *
// *
// *	Usage:
// *		[plane1,90] call GOL_Fnc_setDirFly;
// *		[Vehicle, Diraction to face] call GOL_Fnc_setDirFly;
// *
// *	Parameters:
// *		#0:	OBJECT - Vehicle to apply settings to
// *		#1:	NUMBER -
// *
// *	Returning Value:
// *		None
// *
// ================================================================ */

	 private ["_veh","_dir","_speed"];

	 _veh = _this select 0;
	 _dir = _this select 1;

	 _speed = velocity _veh;

	 _veh setDir _dir;
	 _veh setVelocity [
	 	(_speed select 1) * sin _dir - (_speed select 0) * cos _dir,
	 	(_speed select 0) * sin _dir + (_speed select 1) * cos _dir,
	 	_speed select 2
	];
