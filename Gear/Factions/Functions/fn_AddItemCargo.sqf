// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *	A simpler way of adding gear to a unit
// *
// *	Usage:
// *	[_unit, _riflemag, 5] call GOL_Fnc_AddItemCargo;
// *	[player, "30Rnd_mas_556x45_Stanag", 5] call GOL_Fnc_AddItemCargo;
// *
// *	Parameters:
// *	0:	String:		Classname of magazines to be added
// *	1:	Unit:		Target that should get the magazines
// *	2:	Number:		Amount of magazines
// *
// ================================================================

	private ["_unit","_item","_number"];

	_unit = [_this, 0, "Error", [objNull]] call BIS_fnc_param;
	_item = [_this, 1, "", [""]] call BIS_fnc_param;
	_number = [_this, 2, 1, [0]] call BIS_fnc_param;

	_DebugName = "GOL_Fnc_AddItemCargo";
	scriptName _DebugName;

	if !(typeName _unit == "OBJECT") exitWith {
		["Error: Unit not Object: || %1 || %2  || %3 ||", _unit, _item, _number] call BIS_fnc_error;
		false
	};

	if (isNull _unit) exitWith {
		["Error: Unit is Null: || %1 || %2  || %3 ||", _unit, _item, _number] call BIS_fnc_error;
		false
	};

	if (_item == "") exitWith {
		["Error: String Empty (Item): || %1 || %2 || %3 ||", _unit, _item, _number] call BIS_fnc_error;
		false
	};

	_unit addItemCargoGlobal [_item, _number];
	true
