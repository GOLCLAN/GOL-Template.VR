
	Private ["_Lights","_Trigger"];

	_Lights = _This select 0;
	_Trigger = _This select 1;

	NEKY_LightsOn = True;

	While {NEKY_BUSY && _Lights} do {
		_Light1 = [_Trigger, 10, (TriggerArea _Trigger select 2) + 45] call BIS_fnc_relPos;
		_Light2 = [_Trigger, 10, (TriggerArea _Trigger select 2) + 135] call BIS_fnc_relPos;
		_Light3 = [_Trigger, 10, (TriggerArea _Trigger select 2) + 225] call BIS_fnc_relPos;
		_Light4 = [_Trigger, 10, (TriggerArea _Trigger select 2) + 315] call BIS_fnc_relPos;
		_LightArray = [_Light1,_Light2,_Light3,_Light4];
		_Index = 0;
		_Spheres = [];

		for "_i" from 1 to 4 do {
			_Light = CreateVehicle ["Sign_Sphere100cm_F", (_LightArray select _Index), [], 0, "CAN_COLLIDE"];
			_Spheres pushBack _Light;
			_Index = _Index +1;
		};
		sleep 2;
		{
			DeleteVehicle _x;
		} forEach _Spheres;
		sleep 2;
	};
	NEKY_LightsOn = False;
