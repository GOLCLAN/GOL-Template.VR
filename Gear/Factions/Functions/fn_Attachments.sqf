
	// loop trough the attachments and add them to the primary weapon
	if (typeName _primaryAttachments == typeName []) then {
		removeAllPrimaryWeaponItems _unit;
		{
			_unit addPrimaryWeaponItem _x;
		} ForEach _primaryAttachments;
	};

	// loop trough the attachments and add them to the secondary weapon
	if (typeName _secondaryAttachments == typeName []) then {
		removeAllHandgunItems _unit;
		{
			_unit addHandgunItem _x;
		} ForEach _secondaryAttachments;
	};
