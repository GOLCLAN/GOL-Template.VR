// ====================================================================================
// *
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Defines the vehicle as a mhq and makes you able to teleport to it
// *
// *	Usage:
// *		null = [this] spawn GOL_Fnc_MHQ;
// *
// *	Parameters:
// *		0: Vehicle
// *
// *	Returning Value:
// *		None
// *
// ====================================================================================

	if (!isServer) exitWith {false};
	private ["_MHQ","_MHQ_Actions","_MHQ_Spawn","_MHQPos","_MHQName","_MHQClassname","_loop","_MHQ_Old"];
	waitUntil {sleep 0.5; time > 5};

	_MHQ = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
	_MHQPos = getPosATL _MHQ;
	_MHQName = vehicleVarName _MHQ;
	_MHQClassname = typeOf _MHQ;
	_MHQ setVariable ["GOL_MHQ_Active", false, true];	// Disabled
	[_MHQ,"",[false,false,false]] call GOL_Fnc_GearHandler;
	if (isNil "MHQArray") then { MHQArray = [];};
	if !(_MHQ in MHQArray) then { MHQArray pushBack _MHQ; publicVariable "MHQArray"; };

	_MHQ_Actions = {
		[[[_MHQ], {
			[_this select 0] call GOL_Fnc_MHQActions;
		}], "bis_fnc_call", true] call BIS_fnc_MP;
		if (isMultiplayer) then {
			_MHQ setVariable ["GOL_MHQ_Active", nil];
		};
	};

	_MHQ_Spawn = {
		_MHQ_New = createVehicle [_MHQClassname, _MHQPos, [""], 0, "NONE"];
		if ((_MHQ distance _MHQ_New) < 30) Then {
			deleteVehicle _MHQ;
		} else {
			[_MHQ] spawn {
				private ["_MHQ_Old"];
				sleep 600;
				_MHQ_Old = [_this, 0] call BIS_fnc_param;
				_MHQ_Old setVehicleVarName nil;
				deleteVehicle _MHQ_Old;
			};
		};
		_MHQ_New setPosATL _MHQPos;
		_MHQ_New SetVehicleVarName _MHQName;
		Call Compile Format ["%1 = _MHQ_New; PublicVariable '%1';",_MHQName];
		[_MHQ_New] call GOL_Fnc_MHQ;
	};

	while {alive _MHQ} do {
		if (!isNil {_MHQ getVariable "GOL_MHQ_Active"}) then {
			[_MHQ] call _MHQ_Actions;
		};
		if ((speed _MHQ) >= 5) Then {
			_MHQ setVariable ["GOL_MHQ_Active", false, true];
		};
		sleep 5;
	};
	sleep 0.1;
	if (!alive _MHQ) then {
		_MHQ setVariable ["GOL_MHQ_Active", false, true];
		MHQArray = MHQArray - [_MHQ];
		publicVariable "MHQArray";
		[_MHQ] call _MHQ_Actions;
		[] call _MHQ_Spawn;
	};
