/*	================================================================
	AUTHOR: R4IDER

	Description:
		All AI placed in zeus module or via Eden in the area around player and is stored in your clipboard
		Past it in to a document to use it later

	Usage:
		[500,EAST] call GOL_Fnc_CopyAIEdenZeus;

	Parameters:
		#0: Number: Area around player
		#1: String: Name of array that the AI will be added to
		#2: Object: Position objects will be centered around, instead of global pos (Only valid if a string is entered above)

	Returning Value:
		Array: Code to be used together with the function GOL_Fnc_CreateObjects
		
		"WEST", "EAST", "GUER", "CIV"

// ================================================================ */

	if (isMultiplayer) exitWith {false};
	private ["_DebugName","_Objects","_positionsCopyed","_CopyObjects","_ObjectsClass","_AllObjects","_count","_distance","_veh","_direction","_location","_strArr","_copyFrom","_side","_stance"];
	_DebugName = "GOL_Fnc_CopyAIEdenZeus";
	scriptName _DebugName;

	_Objects = curatorEditableObjects GOL_ZeuzModuleAdminLogged;
	_positionsCopyed = {
		[["%1 Units Copied",(count _CopyObjects)],[_DebugName,__FILE__,__LINE__],"both"] call GOL_Fnc_DebugLog;
		copyToClipboard (format ["%1 spawn GOL_Fnc_CreateAIStaticAutoGroup;", str(_CopyObjects)]);
	};
	
	/*{
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
		_x disableAI "MOVE";
		_x disableAI "ANIM";
		_x disableAI "TEAMSWITCH";
		_x disableAI "FSM";
		_x disableAI "AIMINGERROR";
		_x disableAI "SUPPRESSION";
		_x disableAI "CHECKVISIBLE";
		_x disableAI "COVER";
		_x disableAI "AUTOCOMBAT";
	} forEach AllUnits;*/

	_ObjectsClass = [];
	_AllObjects = [];
	_CopyObjects = [];
	_count = 0;

	_distance = [_this, 0, 500] call BIS_fnc_param;
	_side = [_this, 1, "EAST"] call BIS_fnc_param;
	//hint format["%1 - %2", _distance, _side];
	
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
		if (side _x == _side) then {
			_veh = _ObjectsClass select _count;
			_count = _count + 1;
			_direction = getDir _x;
			_stance = stance _x;
			
			if (_stance == "STAND") then {
				_stance = "UP";
			};
			if (_stance == "CROUCH") then {
				_stance = "MIDDLE";
			};
			if (_stance == "PRONE") then {
				_stance = "DOWN";
			};
			if (_stance == "UNDEFINED") then {
				_stance = "AUTO";
			};
			if (isNil "_stance") then { 
				_stance = "AUTO";
			};
			
			if !(isNil "_copyFrom") then {
				_location = _copyFrom worldToModel (position _x);
			} else {
				_location = getPosATL _x;
			};

			_strArr = [_location, _direction, _stance];
			_CopyObjects pushBack _strArr;
		};	
	} forEach _AllObjects;

	[] call _positionsCopyed;
