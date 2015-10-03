
	Private ["_FullService","_Trigger","_Armed","_Veh","_RearmSleep","_RearmSleepPlane"];

	_Veh = _This select 0;
	_RearmSleep = _This select 1;
	_RearmSleepPlane = _This select 2;
	_Trigger = _This select 3;
	_FullService = _This select 4;
	_Lights = _This select 5;

	if (NEKY_BUSY) exitWith {titleText ["Service Station is busy, please wait for current service to be finished.","PLAIN"]};
	NEKY_BUSY = True;
	if (!NEKY_LightsOn) then {[_Lights,_Trigger] spawn GOL_Fnc_ServiceStation_Lights};

	if (((count magazinesDetail _veh) > 0) || ((typeOf _veh == "I_Heli_light_03_F") || (typeOf _Veh == "I_Heli_light_03_unarmed_F"))) then {
		_Armed = True
	} else {
		_Veh setVehicleAmmo 0.51;
		if ((Count MagazinesDetail _Veh) > 0) then {
			_Armed = True
		} else {
		_Armed = False
		};
	};

	if (_Armed) then {
		if (_Veh isKindOf "PLANE") then {_RearmSleep = _RearmSleepPlane};

		hint "Rearming";
		sleep _RearmSleep;
		hint "Rearming.";
		sleep _RearmSleep;
		hint "Rearming..";
		sleep _RearmSleep;
		hint "Rearming...";
		sleep _RearmSleep;
		hint "Rearming....";
		sleep _RearmSleep;
		hint "Rearming.....";
		sleep 1;
		if (!(_Veh in list _Trigger)) exitWith {hint "You've left the service station, service ended."; NEKY_BUSY = False;};
		_veh setvehicleammodef 1;
		sleep 1;
		hint "Rearming Complete!";

	} else {
		Hint "Vehicle is unarmed, nothing to rearm.";
	};
	Sleep 2;
	if (_FullService) then {Hint "Service complete!"};
	_Driver = driver _Veh;
	if (_Driver in _Veh) then {_Veh engineOn True};
	NEKY_BUSY = False;
