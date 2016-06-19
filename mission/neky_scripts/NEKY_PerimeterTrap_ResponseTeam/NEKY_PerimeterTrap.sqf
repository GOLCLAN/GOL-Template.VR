//	[ThisTrigger,"Color","sound",range,units] execVM "Scripts\NEKY_PerimeterTrap.sqf";
//	Null = [ThisTrigger,"Color","sound",range,units] execVM "Scripts\NEKY_PerimeterTrap.sqf";
//
//	1. Set Activation to "(side the trap will apply to)", ONCE and PRESENT
//	2. In trigger condition enter:     											this && {((getPosATL _x) select 2) < 5} count thislist > 0;
// 	2b. If you want it to apply to only players, use this:						this && {isPlayer _x && ((getPosATL _x) select 2) < 5} count thislist > 0;
//	3. In trigger on act enter: 	  											Null = [ThisTrigger,"Color","sound",range,units] execVM "Scripts\NEKY_PerimeterTrap.sqf";
//	4. Change "Color" to the color of smoke/flare you want if you want one.
//	5. (OPTIONAL) Change "sound" to the sound effect you want if you want one. (Default = Off)
//	6. (OPTIONAL) Change Range to a number. This is the range (in meters) around the trap in which AI will react and investigate the trap that fired. (Default = Off)
//	6b. Change Units to the number of AI you want to respond to the trap. (Default = Off)
//
//	Available flares: White, Yellow, Red and Green. (if a color not in this list is used, a white flare will be used)
//	Available smokes: White, Yellow, Red, Green, Purple, Blue and Orange. (if a color not in this list is used, a white smoke will be used)
//	Available alarms: "carAlarm" and "alarm".
//
//	For no smoke or flare, leave the string "color" empty. ( "" )
// 	For no sound effect, leave the string "sound" empty. ( "" )
//
//	Made by NeKo-ArroW 

if (!isServer) exitWith {false};

private ["_TempPos","_SmokeColors","_FlareColors","_ThisList","_wp","_grp","_Index","_Index2","_Units","_Units2","_Temp","_MoveToPos","_Trg","_NumberOfUnits","_AggroRange","_Volume","_Range","_SmokeColor","_Sound","_Smoke","_DayTime","_Color","_Position","_FlareColor","_Flare"];

if ((dayTime > 04.30) and (dayTime < 19.30)) then {_DayTime = True} else {_DayTime = False};

_Position = [_this, 0, objNull, [objNull]] call BIS_fnc_Param;
_Color = toLower ([_this, 1, "", [""]] call BIS_fnc_Param);
_Sound = toLower ([_this, 2, "", [""]] call BIS_fnc_Param);
_AggroRange = [_this, 3, 0, [0]] call BIS_fnc_Param;
_NumberOfUnits = [_This, 4, 0, [0]] call BIS_fnc_Param;


// 	Alarm
Switch (_Sound) do
{
	Private ["_Sound","_Volume","_Range"];
	case "caralarm":
	{
		_Sound = "A3\sounds_f\sfx\alarmCar.wss";
		_Volume = 2;
		_Range = 150;
	};
	
	case "alarm":
	{
		_Sound = "A3\sounds_f\sfx\alarm.wss";
		_Volume = 5;
		_Range = 150;
	};
	
	default {_Sound = ""};
};

if !(_Sound == "") then 
{
	[_Sound,_Position,_Volume,_Range] spawn
	{
		_Sound = _This select 0;
		_Position = _This select 1;
		_Volume = _This select 2;
		_Range = _This select 3;
		
		for "_i" from 1 to 24 do
		{
			playSound3D [_Sound, _Position, false, (getPosASL _Position), _Volume, 1, _Range];
			sleep 2;
		};	
	};
};

//	Smoke
if _Daytime then 
{
	if !(_Color == "") then 
	{
		_SmokeColors = ["white","yellow","red","green","blue","purple","orange"];
		if (!(_Color in _SmokeColors) or (_Color == "white")) then {_Color = ""};
		_SmokeColor = Format ["SmokeShell%1",_Color];
		_Smoke = CreateVehicle [_SmokeColor, [0,0,0],[],0,"CAN_COLLIDE"];
		sleep 0.5;
		_Smoke setPosATL [(getposATL _Position) select 0, (getposATL _Position) select 1, 10];
		sleep 0.5;
		playSound3D ["A3\sounds_f\arsenal\weapons\UGL\UGL_02.wss", _Position, false, (getPosASL _Position), 1, 1, 40];
		_Smoke setVelocity [0,0,35];
	};
};

//	Flare
if !_DayTime then 
{
	if !(_Color == "") then 
	{
		_FlareColors = ["white","yellow","red","green"];
		if !(_Color in _FlareColors) then {_Color = "white"};
		_FlareColor = Format ["F_20mm_%1",_Color];
		
		playSound3D ["A3\sounds_f\weapons\Flare_Gun\flaregun_2.wss", _Position, false, (getposASL _Position), 5, 1, 100];
		UIsleep 1;

		_Flare = CreateVehicle [_FlareColor, [(getposATL _Position) select 0, (getposATL _Position) select 1,200],[],0,"CAN_COLLIDE"];
		_Flare setVelocity [0,0,-10];
		UIsleep 3.1;

		playSound3D ["A3\Sounds_F\weapons\Flare_Gun\flaregun_2_shoot.wss", _Flare, false, [getpos _Position select 0, getpos _Position select 1, 200], 8, 1, 300];
	};
};

//	Aggro Range
if (_AggroRange > 0) then
{
	_Trg = CreateTrigger ["EmptyDetector", (GetPosATL _Position)];
	_Trg setTriggerArea [_AggroRange,_AggroRange,0,false];
	_Trg SetTriggerActivation ["ANY","PRESENT",true];
	sleep 0.5;
	
	_ThisList = List _Trg;
	sleep 0.5;
	
	deleteVehicle _Trg;
};

//	Units
if (_NumberOfUnits > 0) then
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
		if ((count _Units) < _NumberOfUnits) then
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
	
	_wp = _grp addWaypoint [(Position _Position),30,1];
	_grp setCurrentWaypoint [_grp,1];
	[_grp,1] setWaypointType "MOVE";
	[_grp,1] setWaypointSpeed "NORMAL";
	[_grp,1] setWaypointBehaviour "AWARE";
	[_grp,1] SetWaypointCombatMode "RED";
	_wp = _grp addWaypoint [(Position _Position),30,2];
	[_grp,2] setWaypointType "SAD";
	[_grp,2] setWaypointSpeed "AUTO";
	[_grp,2] setWaypointBehaviour "COMBAT";
	[_grp,2] SetWaypointCombatMode "RED";
};