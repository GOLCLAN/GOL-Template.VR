// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *	A simpler way of adding gear to a unit
// *
// *	Usage:
// *	[_unit, _riflemag, 5] call GOL_Fnc_AddObjects;
// *	[player, "30Rnd_mas_556x45_Stanag", 5] call GOL_Fnc_AddObjects;
// *
// *	Parameters:
// *	0:	String:		Classname of magazines to be added
// *	1:	Unit:		Target that should get the magazines
// *	2:	Number:		Amount of magazines
// *
// ================================================================

	private ["_item","_number"];

	_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
	_item = [_this, 1, "", [""]] call BIS_fnc_param;
	_number = [_this, 2, 1, [0]] call BIS_fnc_param;

	if !(isNil "_item") then {
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Item") then {
			_unit addItemCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Mine") then {
			_unit addItemCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Magazine") then {
			_unit addMagazineCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Weapon") then {
			_unit addWeaponCargoGlobal [_item, _number];
		};
	};