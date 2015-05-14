// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *	A simpler way of adding gear to a unit
// *
// *	Usage:
// *	[_unit, _riflemag, 5] call GVL_Fnc_AddItem;
// *	[player, "30Rnd_mas_556x45_Stanag", 5] call GVL_Fnc_AddItem;
// *
// *	Parameters:
// *	0:	String:		Classname of magazines to be added
// *	1:	Unit:		Target that should get the magazines
// *	2:	Number:		Amount of magazines
// *
// ================================================================

	private ["_Group","_item","_number"];
	if (isNil "_unit") then { _unit = player; };
	_Group = [];
	{
		_Group pushBack _x;
	} forEach _this;
	{
		_item = (_x select 0);
		_number = (_x select 1);

		if (([_item] call BIS_fnc_itemType select 0) == "Item") then {
			(unitBackpack _unit) addItemCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) == "Magazine") then {
			(unitBackpack _unit) addMagazineCargoGlobal [_item,_number]
		};
		if (([_item] call BIS_fnc_itemType select 0) == "Weapon") then {
			(unitBackpack _unit) addWeaponCargoGlobal [_item, _number];
		};
	} forEach _Group;
