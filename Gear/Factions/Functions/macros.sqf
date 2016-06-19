
	#define Is_NIL(Value,Code) \
		if (!isNil {Value}) then { Code };

	#define IsNIL_Cond(Value) \
		!isNil {Value}

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
		removeBackpackGlobal _unit; \
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

//	====================================================================================
//	====================================================================================

	#define ADD_ITEM(Class) _unit addItem Class;

	#define ADD_ITEM_LINKED(Class) _unit linkItem Class;

	#define ADD_MAGAZINE(Class,Amount) _unit addMagazines [Class, Amount];

	#define ADD_WEAPON(Class) _unit addWeapon Class;

//	====================================================================================

	#define ADD_Item_BP(Class,Amount) (unitBackpack _unit) addItemCargoGlobal [Class, Amount];

	#define ADD_MAGAZINE_BP(Class,Amount) (unitBackpack _unit) addMagazineCargoGlobal [Class, Amount]

	#define ADD_WEAPON_BP(Class, Amount) (unitBackpack _unit) addWeaponCargoGlobal [Class, Amount];

//	====================================================================================

	#define DEFAULT_UNIFORM \
		ADD_ITEM_LINKED(_map); \
		ADD_ITEM_LINKED(_compass); \
		ADD_ITEM_LINKED(_watch); \
		for "_i" from 1 to 3 step 1 do { \
			ADD_ITEM(_bandage); \
		};

	#define	NightTimeOnce(Class) \
		if(_nightTime && _AllowNVG) Then { \
			ADD_Type(Class,1); \
		};

	#define	NightTime(Class, Amount) \
		if(_nightTime && _AllowNVG) Then { \
			ADD_Type(Class,Amount); \
		};

	#define ADD_Type(Class,Amount) \
		if (([Class] call BIS_fnc_itemType select 0) isEqualTo "Item") then { \
			if (([Class] call BIS_fnc_itemType select 1) isEqualTo "Binocular") then { \
				ADD_WEAPON(Class); \
			} else { \
				if (([Class] call BIS_fnc_itemType select 1) isEqualTo "NVGoggles") then { \
					ADD_ITEM_LINKED(Class); \
				} else { \
					for "_x" from 1 to Amount do { \
						ADD_ITEM(Class); \
					}; \
				}; \
			}; \
		}; \
		if (([Class] call BIS_fnc_itemType select 0) isEqualTo "Magazine") then { \
			ADD_MAGAZINE(Class,Amount); \
		}; \
		if (([Class] call BIS_fnc_itemType select 0) isEqualTo "Weapon") then { \
			ADD_WEAPON(Class); \
		};