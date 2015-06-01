
	Private ["_Trigger","_FullService","_Fuel","_Veh","_Refueling"];

	_Veh = _This select 0;
	_Refueling = _This select 1;
	_FullService = _This select 2;
	_Trigger = _This select 3;
	_RearmSleep = _This select 4;
	_RearmSleepPlane = _This select 5;
	_Lights = _This select 6;

	if (NEKY_BUSY) exitWith {titleText ["Service Station is busy, please wait for current service to be finished.","PLAIN"]};
	NEKY_BUSY = True;
	if (!NEKY_LightsOn) then {[_Lights,_Trigger] spawn GOL_Fnc_ServiceStation_Lights};
	_Fuel = fuel _veh;

	if (_fuel < 0.98) then {
		while {_fuel < 0.98} do {
			if (!(_Veh in list _Trigger)) exitWith {hint "You've left the service station, service ended."; NEKY_BUSY = False;};
			hint "Refueling.";
			_veh setfuel (_fuel + _Refueling);
			sleep 1;
			_fuel = fuel _veh;
			hint "Refueling..";
			_veh setfuel (_fuel + _Refueling);
			sleep 1;
			_fuel = fuel _veh;
			hint "Refueling...";
			_veh setfuel (_fuel + _Refueling);
			sleep 1;
			_fuel = fuel _veh;
			hint "Refueling Complete!";
		};
	} else { hint "Refueling not needed"; };
	sleep 2;
	NEKY_BUSY = False;
	if (_FullService) then {[_Veh,_RearmSleep,_RearmSleepPlane,_Trigger,_FullService,_Lights] call GOL_Fnc_ServiceStation_Rearm};
