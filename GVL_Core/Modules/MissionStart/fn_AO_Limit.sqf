
	private ["_pos", "_allowedOutside", "_sleep"];
	_pos = getPosATL (vehicle player);
	_allowedOutside = false;
	_active = true;
	_sleep = 5;

	while {_active} do {

		if (!(GVL_Gamelogic getVariable ["GVL_SafeStart_Active",false])) then {
			[AO_Markers] call GVL_Fnc_AO_Remove_Marker;
		};

		if ((count AO_Markers) >= 1) then {
			private ["_vehicle"];
			_vehicle = vehicle player;
			if (!(_vehicle isKindOf "Air")) then {
				private ["_outSide"];
				_outSide = true;

				{ // forEach
					if ([_vehicle, _x] call CBA_fnc_inArea) exitWith {
						_outSide = false;
					};
				} forEach AO_Markers;

				if (_outSide) then {
					if (!_allowedOutside) then {
						hint "Please stay in the AO!";
						_vehicle setPosATL _pos;
						sleep 0.1;
					};
				} else {	// Inside AOs

					if (_allowedOutside) then {
						_allowedOutside = false
					};
					_pos = getPosATL _vehicle;
					sleep _sleep;
				};

			} else {	// In air vehicle
				if (!_allowedOutside) then {
					_allowedOutside = true
				};
			};

			if (_allowedOutside) then {
				sleep 10;
			};
		} else {
			sleep 5;
			_active = false;
		};
	};
