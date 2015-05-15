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

	#include "macros.sqf";

	private ["_Group","_item","_number"];
	if (isNil "_unit") then { _unit = player; };
	_Group = [];
	{
		_Group pushBack _x;
	} forEach _this;
	{
		_item = (_x select 0);
		_number = [_x, 1, 1, [0]] call BIS_fnc_param;
		if (([_item] call BIS_fnc_itemType select 0) == "Item") then {
			if (([_item] call BIS_fnc_itemType select 1) == "Binocular") then {
				_unit addWeapon _item;
			} else {
				ADD_ITEM_PRIORITY_FOREACH(_item,_number);
			};
		};
		if (([_item] call BIS_fnc_itemType select 0) == "Magazine") then {
//			_unit addMagazines [_item,_number];
			ADD_ITEM_PRIORITY_FOREACH(_item,_number);
		};

		if (([_item] call BIS_fnc_itemType select 0) == "Weapon") then {
			_unit addWeapon _item;
		};
	} forEach _Group;

/*
				for "_x" from 1 to _number do {
					_unit addItem _item;
					ADD_ITEM_PRIORITY(_item);
				};
*/
