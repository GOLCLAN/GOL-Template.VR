/*	================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		All objects from a array will placed on the map
		Will add all objects if to a optinal array to be called later if wanted
		Only in the editor it adds all objects to the zeus so you can easily chance it if needed

		If first param is a string then it will be a variable, set it to a unique so you can call it later in the mission to delete all objects by using:
		{	deleteVehicle _x;	} forEach (missionNamespace getVariable "TESTARRAY");

	Usage:
		[["O_MBT_02_arty_F",4.87696e-005,[447.058,1296.36,-0.00276756]]] call GOL_Fnc_CreateObjects;
		["TESTARRAY",["O_MBT_02_arty_F",4.87696e-005,[447.058,1296.36,-0.00276756]]] call GOL_Fnc_CreateObjects;
		["TESTARRAY",player,["O_MBT_02_arty_F",4.87696e-005,[2.48328,5.96948,-0.00143909]]] call GOL_Fnc_CreateObjects;

	Parameters:
		#0: String: Name of variable to be used (Optional (NOTE: Requires a new name for each time its executed))
		#1: Object: Name of variable to be used (Optional (Only Valid if #0 exists))

	Returning Value:
		Adds each object to a array

// ================================================================ */

	if (!isServer) exitWith {false};

	_this spawn {
		private ["_Array","_Objects","_Object","_direction","_location","_veh","_type","_pos"];
		if (isNil "Objectcounter") then {
			Objectcounter = 0;
		};
		_Array = [];
		_Objects = [];
		{
			if (!(typeName _x isEqualTo "STRING") && !(typeName _x isEqualTo "OBJECT")) then {
				_Objects pushBack _x;
			};
		} forEach _this;

		#define	isWater(Object,Pos) if (surfaceIsWater ([_location] call GOL_Fnc_GetPos)) then {  Object setPosASL Pos; } else { Object setPosATL Pos; };
		{
			sleep 0.1;
			_Object = (_x select 0);
			_direction = (_x select 1);
			_location = (_x select 2);
				_veh = _Object createVehicle [0,0,0];
				_veh setDir _direction;
				_veh setVariable ["GOL_Caching", true, true];

				if (typeName (_this select 1) isEqualTo "OBJECT") then {
					_veh setPosATL ((_this select 1) modelToWorld _location);
				} else {
					if (_veh isKindOf "AllVehicles") then {
				        _pos = [(_location select 0), (_location select 1), (_location select 2) + 1];
						isWater(_veh, _pos);
					} else {
						isWater(_veh, _location);
					};
				};

//				if (_veh isKindOf "StaticWeapon" || _veh isKindOf "House" || _veh isKindOf "HouseBase") then {
				if !(GOL_ObjectSurfaceNormal) then {
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
			waitUntil {sleep 1; (count _Objects) isEqualTo (count _Array)};
			missionNamespace setVariable [(_this select 0), _Array];
		};
	};
