
	// ================================================================
	// *	Gear Configurations

	//	====================================================================================
	//	SELECTING FROM PARAMETERS IF EXTRA GEAR IS ENABLED
	GOL_Gear_Camo = (["Gear", "Camoflage"] call GOL_Fnc_GetConfig);

	GOL_Gear_Extra = false;
	GOL_Gear_Additional = false;
	if (("GOL_Params_Extra_Gear" call BIS_fnc_getParamValue) >= 1) then {
		if (("GOL_Params_Extra_Gear" call BIS_fnc_getParamValue) == 2) then {
			GOL_Gear_Additional = true;
		};
		GOL_Gear_Extra = true;
	};

	switch (("GOL_Params_Faction_West" call BIS_fnc_getParamValue)) do {
		case 2:	{
			GOL_Faction_West = "FIA";
		};
		case 3:	{
			GOL_Faction_West = "USMC";
		};
		case 4:	{
			GOL_Faction_West = "BAF";
		};
		case 5:	{
			GOL_Faction_West = "IDF";
		};
		default	{
			GOL_Faction_West = "NATO";
		};
	};

	switch (("GOL_Params_Faction_East" call BIS_fnc_getParamValue)) do {
		case 2:	{
			GOL_Faction_East = "Russians";
		};
		case 3:	{
			GOL_Faction_East = "Guerillas";
		};
		case 4:	{
			GOL_Faction_East = "Insurgents";
		};
		default	{
			GOL_Faction_East = "CSAT";
		};
	};

	switch (("GOL_Params_Faction_Independent" call BIS_fnc_getParamValue)) do {
		default	{
			GOL_Faction_Indep = "AAF";
		};
	};

	// ================================================================
	// *	Creates backup of the faction if it for some reason would need to reset to the originial

	if (isNil "GOL_Faction_West_Orgi" || isNil "GOL_Faction_East_Orgi" || isNil "GOL_Faction_Indep_Orgi") Then {
		GOL_Faction_West_Orgi = GOL_Faction_West;
		compileFinal GOL_Faction_West_Orgi;
		GOL_Faction_East_Orgi = GOL_Faction_East;
		compileFinal GOL_Faction_East_Orgi;
		GOL_Faction_Indep_Orgi = GOL_Faction_Indep;
		compileFinal GOL_Faction_Indep_Orgi;
	};
