//	Create a trigger that covers the area you want to be a service station.
//	Select TYPE: Switch
//  Select ACTIVATION: Anybody
//	Select: Repeatedly
//  Select Timeout and set it to: 4 / 4 / 4	 (THIS IS IMPORTANT TO AVOID HAVING ACTIONS MULTIPLIED!!!)
//	Add this to Condition:  { if ((_x isKindOf "AIR" || _x isKindOf "LANDVEHICLE") and ((getPosATL _x) select 2) < 1) then {true};} count thisList == 1;
// 	Add this to Activation: null = [(list thisTrigger), ThisTrigger] execVM "Scripts\NEKY_ServiceStation.sqf";
//
//	If you don't want it to treat Helicopters or Planes, remove the half containing "AIR". if you don't want it to treat cars, tanks or LAV's then remove the half containing "Landvehicle"
// 	Note: Avoid having vehicles close to the Service Station, it will only work if ONE vehicle is in the trigger area.
//  Note: One person can only operate ONE service station at the same time.
//
//	Made by NeKo-ArroW with help from GuzzenVonLidl
//  Thanks to MacGregor for helping me out testing this on dedicated server

Private ["_Array","_Lights","_FullService","_RearmSleep","_RearmSleepPlane","_RepairingSpeedPlane","_MountWheelSpeed","_RemoveWheelSpeed","_Trigger","_Damage","_Part","_Index","_Veh","_InspectionSpeed","_RepairingSpeed"];

//	============
//	  VARIABLES
//	============

_InspectionSpeed = 1;						// Time in seconds (multiplied by 3) it takes to inspect each part of the vehicle.

_RepairingSpeed = 0.1;						// Percent of maximum HP (per part) repaired (ground vehicles and heli) per second (over 3 seconds).									 0 = 0%, 1 = 100%.
_RepairingTrackSpeed = 0.02;				// Percent of maximum HP of left and right Track (per track)(Tanks) repaired per second (over 3 seconds)								 0 = 0%, 1 = 100%.
_RepairingSpeedPlane = 0.05;				// Percent of maximum HP (whole plane since it only has 1 part) repaired (planes) per second (over 3 seconds).							 0 = 0%, 1 = 100%.
_Refueling = 0.03;							// Percent of maximum fuel refueled per second (over 3 seconds).																		 0 = 0%, 1 = 100%.

_RemoveWheelSpeed = 5;						// Time in seconds it takes to remove a damaged wheel.
_MountWheelSpeed = 5;						// Time in seconds it takes to mount a new wheel.

_RearmSleep = 5;							// Time in seconds (multiplied by 5) it takes to rearm vehicles (save planes).
_RearmSleepPlane = 10;						// Time in seconds (multiplied by 5) it takes to rearm a plane.

_Lights = True;								// Blinking lights on/off. True = on.

//	===============
//	  Do not touch
//    lines below
//	===============

// Identifying Vehicle
_Array = [];
{
	if (_x isKindOf "AIR" || _x isKindOf "LandVehicle") then {
		_Array pushBack _x;
	};
} forEach (_this select 0);

_Veh = _Array select 0;
_Trigger = [_this, 1, objNull, [ObjNull]] call BIS_fnc_Param;

_FullService = False;
NEKY_BUSY = False;
NEKY_LightsOn = False;

if (triggerActivated _Trigger) then {
	NEKY_Action  =	_veh addAction ["<t color='#FF8000'>NeKy's Service Station</t>",{},[], 10, false, false];
	NEKY_Action2 =  _veh addaction ["<t color='#F7FE2E'>Repair</t>",{[(_this select 3 select 0),(_this select 3 select 1),(_this select 3 select 2),(_This select 3 select 3),(_This select 3 select 4),(_This select 3 select 5),(_this select 3 select 6),(_This select 3 select 7),(_This select 3 select 8),(_This select 3 select 9),(_This select 3 select 10),(_This select 3 select 11),(_This select 3 select 12)] call GOL_Fnc_ServiceStation_Repair}, [_Veh,_InspectionSpeed,_RepairingSpeed,_Trigger,_RemoveWheelSpeed,_MountWheelSpeed,_RepairingSpeedPlane,_FullService,_Refueling,_RearmSleep,_RearmSleepPlane,_Lights,_RepairingTrackSpeed], 10, false, true];
	NEKY_Action3 =	_veh addaction ["<t color='#F7FE2E'>Refuel</t>",{[(_this select 3 select 0),(_this select 3 select 1),(_This select 3 select 2),(_This select 3 select 3),(_This select 3 select 4),(_This select 3 select 5),(_This select 3 select 6)] call GOL_Fnc_ServiceStation_Refuel}, [_Veh,_Refueling,_FullService,_Trigger,_RearmSleep,_RearmSleepPlane,_Lights], 10, false, true];
	NEKY_Action4 =  _veh addaction ["<t color='#F7FE2E'>Rearm</t>",{[(_This select 3 select 0),(_this select 3 select 1),(_This select 3 select 2),(_This select 3 select 3),(_This select 3 select 4),(_This select 3 select 5)] call GOL_Fnc_ServiceStation_Rearm}, [_Veh,_RearmSleep,_RearmSleepPlane,_Trigger,_FullService,_Lights], 10, false, true];
	NEKY_Action5 =  _veh addaction ["<t color='#F7FE2E'>Full Service</t>",{[(_this select 3 select 0),(_this select 3 select 1),(_this select 3 select 2),(_This select 3 select 3),(_This select 3 select 4),(_This select 3 select 5),(_this select 3 select 6),(_this select 3 select 7),(_This select 3 select 8),(_This select 3 select 9),(_This select 3 select 10),(_This select 3 select 11)] call GOL_Fnc_ServiceStation_FullService}, [_Veh,_InspectionSpeed,_RepairingSpeed,_Trigger,_RemoveWheelSpeed,_MountWheelSpeed,_RepairingSpeedPlane,_Refueling,_RearmSleep,_RearmSleepPlane,_Lights,_RepairingTrackSpeed], 10, false, true];
	NEKY_Action6 =	_veh addAction ["<t color='#FF8000'>NeKy's Service Station</t>",{},[], 10, false, false];

	NEKY_Actions = [NEKY_Action,NEKY_Action2,NEKY_Action3,NEKY_Action4,NEKY_Action5,NEKY_Action6];

	PublicVariable "NEKY_Action"; Publicvariable "NEKY_Action2"; PublicVariable "NEKY_Action3"; PublicVariable "NEKY_Action4"; PublicVariable "NEKY_Action5"; PublicVariable "NEKY_Action6";
};

// Noticing vehicle leaving service station
While {TriggerActivated _Trigger} do {
	sleep 3;
	if (!TriggerActivated _Trigger) then {
		{_veh removeAction _x} forEach NEKY_Actions;
	}
};
