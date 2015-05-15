
	#define Is_NIL(Value,Code) \
		if (!isNil {Value}) then { Code };

	#define FOR_LOOP(Loops,code) \
		for "_i" from 0 to (Loops-1) do { code };

//	====================================================================================

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

	#define ADD_ITEM_PRIORITY_FOREACH(Class,Amount) FOR_LOOP(Amount, ADD_ITEM_PRIORITY(Class));

//	====================================================================================

	#define Count_AG_Mags(classMagazine) (300 / (getNumber (configfile >> "CfgMagazines" >> classMagazine >> "count")))

	#define Count_AR_Mags(classMagazine) ((600 / (getNumber (configfile >> "CfgMagazines" >> classMagazine >> "count"))) / 2)
