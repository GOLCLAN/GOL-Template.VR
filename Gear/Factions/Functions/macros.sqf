
/*
	private ["_object", "_groupName", "_fireTeam", "_class"];
	_object = _this select 0;
	_groupName = _this select 1;
	_fireTeam = _this select 2;
	_class = _this select 3;
*/

	#define Is_NIL(Value,Code) \
		if (!isNil {Value}) then { Code };

	#define FOR_LOOP(Loops,code) \
		for "_i" from 0 to (Loops-1) do { code };

	#define	ADD_TO_ARRAY(VALUE,Amount) \
		if (([VALUE] call BIS_fnc_itemType select 0) == "Item") then { \
			ADD_ITEM(VALUE,Amount,addItem); \
		}; \
		if (([VALUE] call BIS_fnc_itemType select 0) == "Magazine") then { \
			ADD_MAGAZINE(VALUE,Amount); \
		}; \
		if (([VALUE] call BIS_fnc_itemType select 0) == "Weapon") then { \
			ADD_WEAPON(VALUE); \
		};

	#define REMOVE_ALL \
		removeHeadgear _unit; \
		removeUniform _unit; \
		removeVest _unit; \
		removeBackpackGlobal _unit; \
		removeGoggles _unit; \
		removeAllAssignedItems _unit; \
		removeAllContainers _unit; \
		removeAllItems _unit; \
		removeAllWeapons _unit; \
		clearAllItemsFromBackpack _unit;

	#define REMOVE_ALL_CARGO \
		clearBackpackCargoGlobal _unit; \
		clearItemCargoGlobal _unit; \
		clearMagazineCargoGlobal _unit; \
		clearWeaponCargoGlobal _unit;

//	Gear
	#define ADD_Uniform(ClassH,ClassU,ClassV,ClassG) \
		REMOVE_ALL; \
		Is_NIL(ClassH,(_unit AddHeadgear ClassH)); \
		Is_NIL(ClassU,(_unit forceAddUniform ClassU)); \
		Is_NIL(ClassV,(_unit AddVest ClassV)); \
		Is_NIL(ClassG,(_unit AddGoggles ClassG));

//	====================================================================================

//	Backpack
	#define ADD_BACKPACK(Class) \
		_unit addBackpackGlobal Class; \
		clearMagazineCargoGlobal (unitBackpack _unit); \
		clearItemCargoGlobal (unitBackpack _unit);

	#define ADD_BACKPACK_ITEM(Class,Amount) \
		(unitBackpack _unit) addItemCargoGlobal [Class, Amount];

	#define ADD_BACKPACK_MAGAZINE(Class,Amount) \
		(unitBackpack _unit) addMagazineCargoGlobal [Class, Amount];

//	====================================================================================

//	Items
	#define ADD_ITEM(Class) \
		_unit addItem Class;

	#define ADD_ITEM_LINKED(Class) \
		_unit linkItem Class;

	#define ADD_ITEM_PRIORITY(Class) \
		if (_unit canAddItemToUniform Class) then { \
			_unit addItemToUniform Class; \
		} else { \
			if (_unit canAddItemToVest Class) then { \
				_unit addItemToVest Class; \
			} else { \
				if (_unit canAddItemToBackpack Class) then { \
					_unit addItemToBackpack Class; \
				} else { \
					["Unit: (%2) || Not enough space for item: (%1)", Class, _unit] call BIS_fnc_error; \
				}; \
			}; \
		};

	#define ADD_ITEM_PRIORITY_FOREACH(Class,Amount) \
		FOR_LOOP(Amount, ADD_ITEM_PRIORITY(Class));

//	====================================================================================

//	Magazines
	#define ADD_MAGAZINE(classMagazine,Amount) \
	    _unit addMagazines [classMagazine, Amount];

	#define Count_AG_Mags(classMagazine) (300 / (getNumber (configfile >> "CfgMagazines" >> classMagazine >> "count")))

	#define Count_AR_Mags(classMagazine) ((600 / (getNumber (configfile >> "CfgMagazines" >> classMagazine >> "count"))) / 2)

//	====================================================================================

//	Weapons
	#define ADD_WEAPON(class) \
		_unit addWeapon class;

	#define ADD_WEAPONS(class) \
		{ \
			_unit addWeapon _x; \
		} forEach class;

	#define ADD_WEAPON_ARRAY(class,classMagazine,Amount) \
		ADD_MAGAZINE(classMagazine,Amount); \
		_unit addWeapon class;
