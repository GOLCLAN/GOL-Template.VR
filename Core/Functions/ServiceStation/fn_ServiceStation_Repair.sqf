	Private ["_HotFix","_Refueling","_RearmSleep","_RearmSleepPlane","_FullService","_Driver","_RepairingSpeedPlane","_State","_Trigger","_RepairingSpeed","_PartsHP","_PartNames","_PartName","_InspectionSpeed","_Index","_FuelHP","_HullHP","_TurretHP","_GunHP","_VehicleHP","_MainRotorHP","_atrqHP","_InstrumentsHP","_Parts","_CarHullHP","_LeftTrackHP","_RightTrackHP"];

	_Veh = _This select 0;
	_InspectionSpeed = _This select 1;
	_RepairingSpeed = _This select 2;
	_Trigger = _This select 3;
	_RemoveWheelSpeed = _This select 4;
	_MountWheelSpeed = _This select 5;
	_RepairingSpeedPlane = _This select 6;
	_FullService = _This select 7;
	_Refueling = _This select 8;
	_RearmSleep = _This select 9;
	_RearmSleepPlane = _This select 10;
	_Lights = _This select 11;
	_RepairingTrackSpeed = _This select 12;

	if (NEKY_BUSY) exitWith {titleText ["Service Station is busy, please wait for current service to be finished.","PLAIN"]};
	NEKY_BUSY = True;
	if (!NEKY_LightsOn) then {[_Lights,_Trigger] spawn GOL_Fnc_ServiceStation_Lights};
	_Index = 0;

	_Veh engineOn False;

	// Vehicle Hit Points
	// General
	_FuelHP = _veh getHitPointDamage "HitFuel";
	_EngineHP = _Veh getHitPointDamage "hitEngine";
	_HullHP = _veh getHitPointDamage "HitHull";
	_TurretHP = _veh gethitpointdamage "HitTurret";
	_GunHP = _veh gethitpointdamage "HitGun";

	// Helicopter
	_MainRotorHP = _veh getHitPointDamage "HitHRotor";
	_atrqHP = _veh getHitPointDamage "HitVRotor";
	_InstrumentsHP = _veh getHitPointDamage "HitAvionics";

	// Vehicles with wheels
	_CarHullHP = _veh gethit "Karoserie";
	if (!isNil "_CarHullHP") then {_HotFix = "Karoserie"} else {_HotFix = "HitBody"};
	_CarHullHP = _Veh GetHitPointDamage "HitBody";

	// Tanks
	_LeftTrackHP = _veh gethitpointdamage "HitLTrack";
	_RightTrackHP = _veh gethitpointdamage "HitRTrack";

	_Parts = [];

	Switch (true) do {
			case (_Veh isKindOf "TANK"): {
					_Parts = ["HitEngine","HitHull","HitTurret","HitGun","HitLTrack","HitRTrack"];
					_PartNames = ["Engine","Hull","Turret","Gun","Left Tracks","Right Tracks"];
					_PartsHP = [_EngineHP,_HullHP,_TurretHP,_GunHP,_LeftTrackHP,_RightTrackHP];
			};

			case (_Veh isKindOf "CAR"): {
					_Parts = ["HitFuel","hitEngine",_HotFix];
					_PartNames = ["Fuel System","Engine","Hull"];
					_PartsHP = [_FuelHP,_EngineHP,_CarHullHP];
			};

			case (_Veh isKindOf "HELICOPTER"): {
					_Parts = ["HitEngine","HitHull","HitAvionics","HitVRotor","HitHRotor"];
					_PartNames = ["Engine","Hull","Instruments","ATRQ","MRotor"];
					_PartsHP = [_EngineHP,_HullHP,_InstrumentsHP,_atrqHP,_MainRotorHP];
			};

			case (_Veh isKindOf "PLANE"): {
					_Parts = ["HitHull"];
					_PartNames = ["Hull"];
					_PartsHP = [_HullHP];
					_RepairingSpeed = _RepairingSpeedPlane;
			};
	};

	// Repairing
	for "_i" from 1 to (count _Parts) do {
			if (!(_Veh in list _Trigger)) exitWith {hint "You've left the service station, service ended."; NEKY_BUSY = False;};
			_Part = (_Parts select _Index);
			_PartName = (_PartNames select _Index);
			_PartHP = (_PartsHP select _Index);

			hint format ["Inspecting %1.",_PartName];
			Sleep _InspectionSpeed;
			hint format ["Inspecting %1..",_PartName];
			Sleep _InspectionSpeed;
			hint format ["Inspecting %1...",_PartName];
			Sleep _InspectionSpeed;

			if (_PartHP >= 0.01) then {
					While {_PartHP > 0.01 && (_Veh in list _Trigger)} do {
							if (_Veh isKindOf "TANK" and _Index >= 4) then {_RepairingSpeed = _RepairingTrackSpeed;};
							if (!(_Veh in list _Trigger)) exitWith {hint "You've left the service station, service ended."; NEKY_BUSY = False;};
							hint format ["Repairing %1.",_PartName];
							if (_Part == "Karoserie") then {_Veh setHit [_Part, (_PartHP - _RepairingSpeed)];} else {_Veh setHitPointDamage [_Part, (_PartHP - _RepairingSpeed)];};
							if (_Part == "Karoserie") then {_PartHP = _Veh gethit _Part} else {_PartHP = _Veh gethitpointdamage _Part};
							sleep 1;
							hint format ["Repairing %1..",_PartName];
							_Veh setHitPointDamage [_Part, (_PartHP - _RepairingSpeed)];
							if (_Part == "Karoserie") then {_PartHP = _Veh gethit _Part} else {_PartHP = _Veh gethitpointdamage _Part};
							sleep 1;
							hint format ["Repairing %1...",_PartName];
							_Veh setHitPointDamage [_Part, (_PartHP - _RepairingSpeed)];
							if (_Part == "Karoserie") then {_PartHP = _Veh gethit _Part} else {_PartHP = _Veh gethitpointdamage _Part};
							sleep 1;
					};
					Hint Format ["%1 is now repaired.",_PartName];
					sleep 2;
			} else {
					Hint format ["%1 is not in need of repairs.",_PartName];
					sleep 2;
			};
			_Index = _Index +1;
	};

	//      Fixing Wheels
	if (_Veh isKindOf "CAR") then {
			if (!(_Veh in list _Trigger)) exitWith {hint "You've left the service station, service ended."; NEKY_BUSY = False;};
			_Wheels = 2;
			_Index = 1;
			if (_veh getHit "wheel_1_3_steering" >= 0) then {_Wheels = 3};
			if (_veh getHit "wheel_1_4_steering" >= 0) then {_Wheels = 4};

			for [{_y=1},{_y<=2},{_y=_y+1}] do {
					for [{_i=1},{_i<=(_Wheels)},{_i=_i+1}] do {
							if (!(_Veh in list _Trigger)) exitWith {hint "You've left the service station, service ended."; NEKY_BUSY = False;};
							Private "_State";

							hint "Inspecting Wheel.";
							sleep _InspectionSpeed;
							hint "Inspecting Wheel..";
							sleep _InspectionSpeed;
							hint "Inspecting Wheel...";
							sleep _InspectionSpeed;

							_State = call compile format ["_veh getHit 'wheel_%2_%1_steering'",_i,_Index];
							if (_State > 0.1) then {
									if (!(_Veh in list _Trigger)) exitWith {hint "You've left the service station, service ended."; NEKY_BUSY = False;};
									hint "Removing damaged Wheel...";
									Sleep _RemoveWheelSpeed;
									call compile format ["_veh setHit ['wheel_%2_%1_steering',1]",_i,_Index];
									hint "Mounting new Wheel...";
									Sleep _MountWheelSpeed;
									call compile format ["_veh setHit ['wheel_%2_%1_steering',0]",_i,_Index];
									if (_index == 2 && _i == _Wheels) then {hint "New wheel mounted, all wheels have been inspected and repaired";} else {hint "New wheel mounted, inspecting next wheel"};
							} else {
									if (_Index == 2 && _i == _Wheels) then {hint "Last wheel inspected, all wheels are good"} else {Hint "Wheel is fine, inspecting next wheel"};
							};
							sleep 2;
							if (!(_Veh in list _Trigger)) exitWith {hint "You've left the service station, service ended."; NEKY_BUSY = False;};
					};
					_Index = _Index +1;
			};
	};

	if (!(_Veh in list _Trigger)) exitWith {hint "You've left the service station, service ended."; NEKY_BUSY = False;};
	hint "Applying finishing Touches";
	sleep 5;
	_Veh setdamage 0;
	hint "Repairs Complete!";
	sleep 2;

	_Driver = driver _Veh;
	if (_Driver in _Veh && !_FullService) then {_Veh engineOn True};
	NEKY_BUSY = False;
	if (_FullService) then {[_Veh,_Refueling,_FullService,_Trigger,_RearmSleep,_RearmSleepPlane,_Lights] call GOL_Fnc_ServiceStation_Refuel};
