//	Null = [This, "BombType", ["BombVisual"], ChanceOfPlanting(number), [Driver,Gunner,Ignition], ChanceOfRigged(number), [Remote(bool) or unitname], Controller (Side), RemoteRange(number), RemoteControllers(number)] execVM "Scripts\NEKY_CarBomb\NEKY_CarBomb.sqf";
/////////////////////////////////////////////////
//
// 	NOTE: Supported vehicles are Offroad, Offroad (FIA), Offroad (Armed) (FIA), Hatchback, Hatchback (Sport), SUV, Truck, Truck (FIA), Truck (Boxer)
//	
//	1. Object name, the name of the object.
//		a. Can be the actual name of the Object. Generally used when activating Bombs later in to the mission.
// 		b. This, when entered in the init line of an object, activates the Bomb instantly.
//	2. "Bomb Type", the size of the explosion when triggered.
//		a. "Small" will create a small explosion when triggered.
//		b. "Medium" will create a medium explosion when triggered.
//		c. "Large" will create a large explosion when triggered.
//		d. "Random" will randomly select any of the values in NEKY_Settings, _RandomBomb.
//
//	NOTE: If you don't plan on overriding any options from NEKY_Settings.sqf, you do not need to enter any of the following parameters!
//
//	3. OPTIONAL: ["Bomb Visual"], what the bomb should look like. This will override the values entered in NEKY_Settings.sqf, _Visual.
//		a. You can enter several types, it will randomly select one.
//		b. To use default enter: nil.
//	4. OPTIONAL: ChanceOfPlanting, Chance of actually planting a bomb on the vehicle. This will override the value entered in NEKY_Settings.sqf, _ChanceOfPlanting.
//		a. 0 = 0% chance, 1 = 100% chance.
//		b. To use default enter: nil.
//	5. OPTIONAL: [Driver,Gunner,Ignition], What positions should be rigged to set off the bomb if a player triggers it. This will override the value entered in NEKY_Settings.sqf, _RigPositions.
//		a. Driver, True = Rigs the vehicle to explode when entering the driver seat. False = Doesn't explode from entering the driver seat.
//		b. Gunner, True = Rigs the vehicle to explode when entering the gunner seat. False = Doesn't explode from entering the gunner seat.
//		c. Ignition, True = Rigs the vehicle to explode when turning the engine on. False = Doesn't explode from turning the engine on.
//		d. This presumes ChanceOfRigged is positive.
//		e. To use default enter: nil.
//	6. OPTIONAL: ChanceOfRigged, the chance that the vehicle will be rigged to explode when entered. This will override the value entered in NEKY_Settings.sqf, _ChanceOfRigged.
//		a. 0 = 0% chance, 1 = 100% chance.
//		b. To use default enter: nil.
//	7. OPTIONAL: [Remote], Whether the bomb can be remotely triggered by an AI or not. This will override the value entered in NEKY_Settings.sqf, _Remote.
//		a. [True] = Random AI will be selected to stay in range of the vehicle to remotely detonate the explosive if a player comes near the vehicle. [False] = No remote detonation of the bomb.
//		b. Be aware that units in this variable are broken out from their groups and will roam around in a 1man group. Also, only one AI will be selected per vehicle.
//		c. [man1,man2] = man1 and man2 will be selected as remote controllers. These units can be placed in the editor and you can set them to do whatever you want them to, specific patrol, hold position etc. Can be any amount of units.
//		d. Using the command as 7c describes will make it possible for one AI to control more than one vehicle at a time.
//		f. To use default enter: nil.
//	8. OPTIONAL: Controller Side, what side the randomly selected Remote Controller are on. This will override the value entered in NEKY_Settings.sqf, _ControllerSide.
//		a. Can be West/BLUFOR, East/OPFOR, Independent, CIVILIAN.
//		b. If using a specified unit (see 7c), this has no effect.
//		c. To use default enter: nil.
//	9. OPTIONAL: RemoteRange, the range a remote controller need to be within to be able to remotely detonate the bomb. This will override the value entered in NEKY_Settings.sqf, _RemoteRange.
//		a. Range in meters.
//		b. To use default enter: nil.
//	10. OPTIONAL: RemoteControllers, How many AI will be able to remotely set off the bomb. This will override the default value entered in NEKY_Settings.sqf, _RemoteControllers.
//		a. Number of units.
//		b. if using a specified unit (see 7c), this has no effect.
//		c. To use default enter: nil.
//
////////////
//	How To
////////////
//	
//	*CREATE AT MISSION START*
//	1. Place a vehicle in the editor.
//	2. Edit the code to your preferences.
//	3. Enter the code in the init line of the vehicle. Beginning with: Null =
//	4. Done!
//
//	*CREATE LATER IN TO THE MISSION* (Saves a little performance)
//	1. Place a vehicle in the editor and name it.
//	2. Create a trigger with a condition to your fitting.
//	3. Edit the code to your preferences (remember to change  This  to your vehicle's name)
//	4. Enter the code in the On Act, Beginning with: Null = 
//	5. Done!
//
/////////////
//	Examples
/////////////
//	
//	Null = [This, "small"] execVM "Scripts\NEKY_CarBomb\NEKY_CarBomb.sqf";
//	Null = [This, "large", nil, nil, [false,false,true], 1, [false]] execVM "Scripts\NEKY_CarBomb\NEKY_CarBomb.sqf";
//	Null = [This, "random", nil, 0.5, nil, 1, [man1,man2,man3]] execVM "Scripts\NEKY_CarBomb\NEKY_CarBomb.sqf";
//	Null = [This, "random", nil, 0.5, nil, 1, [true], east, nil, 2] execVM "Scripts\NEKY_CarBomb\NEKY_CarBomb.sqf";
//	
////////////////////////
//	Made by NeKo-ArroW
////////////////////////

