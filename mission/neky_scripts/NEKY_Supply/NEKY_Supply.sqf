//	[side, "heli type classname" (default mid size heli of said side), "Drop/Unload", ["spawn","target","despawn"], ["Ingress waypoints",], ["Egress waypoints"], "box content script path" or code , Boolean (Vulnerable, true or false)] execVM "Scripts\NEKY_Supply\NEKY_Supply.sqf";
//	
/////////////////
//	Parameters:
/////////////////
//	
//	1. Side of heli crew (West,BLUFOR,East,OPFOR,Independent works fine)
//	2. Class name of the type of heli you want to spawn. If you leave it empty ("") then it'll spawn a preset heli (Blackhawk, Taru, Hellcat)
//	3. Drop or Unload. Drop means that it will drop the ammo box with a parachute while unload means it'll land and unload it and fly off again.
//	4. ["spawn","target","despawn"] markers for where it spawns, target area for resupply, last waypoint which will despawn heli + crew.
//	5. ["wp1","wp2"] Ingress Waypoints. The first waypoints the heli will follow prior to the target area. (Can be empty [""] or as many waypoints as you want)
//	6. ["wp3","wp4"] Egress Waypoints. The waypoints the heli will follow after delivering the ammo box. (can be empty [""] or as many waypoints as you want)	
//	7. Box Content, either enter a script path "Scripts\NEKY_Supply\NEKY_SupplyBox.sqf" and fill that file with items or enter it all manually using {}. Use _Box instead of "this" in the code.
//	8. Vulnerable. True = Heli + crew can take damage. False = Heli + crew cannot take damage.	
//	
///////////
//	Usage:
///////////
//
//	Create a trigger and enter a condition. Then enter this in to the activation line and fill out the parameters to your choosing:
//	null = [blufor,"","drop",["spawn","target","despawn"],["wp1"],["wp2"],"Scripts\NEKY_SupplyBox.sqf",false] execVM "Scripts\NEKY_Supply\NEKY_SupplyInit.sqf";
//	 
//	To set it up by using Radio calls (clicking 0 and 0 again while in-game) see NEKY_SupplyInit.sqf for more info.
//	
//	Made By NeKo-ArroW with help from GuzzenVonLidl

if !(isServer) exitWith {False};
	
Private ["_Correction","_Target","_Waypoints","_Signal","_SignalClass","_Chute","_ChuteClass","_Position","_Box","_BoxClass","_HeliPad","_Index","_Crew","_Side","_HeliClass","_This","_Type","_Waypoints1","_WaypointsIngress","_STD","_STDs","_Waypoints2","_WaypointsEgress","_Box","_Vulnerable","_x","_Pilot","_Text","_Parameters","_Temp"];

_Side = [_This, 0, BLUFOR, [SideUnknown]] call BIS_fnc_param;
_HeliClass = toLower ([_This, 1, "", [""]] call BIS_fnc_Param);
_Type = toLower ([_This, 2, "drop", [""]] call BIS_fnc_Param);
_STDs = [_This, 3, [""], [[""],[]]] call BIS_fnc_Param;
_Waypoints1 = [_This, 4, [""], [[""]]] call BIS_fnc_Param;
_Waypoints2 = [_This, 5, [""], [[""]]] call BIS_fnc_Param;
_BoxCode = [_This, 6,  "", ["", {}]] call BIS_fnc_Param;
_Vulnerable = [_This, 7, false, [false]] call BIS_fnc_Param;

// Debugger \\
NEKY_SupplyDebug = 
{
	private ["_this","_Parameters","_Text"];
	if (false) exitWith {false};   							// false = shows debugging text. true = doesn't show debugging text. (EDITOR ONLY)
	
	_Text = _this select 0;
	_Parameters = _this select 1;
	SystemChat format [_Text,_Parameters];
};

["Script Running %1","NEKY_Supply.sqf"] spawn NEKY_SupplyDebug;

//	Turning markers in to XYZ
_STD = []; {if (typeName _x == "STRING") then {_Temp = GetMarkerPos _x; _STD PushBack _Temp} else {_STD PushBack _x}; } forEach _STDs;
_WaypointsIngress = []; {if ((typeName _x == "STRING") && !(_x == "")) then {_Temp = GetMarkerPos _x; _WaypointsIngress pushBack _Temp} else {if !(_x == "") then {_WaypointsIngress pushBack _x}; }; } forEach _Waypoints1;
_WaypointsEgress = []; {if ((typeName _x == "STRING") && !(_x == "")) then {_Temp = GetMarkerPos _x; _WaypointsEgress PushBack _Temp} else {if !(_x == "") then {_WaypointsEgress pushBack _x}; }; } forEach _Waypoints2;
sleep 1;
["STD Array: %1",_STD] call NEKY_SupplyDebug;
["WaypointIngress Array: %1",_WaypointsIngress] call NEKY_SupplyDebug;
["WaypointEgress Array: %1",_WaypointsEgress] call NEKY_SupplyDebug;

