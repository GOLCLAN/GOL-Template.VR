	// loop trough the attachments and add them to the primary weapon
	if (!isNil "_primaryAttachments") then {
		if (typeName _primaryAttachments isEqualTo typeName []) then {
			removeAllPrimaryWeaponItems _unit;
			{
				private ["_attachments"];
				_attachments = (_unit weaponAccessories primaryWeapon _unit);
				if ([_x] call BIS_fnc_itemType select 1 == "AccessoryMuzzle") then {
					if (_attachments select 0 == "") then {
						_unit addPrimaryWeaponItem _x;
					} else {
						_unit additem _x;
					};
				};
				if ([_x] call BIS_fnc_itemType select 1 == "AccessoryPointer") then {
					if (_attachments select 1 == "") then {
						_unit addPrimaryWeaponItem _x;
					} else {
						_unit additem _x;
					};
				};
				if ([_x] call BIS_fnc_itemType select 1 == "AccessorySights") then {
					if (_attachments select 2 == "") then {
						_unit addPrimaryWeaponItem _x;
					} else {
						_unit additem _x;
					};
				};
				if ([_x] call BIS_fnc_itemType select 1 == "AccessoryBipod") then {
					if (_attachments select 3 == "") then {
						_unit addPrimaryWeaponItem _x;
					} else {
						_unit additem _x;
					};
				};
			} ForEach _primaryAttachments;
		};
	};

	// loop trough the attachments and add them to the secondary weapon
	if (!isNil "_secondaryAttachments") then {
		if (typeName _secondaryAttachments isEqualTo typeName []) then {
			removeAllHandgunItems _unit;
			{
				_unit addHandgunItem _x;
			} ForEach _secondaryAttachments;
		};
	};