Private ["_Case","_Pos","_TypeVehicle","_PreSelectedControllers","_RigPositions","_OffroadPos","_OffroadArmedPos","_HatchbackPos","_HatchbackSportPos","_SUVPos","_TruckPos","_TruckFIAPos","_RandomBomb","_ChanceOfPlanting","_WPPos","_BumpSensitivity","_Index","_Grp","_TempArray","_Controller","_ControllerSide","_FrequencyF","_FrequencyC","_ChanceOfRigged","_PosMin","_PosMax","_Vehicle","_BombType","_Visual","_Remote","_RemoteController","_RemoteRange","_Small","_Medium","_Large"];

if !(isServer) exitWith {False};
#include "NEKY_Settings.sqf"
_ChanceOfPlanting = [_This, 3, _ChanceOfPlanting, [0]] call BIS_FNC_Param;

if !((Random 1) <= _ChanceOfPlanting) exitWith {SystemChat "Not planting this one!"; False};
if (isNil "NEKY_CarBombControllers") then {NEKY_CarBombControllers = []};
if (isNil "NEKY_CarBombDetonated") then {NEKY_CarBombDetonated = []};

_Vehicle = [_This, 0, ObjNull, [ObjNull]] call BIS_FNC_Param;
_BombType = toLower ([_This, 1, "medium", [""]] call BIS_FNC_Param);
_Visual = [_This, 2, _Visual, [[""]]] call BIS_FNC_Param;
_RigPositions = [_This, 4, _RigPositions, [[]]] call BIS_FNC_Param;
_ChanceOfRigged = [_This, 5, _ChanceOfRigged, [0]] call BIS_FNC_Param;
_Remote = [_This, 6, _Remote, [[]]] call BIS_FNC_Param;
_ControllerSide = [_This, 7, _ControllerSide, [SideUnknown]] call BIS_FNC_Param;
_RemoteRange = [_This, 8, _RemoteRange, [0]] call BIS_FNC_Param;
_RemoteControllers = [_This, 9, _RemoteControllers, [0]] call BIS_FNC_Param;

// Get snap point
_TypeVehicle = toLower (TypeOf _Vehicle);
#include "NEKY_Placements.sqf"
Switch (_TypeVehicle) do
{
	Private ["_Pos"];
	case "b_g_offroad_01_f";
	case "c_offroad_01_f": {_Pos = (_OffroadPos call BIS_FNC_SelectRandom)};
	case "b_g_offroad_01_armed_f": {_Pos = (_OffroadArmedPos call BIS_FNC_SelectRandom)};
	case "c_hatchback_01_f": {_Pos = (_HatchbackPos call BIS_FNC_SelectRandom)};
	case "c_hatchback_01_sport_f": {_Pos = (_HatchbackSportPos call BIS_FNC_SelectRandom)};
	case "c_suv_01_f": {_Pos = (_SUVPos call BIS_FNC_SelectRandom)};
	case "c_van_01_transport_f": {_Pos = (_TruckPos call BIS_FNC_SelectRandom)};
	case "c_van_01_box_f";
	case "b_g_van_01_transport_f": {_Pos = (_TruckFIAPos call BIS_FNC_SelectRandom)};
	default {SystemChat Format ["Vehicle %1 not supported for NEKY_CarBomb!",(TypeOf _Vehicle)]};
};
if (IsNil "_Pos") exitWith {False};

