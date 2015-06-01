// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		All objects placed in zeus module in the area around player and is stored in your clipboard
// *		Past it in to a document to use it later
// *
// *	Usage:
// *		[100] call GOL_Fnc_CopyObjects;
// *
// *	Parameters:
// *		0: Can be either of the two below, String or Number
// *			String: Name of array that the objects will be added to
// *			Number: Area around player
// *		1: Number: Area around player (Only valid if a string is entered above)
// *
// *	Returning Value:
// *		Array: Code to be used together with the function GOL_Fnc_CreateObjects
// *
// ================================================================

	if (isMultiplayer) exitWith {false};
	private ["_DebugName","_Objects","_positionsCopyed","_CopyObjects","_ObjectsClass","_AllObjects","_count","_distance","_veh","_direction","_location","_strArr"];
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

	_distance = [_this, 0, 100, ["",0]] call BIS_fnc_param;
	if (typeName _distance isEqualTo "STRING") then {
		_CopyObjects pushBack _distance;
		_distance = [_this, 1, 100, [0]] call BIS_fnc_param;
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
		_location = getPosATL _x;
		_strArr = [format ["%1", _veh], _direction, _location];
		_CopyObjects pushBack _strArr;
	} forEach _AllObjects;

	[] call _positionsCopyed;
