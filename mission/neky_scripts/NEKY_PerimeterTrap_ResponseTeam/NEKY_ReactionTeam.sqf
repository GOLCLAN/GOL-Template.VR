//	null = [list TriggerName,2,ThisTrigger] execVM "Scripts\NEKY_ReactionTeam.sqf";
//		
//	Params:
//	1. List <TriggerName>
//	(A trigger zone with units in it)
//	(Make sure the trigger Activation is set to "<Side of AI you want to react>", ONCE and PRESENT)
//
//	2. Number
//	(Number of AI that will investigate)
//
//	3. Destination Trigger or Object
//	(That AI will investigate)
//
//	Made By NeKo-ArroW

if !(isServer) exitWith {};

Private ["_TempPos","_MoveToPos","_Temp","_Index2","_Index","_Units2","_Destination","_Units","_ThisList","_x","_Number","_Unit","_wp","_grp","_Side"];

_ThisList = [_This, 0, [], [[]]] call BIS_fnc_Param;
_Number = [_This, 1, 2, [0]] call BIS_fnc_Param;
_Destination = [_This, 2, ObjNull, [ObjNull]] call BIS_fnc_Param;

//	Units
if (_Number > 0) then
{
	_Units2 = [];
	{
		if (_x isKindOf "CAManBase" && !(isPlayer _x)) then 
		{
			_Units2 pushBack _x;	
		};
	} ForEach _ThisList;
	
	if (count _Units2 == 0) exitWith {};
	
	_Index = 0;
	_Index2 = 0;
	_Units = [];

	for "_i" from 1 to (count _Units2) do
	{
		if ((count _Units) < _Number) then
		{
			_Temp = (_Units2 select _Index);
			_TempPos = (getPosATL _Temp);
			
			if !(_Temp in _Units) then
			{
				if (speed _Temp <= 0) then
				{
					_MoveToPos = [((Position _Temp select 0) + 40),(Position _Temp select 1),(Position _Temp select 2)];
					_Temp doMove _MoveToPos;
					sleep 1.5;
				
					if (speed _Temp > 0) then
					{
						_Units pushBack _Temp;
						_Index2 = _Index2 + 1;
					};
					
					_Temp doMove _TempPos;
				
				} else {
					_Units pushBack _Temp;
					_Index2 = _Index2 + 1;
				};
			};
		};	
		_Index = _Index + 1;
	};
	
	_Side = side (_Units select 0);
	_grp = CreateGroup _Side;
	_Units join _grp;
	
	_wp = _grp addWaypoint [(Position _Destination),30,1];
	_grp setCurrentWaypoint [_grp,1];
	[_grp,1] setWaypointType "MOVE";
	[_grp,1] setWaypointSpeed "NORMAL";
	[_grp,1] setWaypointBehaviour "AWARE";
	[_grp,1] SetWaypointCombatMode "RED";
	_wp = _grp addWaypoint [(Position _Destination),30,2];
	[_grp,2] setWaypointType "SAD";
	[_grp,2] setWaypointSpeed "AUTO";
	[_grp,2] setWaypointBehaviour "COMBAT";
	[_grp,2] SetWaypointCombatMode "RED";
};