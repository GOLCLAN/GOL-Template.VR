// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *	A simpler way of adding gear to a unit
// *
// *	Usage:
// *	[_unit, _riflemag, 5] call ACEGOL_Fnc_AddObjectsToBackpack;
// *	[player, "30Rnd_mas_556x45_Stanag", 5] call GOL_Fnc_AddObjectsToBackpack;
// *
// *	Parameters:
// *	0:	String:		Classname of magazines to be added
// *	1:	Unit:		Target that should get the magazines
// *	2:	Number:		Amount of magazines
// *
// ================================================================

	#include "macros.sqf";

	private ["_item","_number"];
	if (isNil "_unit") then { _unit = player; };
	{
		_item = (_x select 0);
		_number = (_x select 1);

		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Item") then {
			ADD_Item_BP(_item, _number);
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Mine") then {
			ADD_Item_BP(_item, _number);
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Magazine") then {
			ADD_MAGAZINE_BP(_item, _number);
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Weapon") then {
			ADD_WEAPON_BP(_item, _number);
		};
	} forEach _this;