// Compressing all Waypoints to one Array and defining target index
_Waypoints = [(_STD select 0)];
_Waypoints Append _WaypointsIngress;
_Waypoints set [(count _Waypoints), (_STD select 1)];
_Target = ((Count _Waypoints) -1); 
_Waypoints Append _WaypointsEgress;
_Waypoints set [(count _Waypoints), (_STD select 2)];
_Waypoints set [(Count _Waypoints), [0,0,100]];
sleep 1;

["Waypoints: %1", _Waypoints] call NEKY_SupplyDebug;

// Define classes based on side
switch (_Side) do
{
	Private ["_BoxClass","_HeliClass","_ChuteClass"];
	
	case BLUFOR:
	{
		if (_HeliClass == "") then {_HeliClass = "B_Heli_Transport_01_F";};
		_BoxClass = "B_CargoNet_01_ammo_F";
		_ChuteClass = "B_Parachute_02_F";
	};
	
	case OPFOR:
	{
		if (_HeliClass == "") then {_HeliClass = "O_Heli_Transport_04_F";};
		_BoxClass = "O_CargoNet_01_ammo_F";
		_ChuteClass = "O_Parachute_02_F";
	};
	
	case INDEPENDENT:
	{
		if (_HeliClass == "") then {_HeliClass = "I_Heli_light_03_unarmed_F";};
		_BoxClass = "I_CargoNet_01_ammo_F";
		_ChuteClass = "I_Parachute_02_F";
	};
};

// Whether it'll have a smoke grenade or a chemlight for signal
if ((dayTime > 04.30) and (dayTime < 19.30)) then {_SignalClass = "SmokeShellGreen"} else {_SignalClass = "Chemlight_green"};

// Spawning Heli & Crew
_Heli = CreateVehicle [_HeliClass, (_STD select 0), [], 0, "FLY"];
_Heli setDir ([(_Waypoints select 0), (_Waypoints select 1)] call BIS_fnc_DirTo);
_Heli AllowDamage _Vulnerable;

CreateVehicleCrew _Heli;
{
	_x setSkill 0.4;
	_x SetBehaviour "SAFE";
	_x SetCombatMode "GREEN";
	_x allowDamage _Vulnerable;
	removeBackPack _x;
} forEach crew _Heli;

_Crew = group (driver _Heli);
_Pilot = (Driver _Heli);
_Pilot SetBehaviour "CARELESS";
_Pilot setCombatMode "BLUE";
sleep 0.5;

// Waypoints creating and assignments
_Index = 1;
For "_i" from 1 to ((Count _Waypoints) -1) do
{
	_Crew addWaypoint [(_Waypoints select _Index),0,_Index];
	[_Crew,_Index] SetWaypointSpeed "NORMAL";
	[_Crew,_Index] SetWaypointType "MOVE";
	[_Crew,_Index] setWaypointCompletionRadius 0;
	[_Crew,_Index] SetWaypointCombatMode "GREEN";
	_Index = _Index +1;
	sleep 0.2;
};