// Create and attach bomb
_Bomb = CreateVehicle [(_Visual call BIS_FNC_SelectRandom), [0,0,1000], [], 0, "NONE"];
_Bomb attachTo [_Vehicle,(_Pos select 0)];
[[[_Bomb,_Pos],{(_This select 0) setDir (_This select 1 select 1); (_This select 0) setVectorUp (_This select 1 select 2)}], "BIS_FNC_SPAWN", true] call BIS_FNC_MP;

// Random Bomb
If (_BombType == "random") then {_BombType = (_RandomBomb call BIS_FNC_SelectRandom)};

// Define Bomb(explosion) Type
Switch (_BombType) do
{
	Private ["_BombType"];
	case "small": {_BombType = _Small};
	case "medium": {_BombType = _Medium};
	case "large": {_BombType = _Large};
	default {SystemChat "Wrong param for BombType"};
};

NEKY_CarBombDetonate =
{
	_Bomb = _This select 0;
	_BombType = _This select 1;
	
	if (_Bomb in NEKY_CarBombDetonated) exitWith {False};
	NEKY_CarBombDetonated pushBack _Bomb;
	_Pos = GetPosATL _Bomb;
	
	if (_BombType isKindOf "MineBase") then // If a mine
	{
		_Temp = CreateMine [_BombType, _Pos, [], 0];
		_Temp setDamage 1;
	} else {								// If a projectile
		_Temp = CreateVehicle [_BombType, [0,0,100000], [], 0, "CAN_COLLIDE"];
		_Temp setVelocity [0,0,-1000];
		sleep 0.1;
		_Temp setPosATL _Pos;
	};
	DeleteVehicle _Bomb;
};

// Explode if bumped
if (_BumpSensitivity > 0) then
{
	[_Bomb,_Vehicle,_BombType] Spawn
	{
		#include "NEKY_Settings.sqf"
		_Bomb = _This select 0;
		_Vehicle = _This select 1;
		_BombType = _This select 2;
		_Active = True;
		Sleep 5;
		
		While {Alive _Bomb && _Active} do
		{
			if ({(_Vehicle distance _x) < 300} Count AllPlayers > 0) then {sleep _FrequencyC} else {sleep _FrequencyF};
			if ((Speed _Vehicle > 1) or (Speed _Vehicle < -1)) then { if ((random 1) <= _BumpSensitivity) then {_Active = False; [_Bomb,_BombType] Spawn NEKY_CarBombDetonate} };
		};
		SystemChat "Exiting Check if vehicle is Bumped";
	};
};

// Explode if entered or turning ignition
if (({_x isEqualTo True} count _RigPositions > 0) && ((random 1) <= _ChanceofRigged)) then
{
	_Index = 0;
	if (_RigPositions select 0 && _RigPositions select 2) then {_RigPositions deleteAt 2};
	for "_i" from 1 to (count _RigPositions) do
	{
		if (_RigPositions select _Index) then
		{
			[_Bomb, _Vehicle, _BombType, _Index] Spawn
			{
				#include "NEKY_Settings.sqf"
				_Bomb = _This select 0;
				_Vehicle = _This select 1;
				_BombType = _This select 2;
				_Index = _This select 3;
				_RigPosition = [{!(Driver _Vehicle isEqualTo ObjNull)}, {!(Gunner _Vehicle isEqualTo ObjNull)}, {(isEngineOn _Vehicle)}] select _Index;
				
				_Active = True;
				Sleep 5;
				
				While {Alive _Bomb && _Active} do
				{
					if ({(_Vehicle distance _x) < 300} Count AllPlayers > 0) then {sleep _FrequencyC} else {sleep _FrequencyF};
					if (call _RigPosition) then {_Active = False; [_Bomb,_BombType] Spawn NEKY_CarBombDetonate;};
				};
				SystemChat "Exiting Check if vehicle is rigged";
			};
		};
		_Index = _Index +1;
		sleep 1;
	};
};

// If vehicle or bomb is destroyed
[_Bomb,_Vehicle,_BombType] spawn
{
	#include "NEKY_Settings.sqf"
	_Bomb = _This select 0;
	_Vehicle = _This select 1;
	_BombType = _This select 2;
	While {Alive _Vehicle && Alive _Bomb} do
	{
		if ({(_Vehicle distance _x) < 300} Count AllPlayers > 0) then {sleep (_FrequencyC * 3)} else {sleep (_FrequencyF * 2)};
		if (((Getdammage _Bomb) >= _BombHealth) or !(Alive _Vehicle)) then {[_Bomb,_BombType] Spawn NEKY_CarBombDetonate};
	};
	SystemChat "Exiting check if Vehicle and Bomb is alive.";
};

