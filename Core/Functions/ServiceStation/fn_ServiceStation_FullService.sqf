
	Private ["_RearmSleepPlane","_RearmSleep","_Refueling","_FullService","_Veh","_InspectionSpeed","_RepairingSpeed","_Trigger","_RemoveWheelSpeed","_MountWheelSpeed","_RepairingSpeedPlane"];

	_Veh = _This select 0;
	_InspectionSpeed = _This select 1;
	_RepairingSpeed = _This select 2;
	_Trigger = _This select 3;
	_RemoveWheelSpeed = _This select 4;
	_MountWheelSpeed = _This select 5;
	_RepairingSpeedPlane = _This select 6;
	_Refueling = _This select 7;
	_RearmSleep = _This select 8;
	_RearmSleepPlane = _This select 9;
	_Lights = _This select 10;
	_RepairingTrackSPeed = _This select 11;

	if (NEKY_BUSY) exitWith {titleText ["Service Station is busy, please wait for current service to be finished.","PLAIN"]};

	_FullService = True;
	NEKY_BUSY = True;
	if (!NEKY_LightsOn) then {
		[_Lights,_Trigger] spawn GOL_Fnc_ServiceStation_Lights
	};

	Hint "Full service selected";
	sleep 2;
	NEKY_Busy = False;
	[_Veh,_InspectionSpeed,_RepairingSpeed,_Trigger,_RemoveWheelSpeed,_MountWheelSpeed,_RepairingSpeedPlane,_FullService,_Refueling,_RearmSleep,_RearmSleepPlane,_Lights,_RepairingTrackSpeed] call GOL_Fnc_ServiceStation_Repair;