Switch (_Type) do
{
	case "drop":
	{
		_Heli flyInHeight 200;
		_DirCorrection = [(_Waypoints select (_Target -1)), (_Waypoints select (_Target))] call BIS_fnc_dirTo;
		_Correction = [(_Waypoints select (_Target)), -80, _DirCorrection] call BIS_fnc_relPos;
		[_crew, _Target] setWPPos _Correction;
		sleep 0.5;
		[_Crew,_Heli,_BoxClass,_BoxCode,_Target,_ChuteClass,_SignalClass] Spawn
		{
			_Crew = _This select 0;
			_Heli = _This select 1;
			_BoxClass = _This select 2;
			_BoxCode = _This select 3;
			_Target = _This select 4;
			_ChuteClass = _This select 5;
			_SignalClass = _This select 6;
			WaitUntil {sleep 0.5; ( (!(Alive _Heli) or !(CanMove _Heli)) or ({!Alive _x} forEach units _Crew) or ((CurrentWaypoint _Crew) > _Target))};
			if ((Alive _Heli) && (Alive (driver _Heli))) then 
			{
				_Box = CreateVehicle [_BoxClass, [0,0,1000], [], 0, "CAN_COLLIDE"];
				_Box disableCollisionWith _Heli;
				[_Box,_BoxCode] spawn 
				{
					_Box = _This select 0;
					_BoxCode = _This select 1;
					sleep 2;
					if (TypeName _BoxCode == "STRING") Then {if (_BoxCode != "") then {[_Box] execVM _BoxCode};} else {[_Box] call _BoxCode};
				};
				_Box HideObjectGlobal True;
				_Box SetDir (getDir _Heli);	
				_PitchBank = _Box call BIS_fnc_getPitchBank;
				[_Box,30,(_PitchBank select 1)] call BIS_fnc_SetPitchBank;
				_Chute = CreateVehicle [_ChuteClass, [0,0,1100], [], 0, "CAN_COLLIDE"];
				_Chute HideObjectGlobal True;
				_Temp = [(_Heli), 30, (GetDir _Heli)] call BIS_fnc_relPos;
				_Chute SetPosATL _Temp;
				_Box SetPosATL _Temp;
				_Chute SetDir (getDir _Heli);
				[_Chute,40,(_PitchBank select 1)] call BIS_fnc_SetPitchBank;
				_Box attachTo [_Chute,[0,0,0]];
				sleep 0.7;
				_Chute setVelocity [((Velocity _Heli) select 0), ((Velocity _Heli) select 1),-15];
				_Box setVelocity [((Velocity _Heli) select 0), ((Velocity _Heli) select 1),-15];
				_Box HideObjectGlobal False;
				_Chute HideObjectGlobal False;
				[_SignalClass, _Box] spawn 
				{
					_SignalClass = _This select 0;
					_Box = _This select 1;
					sleep 15;
					_Signal = createVehicle [_SignalClass, [0,0,100], [], 0, "CAN_COLLIDE"];
					_Signal AttachTo [_Box,[0,0,0]];
				};
				sleep 5;
				_Box SetMass [500,10];
				While {(((GetPosATL _Box) select 2) > 1)} do
				{
					_Box setVelocity [((Velocity _Box) select 0), ((Velocity _Box) select 1),-15];
					sleep 0.2;
				};
				Detach _Box;
			};
		};
	};
	
	case "unload":
	{
		_HeliPad = createVehicle ["Land_HelipadEmpty_F", (_STD select 1), [], 0, "NONE"];		
		[_Crew,_Heli,_HeliPad,_BoxClass,_BoxCode,_SignalClass,_Target] spawn
		{
			_Crew = _This select 0;
			_Heli = _This select 1;
			_HeliPad = _This select 2;
			_BoxClass = _This select 3;
			_BoxCode = _This select 4;
			_SignalClass = _This select 5;
			_Target = _This select 6;
			_Heli forceSpeed 100;
			WaitUntil {sleep 2; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or ((_Heli distance _HeliPad) < 800))};
			if ((Alive _Heli) && (Alive (driver _Heli))) then 
			{
				_Heli land 'land';
				_Crew lockWP True;
				doStop _Heli;
				createVehicle [_SignalClass, (getPos _HeliPad), [], 5, "CAN_COLLIDE"];
				WaitUntil {sleep 2; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or (((GetPosATL _Heli) Select 2) < 5))};
				sleep 2;
				_Heli EngineOn True;
				sleep 10;
				_Position = [_Heli, 5, ((GetDir _Heli) + 90)] call BIS_fnc_relPos;
				if (Alive _Heli) then
				{
					_Box = CreateVehicle [_BoxClass, _Position, [], 0, "CAN_COLLIDE"];
					if (TypeName _BoxCode == "STRING") Then {if (_BoxCode != "") then {[_Box] execVM _BoxCode};} else {[_Box] call _BoxCode};
				};
				_Heli DoMove (getpos _Heli);
				_Crew lockWP false;
				_Heli forceSpeed -1;
				deleteVehicle _Helipad;
				} else {
				deleteVehicle _Helipad;
				false;
			};
		};
	};
};

["Waypoint Type: %1", _Type] call NEKY_SupplyDebug;

// Despawning
[_Crew,_Heli,_STDs] spawn
{
	_Crew = (_This select 0);
	_Heli = (_this select 1);
	_STDs = (_This select 2);
	WaitUntil {sleep 1; (!(Alive _Heli) or ({Alive _x} count (units _Crew) == 0) or (_Heli distance (getmarkerPos (_STDs select 2)) <= 100))};
	if (!(Alive _Heli) or ({Alive _x} count (units _Crew) == 0)) then {Sleep 900} else {sleep 5};
	{DeleteVehicle _x} forEach units _Crew;
	DeleteVehicle _Heli;
};