// ====================================================================================
// *
// *	Author: NeKo-ArroW
// *
// *	Description:
// *		I recommend using    this && {((getPosATL _x) select 2) < 10} count thislist > 0;    for trigger condition
// *
// *	Usage:
// *		[triggername, 10, "attack", east] call GVL_Fnc_ReactionTeam;
// *		Working colors:	White, Yellow, Red and Green flares available.
// *
// *	Parameter(s):
// *		#0	Object:		(A trigger zone with enemies in it)
// *		#1	Number:		(Number of AI that will investigate)
// *		#2	Object:		Destination:(That AI will investigate)
// *		#3	Side:		Side (West, East, Independent) that will investigate
// *
// *	Returning Value:
// *		Nothing
// *
// ====================================================================================

if !(isServer) exitWith {};

Private ["_Destination","_Units","_ThisList","_x","_Number","_Unit","_wp","_grp","_Side"];

_ThisList = _This select 0;
_Number = _This select 1;
_Destination = [(_this select 2)] call GVL_Fnc_GetPos;
_Side = _this select 3;

_Units = [];

{
        side _x == _Side;
        _Unit = _ThisList call BIS_fnc_SelectRandom;
        if (!(_Unit in _Units) and (Alive _x) and ((count _Units) < _Number)) then
        {
                _Units pushBack _Unit;
        };
} ForEach _ThisList;

{_x domove (position _x)} forEach _Units;
_grp = CreateGroup _Side;
_Units join _grp;

_wp = _grp addWaypoint [_Destination,30,1];
_grp setCurrentWaypoint [_grp,1];
[_grp,1] setWaypointType "MOVE";
[_grp,1] setWaypointSpeed "NORMAL";
[_grp,1] setWaypointBehaviour "AWARE";
[_grp,1] SetWaypointCombatMode "RED";
_wp = _grp addWaypoint [_Destination,30,2];
[_grp,2] setWaypointType "SAD";
[_grp,2] setWaypointSpeed "LIMITED";
[_grp,2] setWaypointBehaviour "AWARE";
[_grp,2] SetWaypointCombatMode "RED";
