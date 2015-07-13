/*	================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		All objects placed in zeus module in the area around player and is stored in your clipboard
		Past it in to a document to use it later

	Usage:
		[100] call GOL_Fnc_CopyObjects;
		[100, "TestArray"] call GOL_Fnc_CopyObjects;
		[100, "TestArray", player] call GOL_Fnc_CopyObjects;

	Parameters:
		#0: Number: Area around player
		#1: String: Name of array that the objects will be added to
		#2: Object: Position objects will be centered around, instead of global pos (Only valid if a string is entered above)

	Returning Value:
		Array: Code to be used together with the function GOL_Fnc_CreateObjects

// ================================================================ */

	if (isMultiplayer) exitWith {false};
	private ["_DebugName","_Objects","_positionsCopyed","_CopyObjects","_ObjectsClass","_AllObjects","_count","_distance","_veh","_direction","_location","_strArr","_copyFrom"];
	_DebugName = "GOL-CopyObjects";
	scriptName _DebugName;

	_Objects = curatorEditableObjects GOL_ZeuzModuleAdminLogged;
	_positionsCopyed = {
		[["%1 Buildings Copied",(count _CopyObjects)],[_DebugName,__FILE__,__LINE__],"both"] call GOL_Fnc_DebugLog;
		copyToClipboard (format ["%1 call GOL_Fnc_CreateObjects;", str(_CopyObjects)]);
	};

	_ObjectsClass = [];
	_AllObjects = [];
	_CopyObjects = [];
	_count = 0;

	_distance = [_this, 0, 100, [0]] call BIS_fnc_param;
	if (count _this >= 2) then {
		if (typeName (_this select 1) isEqualTo "STRING") then {
			_CopyObjects pushBack (_this select 1);
		};
	};
	if (count _this == 3) then {
		if (typeName (_this select 2) isEqualTo "OBJECT") then {
			_copyFrom = [_this, 2, player, [objNull]] call BIS_fnc_param;
			_CopyObjects pushBack _copyFrom;
		};
	};

	{
		if ((_x distance player) < _distance) then {
			_ObjectsClass pushBack (typeOf _x);
			_AllObjects pushBack _x;
		};
	} forEach _Objects;

	{
		_veh = _ObjectsClass select _count;
		_count = _count + 1;
		_direction = getDir _x;
		if !(isNil "_copyFrom") then {
			_location = _copyFrom worldToModel (position _x);
		} else {
			_location = getPosATL _x;
		};

		_strArr = [format ["%1", _veh], _direction, _location];
		_CopyObjects pushBack _strArr;
	} forEach _AllObjects;

	[] call _positionsCopyed;
