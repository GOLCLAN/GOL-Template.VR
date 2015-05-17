// ================================================================
// *
// *	Description:
// *		All objects from a array will placed on the map
// *		Will add all objects if to a optinal array to be called later if wanted
// *		Only in the editor it adds all objects to the zeus so you can easily chance it if needed
// *
// *		If first param is a string then it will be a variable, set it to a unique so you can call it later in the mission to delete all objects by using:
// *		{	deleteVehicle _x;	} forEach (missionNamespace getVariable "TESTARRAY");
// *
// *	Usage:
// *		["TESTARRAY",["O_MBT_02_arty_F",4.87696e-005,[447.058,1296.36,-0.00276756]]] call GOL_Fnc_CreateObjects;
// *
// *	Parameters:
// *		0: String: Name of variable to be used (Optional)
// *
// *	Returning Value:
// *		Adds each object to a array
// *
// ================================================================

	if (!isServer) exitWith {false};

	_this spawn {
		private ["_Array","_Objects","_Object","_direction","_location","_veh","_setpos"];
		if (isNil "Objectcounter") then {
			Objectcounter = 0;
		};
		_Array = [];
		_Objects = [];
		{
			if !(typeName _x isEqualTo "STRING") then {
				_Objects pushBack _x;
			};
		} forEach _this;

		{
			sleep 0.1;
			_Object = (_x select 0);
			_direction = (_x select 1);
			_location = (_x select 2);
				_veh = _Object createVehicle [0,0,0];
				_veh setDir _direction;
				if (_veh isKindOf "AllVehicles") then {
					_veh setPosATL [(_location select 0), (_location select 1), (_location select 2) + 1];
				} else {
					_veh setPosATL _location;
				};
				if (_veh isKindOf "StaticWeapon" || _veh isKindOf "House" || _veh isKindOf "HouseBase") then {
					_veh setVectorUp [0,0,1];
				} else {
					_veh setVectorUp surfaceNormal position _veh;
				};

			if (typeName (_this select 0) isEqualTo "STRING") then {
				_name = format ["Object_Array_%1",Objectcounter];
				_veh setVehicleVarName _name;
				_Array pushBack _veh;
				Objectcounter = Objectcounter + 1;
			};

			if (!isMultiplayer) then {
				GOL_ZeuzModuleAdminLogged addCuratorEditableObjects [[_veh],true];
			};
		} forEach _Objects;

		if (typeName (_this select 0) isEqualTo "STRING") then {
			waitUntil {(count _Objects) isEqualTo (count _Array)};
			missionNamespace setVariable [(_this select 0), _Array];
		};
	};
