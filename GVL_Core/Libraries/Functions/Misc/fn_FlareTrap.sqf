// ====================================================================================
// *
// *	Author: NeKo-ArroW
// *
// *	Description:
// *		I recommend using    this && {((getPosATL _x) select 2) < 10} count thislist > 0;    for trigger condition
// *
// *	Usage:
// *		["Color", triggername] call GVL_Fnc_FlareTrap;
// *		Working colors:	White, Yellow, Red and Green flares available.
// *
// *	Parameter(s):
// *		#0	String:		Color of flare, White, Yellow, Red and Green flares available
// *		#1	Object:		Position for the flare
// *
// *	Returning Value:
// *		Nothing
// *
// ====================================================================================

	if (!isServer) exitWith {false};

	private ["_DebugName","_Color","_Position","_FlareColor","_Flare"];
	_DebugName = "NEKY_FlareTrap";
	scriptName _DebugName;

	if (!isServer) exitWith {false};

	private ["_Color","_Position","_FlareColor","_Flare"];

	_Color = [_this, 0, "", [""]] call BIS_fnc_Param;
	_Position = [_this, 1, objNull, [objNull]] call BIS_fnc_Param;

	_FlareColor = Format ["F_20mm_%1",_Color];

	// Flare sequence
	playSound3D ["A3\sounds_f\weapons\Flare_Gun\flaregun_2.wss", _Position, false, (getposASL _Position), 5, 1, 100];
	sleep 1;

	_Flare = CreateVehicle [_FlareColor, [(getpos _Position) select 0, (getposATL _Position) select 1,200],[],0,"CAN_COLLIDE"];
	_Flare setVelocity [0,0,-10];
	sleep 3.1;

	playSound3D ["A3\Sounds_F\weapons\Flare_Gun\flaregun_2_shoot.wss", _Flare, false, [getpos _Position select 0, getpos _Position select 1, 200], 8, 1, 300];
