// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		All objects placed in zeus module in the area around player and is stored in your clipboard
// *		Past it in to a document to use it later
// *
// *	Usage:
// *		[100] call GOL_Fnc_CopyObjects;
// *		[100, "TestArray"] call GOL_Fnc_CopyObjects;
// *		[100, "TestArray", player] call GOL_Fnc_CopyObjects;
// *
// *	Parameters:
// *		#0: Number: Area around player
// *		#1: String: Name of array that the objects will be added to
// *		#2: Object: Position objects will be centered around, instead of global pos (Only valid if a string is entered above)
// *
// *	Returning Value:
// *		Array: Code to be used together with the function GOL_Fnc_CreateObjects
// *
// ================================================================

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
			_location = player worldToModel (position _x);
		} else {
			_location = getPosATL _x;
		};

		_strArr = [format ["%1", _veh], _direction, _location];
		_CopyObjects pushBack _strArr;
	} forEach _AllObjects;

	[] call _positionsCopyed;

/*

[["Land_BagBunker_Tower_F",2,[440.368,1293.09,-0.00354481]],["Land_CncBarrier_F",182,[425.033,1287.42,0.00101042]],["Land_CncBarrier_F",182,[427.674,1287.38,0.0010643]],["Land_CncBarrier_F",226,[422.751,1288.42,0.00113869]],["Land_CncBarrier_F",274,[421.887,1290.7,0.00142002]],["Land_CncBarrier_F",182,[438.565,1286.87,-0.00014925]],["Land_CncBarrier_F",182,[441.205,1286.83,3.38554e-005]],["Land_CncBarrier_F",139,[443.488,1287.69,3.76701e-005]],["Land_CncBarrier_F",91,[444.502,1289.96,6.91414e-005]],["RoadBarrier_F",185,[438.795,1285.01,-0.00399256]],["RoadBarrier_F",178,[427.391,1285.32,-0.00398779]]] call GOL_Fnc_CreateObjects;

["TestArray",["Land_BagBunker_Tower_F",2,[440.368,1293.09,-0.00354481]],["Land_CncBarrier_F",182,[425.033,1287.42,0.00101042]],["Land_CncBarrier_F",182,[427.674,1287.38,0.0010643]],["Land_CncBarrier_F",226,[422.751,1288.42,0.00113869]],["Land_CncBarrier_F",274,[421.887,1290.7,0.00142002]],["Land_CncBarrier_F",182,[438.565,1286.87,-0.00014925]],["Land_CncBarrier_F",182,[441.205,1286.83,3.38554e-005]],["Land_CncBarrier_F",139,[443.488,1287.69,3.76701e-005]],["Land_CncBarrier_F",91,[444.502,1289.96,6.91414e-005]],["RoadBarrier_F",185,[438.795,1285.01,-0.00399256]],["RoadBarrier_F",178,[427.391,1285.32,-0.00398779]]] call GOL_Fnc_CreateObjects;

["TestArray",wpl,["Land_BagBunker_Tower_F",2,[4.16193,19.245,-0.0049839]],["Land_CncBarrier_F",182,[-11.5391,14.7328,-0.000428677]],["Land_CncBarrier_F",182,[-8.90912,14.4929,-0.000374794]],["Land_CncBarrier_F",226,[-13.7349,15.8977,-0.000300407]],["Land_CncBarrier_F",274,[-14.4241,18.2336,-1.90735e-005]],["Land_CncBarrier_F",182,[1.91241,13.1678,-0.00158834]],["Land_CncBarrier_F",182,[4.54272,12.9318,-0.00140524]],["Land_CncBarrier_F",139,[6.87817,13.6151,-0.00140142]],["Land_CncBarrier_F",91,[8.05566,15.7953,-0.00136995]],["RoadBarrier_F",185,[1.99921,11.2876,-0.00544024]],["RoadBarrier_F",178,[-9.34863,12.4604,-0.00543594]]] call GOL_Fnc_CreateObjects;

*/
