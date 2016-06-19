// *
// *	This script handles the frequency for the 152 and backpack radio
// *
// ====================================================================================
	// *	Gear Configurations
	private ["_paramWest","_paramEast","_paramIndep"];
	// Checks if the params are enables in the lobby
	if (("GOL_Params_Faction_West" call BIS_fnc_getParamValue) == 0) then {
		_paramWest = (["Gear", "Blufor"] call GOL_Fnc_GetConfig);
	} else {
		_paramWest = ("GOL_Params_Faction_West" call BIS_fnc_getParamValue);
	};

	if (("GOL_Params_Faction_East" call BIS_fnc_getParamValue) == 0) then {
		_paramEast = (["Gear", "Opfor"] call GOL_Fnc_GetConfig);
	} else {
		_paramEast = ("GOL_Params_Faction_East" call BIS_fnc_getParamValue);
	};

	if (("GOL_Params_Faction_Independent" call BIS_fnc_getParamValue) == 0) then {
		_paramIndep = (["Gear", "Independent"] call GOL_Fnc_GetConfig);
	} else {
		_paramIndep = ("GOL_Params_Faction_Independent" call BIS_fnc_getParamValue);
	};

	//	====================================================================================
	//	SELECTING FROM PARAMETERS IF EXTRA GEAR IS ENABLED
	GOL_Gear_Camo = (["Gear", "Camoflage"] call GOL_Fnc_GetConfig);
	publicVariable "GOL_Gear_Camo";

	GOL_Gear_Extra = false;
	GOL_Gear_Additional = false;
	if (("GOL_Params_Extra_Gear" call BIS_fnc_getParamValue) >= 1) then {
		if (("GOL_Params_Extra_Gear" call BIS_fnc_getParamValue) == 2) then {
			GOL_Gear_Additional = true;
		};
		GOL_Gear_Extra = true;
	};
	publicVariable "GOL_Gear_Extra";
	publicVariable "GOL_Gear_Additional";

	// ================================================================

	switch (_paramWest) do {
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
			GOL_Faction_West = "CSFB";
		};
		default	{
			GOL_Faction_West = "NATO";
		};
	};

	switch (_paramEast) do {
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

	switch (_paramIndep) do {
		case 2:	{
			GOL_Faction_Indep = "PMC";
		};
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

	publicVariable "GOL_Faction_West";
	publicVariable "GOL_Faction_West_Orgi";
	publicVariable "GOL_Faction_East";
	publicVariable "GOL_Faction_East_Orgi";
	publicVariable "GOL_Faction_Indep";
	publicVariable "GOL_Faction_Indep_Orgi";

	// ================================================================

	if (("GOL_Params_FTL_Teleport" call BIS_fnc_getParamValue) == 1) then {
		GOL_Allow_FTL_Teleport = true;
	} else {
		GOL_Allow_FTL_Teleport = false;
	};
	GOL_FTL_Distance_TP = "GOL_Params_Teleport_Distance" call BIS_fnc_getParamValue;

	publicVariable "GOL_Allow_FTL_Teleport";
	publicVariable "GOL_FTL_Distance_TP";