// Detonate charge if player is close to vehicle while controller is alive and within range
NEKY_CarBombRemoteScanner =
{
	#include "NEKY_Settings.sqf"
	_Controller = _This select 0;
	_Vehicle = _This select 1;
	_Bomb = _This select 2;
	_BombType = _This select 3;
	_RemoteRange = _This select 4;

	While {Alive _Bomb && Alive _Controller} do
	{
		if ( ((_Controller Distance _Vehicle) <= _RemoteRange) && (({((_Vehicle distance _x) < _ProximityM) && ((((getPosATL _x) select 2) > (((getPosATL _Vehicle) select 2) -1.5)) && (((getPosATL _x) select 2) < (((getPosATL _Vehicle) select 2) +1.5)))} Count AllPlayers > 0) or ({((_Vehicle distance _x) < _ProximityV) && (_x in Vehicles)} Count AllPlayers > 0)) ) then {[_Bomb,_BombType] Spawn NEKY_CarBombDetonate};
		if ({(_Vehicle distance _x) < 300} Count AllPlayers > 0) then {sleep (_FrequencyC)} else {sleep (_FrequencyF)};	
	};
	SystemChat "Exiting check if players are near vehicle.";
};

// Select a remote controller for the bomb
if (typeName (_Remote select 0) == "BOOL") then {_Case = 0} else {_Case = 1};
Switch (_Case) do
{
	case 0:	// If script shall select controllers on its own
	{
		if !(_Remote Select 0) exitWith {False};
		For "_i" from 1 to (_RemoteControllers) do
		{
			if (_ControllerSide == SideUnknown) exitWith {SystemChat "Did not select a side, no remote controller selected"};
			_Controller = False;
			sleep (random 20); // To avoid having one person controlling multiple vehicles
			While {(TypeName _Controller == "BOOL") and (Alive _Bomb)} do
			{
				_TempArray = [];
				_Units = NearestObjects [_Vehicle, ["CAManBase"], _RemoteRange];
				if (count _Units > 0) then
				{
					{if ((side _x == _ControllerSide) && (Alive _x) && !(isPlayer _x) && !(_x in NEKY_CarBombControllers)) then {_TempArray pushBack _x}} forEach _Units;
					if (Count _TempArray > 0) then {_Controller = (_TempArray call BIS_FNC_SelectRandom); NEKY_CarBombControllers pushBack _Controller};
				};
				Sleep 10;
			};
			if !(Alive _Bomb) exitWith {SystemChat "Bomb destroyed or defused, controller scanner ending"};
			
			_Grp = CreateGroup _ControllerSide;
			[_Controller] Join _Grp;
			_Grp SetBehaviour "SAFE";
			_Grp SetCombatMode "WHITE";
			[[[_Controller],{(_This select 0) EnableAI "MOVE"; (_This select 0) ForceSpeed -1}], "BIS_FNC_SPAWN", True] call BIS_FNC_MP;
			
			// Create Waypoints 
			_Index = 0;
			for "_i" from 1 to 6 do
			{
				_Index = _Index +1;
				_Temp = _Grp AddWaypoint [([_Vehicle, (10 + (random 40)), (random 360)] call BIS_FNC_RelPos), 0];
				_Temp setWaypointSpeed "Limited";
				
				if (_Index == 1) then {_WPPos = GetWPPos _Temp};
				if (_Index == 6) then {_Temp SetWPPos _WPPos; _Temp SetWaypointType "CYCLE"};
			};
			sleep 1;
			
			// Make sure the Controller stays within 75m of the vehicle
			[_Controller,_Vehicle,_Bomb,_RemoteRange] Spawn
			{
				_Controller = _This select 0;
				_Vehicle = _This select 1;
				_Bomb = _This select 2;
				_RemoteRange = _This select 3;
				_Grp = Group _Controller;
				
				While {Alive _Vehicle && Alive _Bomb && Alive _Controller} do
				{
					if (_Controller Distance _Vehicle > (_RemoteRange * 1.5)) then {_Grp SetCurrentWaypoint [_Grp,(Round (Random 5))]};
					Sleep 15;
				};
				SystemChat "Exiting keep AI in AO.";
			};
			[_Controller,_Vehicle,_Bomb,_BombType,_RemoteRange] Spawn NEKY_CarBombRemoteScanner;
		};
	};
	
	case 1:	// If units are selected by mission maker.
	{
		{
			if !(_x in NEKY_CarBombControllers) then {NEKY_CarBombControllers pushBack _x};
			[_x,_Vehicle,_Bomb,_BombType,_RemoteRange] Spawn NEKY_CarBombRemoteScanner;
		} forEach _Remote;
	};
};