// ====================================================================================
// *
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Defines the vehicle as a mhq and makes you able to teleport to it
// *
// *	Usage:
// *		null = [this] spawn GVL_Fnc_MHQ_Init;
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
	_MHQClassname = typeOf _MHQ;
	_MHQPos = getPosATL _MHQ;
	_MHQName = vehicleVarName _MHQ;
	_MHQ setVariable ["GVL_MHQ_Active", false, true];	// Disabled
	[_MHQ,"",[false,false,false]] call GVL_Fnc_GearHandler;

	_MHQ_Actions = {
		[[[_MHQ], {
			private ["_MHQ","_MHQName"];
			_MHQ = [_this, 0] call BIS_fnc_param;
			_MHQName = vehicleVarName _MHQ;
			removeAllActions _MHQ;
			removeAllActions gol_flag;
			if (_MHQ getVariable "GVL_MHQ_Active") Then {
				if (!isNil "mhq") Then {
					gol_flag addAction ["<t color='#FF0000'>Teleport to MHQ</t>"," [player,mhq] call GVL_Fnc_Teleport ",nil,1,false,false,"","((_target distance _this) < 7) && !(vehicle player != player)"];
				};

				_MHQ addAction ["<t color='#FF0000'>Deactivate MHQ</t>"," (_this select 0) setVariable ['GVL_MHQ_Active', false, true]; ",nil,1,false,false,"","((_target distance _this) < 7) && !(vehicle player != player) && (_target getVariable 'GVL_MHQ_Active')"];
				_MHQ addAction ["<t color='#7FFF00'>Teleport to Base</t>", "[player,gol_flag] call GVL_Fnc_Teleport",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];

				_MHQ addAction ["Platoon > Actual"," [player,'pl'] call GVL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
				_MHQ addAction ["Platoon > Forward Air Controller"," [player, 'fac'] call GVL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
				_MHQ addAction ["Squad > Fire Team Leader"," [player,'ftl'] call GVL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
				_MHQ addAction ["Squad > Rifleman"," [player,'r'] call GVL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
				_MHQ addAction ["Squad > Grenadier"," [player,'g'] call GVL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
				_MHQ addAction ["Squad > Asst. Gunner"," [player,'ag'] call GVL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
				_MHQ addAction ["Squad > Automatic Rifleman"," [player,'ar'] call GVL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
				_MHQ addAction ["Squad > Light Rifleman"," [player,'lr'] call GVL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
				_MHQ addAction ["Echo > Pilot"," [player,'p'] call GVL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			} else {
				_MHQ addAction ["<t color='#FF0000'>Activate MHQ</t>"," (_this select 0) setVariable ['GVL_MHQ_Active', true, true]; ",nil,1,false,false,"","((_target distance _this) < 7) && !(vehicle player != player) && !(_target getVariable 'GVL_MHQ_Active')"];
			};
		}], "bis_fnc_call", true] call BIS_fnc_MP;
		_MHQ setVariable ["GVL_MHQ_Active", nil];
	};

	_MHQ_Spawn = {
		_MHQ_Old = [_this, 0] call BIS_fnc_param;
		_MHQPos = [_this, 1] call BIS_fnc_param;
		_MHQName = [_this, 2] call BIS_fnc_param;
		_MHQClassname = [_this, 3] call BIS_fnc_param;

		_MHQ = createVehicle [_MHQClassname, _MHQPos, [""], 0, "NONE"];
		if ((_MHQ_Old distance _MHQ) < 30) Then {
			deleteVehicle _MHQ_Old;
		} else {
			[_MHQ] spawn {
				private ["_MHQ_Old"];
				sleep 600;
				_MHQ_Old = [_this, 0] call BIS_fnc_param;
				_MHQ_Old setVehicleVarName nil;
				deleteVehicle _MHQ_Old;
			};
		};
		_MHQ setPosATL _MHQPos;
		_MHQ SetVehicleVarName _MHQName;
		Call Compile Format ["%1 = _MHQ; PublicVariable '%1';",_MHQName];
		[_MHQ] call GVL_Fnc_MHQ_Init;
	};

	while {alive _MHQ} do {
//		if (_MHQ getVariable "GVL_MHQ_Active") then {
		if (!isNil {_MHQ getVariable "GVL_MHQ_Active"}) then {
			[_MHQ] call _MHQ_Actions;
		};
		if ((speed _MHQ) >= 5) Then {
			_MHQ setVariable ["GVL_MHQ_Active", false, true];
		};
		sleep 5;
	};
	sleep 0.1;
	if (!alive _MHQ) then {
		_MHQ setVariable ["GVL_MHQ_Active", false, true];
		[_MHQ] call _MHQ_Actions;
		[_MHQ,_MHQPos,_MHQName,_MHQClassname] call _MHQ_Spawn;
	};
