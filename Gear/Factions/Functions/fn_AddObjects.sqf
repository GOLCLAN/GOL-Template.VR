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
	if (isNil "_unit") then { _unit = player; };
	{
		_item = (_x select 0);
		_number = [_x, 1, 1, [0]] call BIS_fnc_param;
		_backpack = [_x, 2, false, [true]] call BIS_fnc_param;

		if (_backpack) then {

			if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Item") then {
				(unitBackpack _unit) addItemCargoGlobal [_item, _number];
			};
			if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Mine") then {
				(unitBackpack _unit) addItemCargoGlobal [_item, _number];
			};
			if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Magazine") then {
				(unitBackpack _unit) addMagazineCargoGlobal [_item,_number]
			};
			if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Weapon") then {
				(unitBackpack _unit) addWeaponCargoGlobal [_item, _number];
			};

		} else {

			if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Item") then {
				if (([_item] call BIS_fnc_itemType select 1) isEqualTo "Binocular") then {
					_unit addWeapon _item;
				} else {
					for "_i" from 1 to _number step 1 do {
						_unit addItem _item;
				    };
				};
			};
			if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Mine") then {
				_unit addItem _item;
			};
			if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Magazine") then {
				_unit addMagazines [_item,_number];
			};
			if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Weapon") then {
				_unit addWeapon _item;
			};
		};
	} forEach _this;