// ================================================================
// *	Defined Factions:
// *
// *	West Factions
// *	w_nato		-	Nato
// *	w_fia		-	FIA
// *	w_us		-	US Army
// *	w_baf		-	BAF
// *	w_ger		-	Germans
// *	w_den		-	Danish
// *	w_idf		-	Independent Federation
// *	w_ukr		-	Ukrainians
// *	w_ins		-	Insurgets
// *
// *	East Factions
// *	e_csat		-	CSAT
// *	e_russian	-	Terrorist
// *	e_ins		-	Insurgents
// *	e_taki	-	Takiban
// *
// *	Independent Factions
// *	i_aaf		-	AAF
// *
// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Selects what faction will be used for spawning ai units.
// *
// *	Usage:
// *		["w_nato"] call GVL_Fnc_Ai_Init;
// *
// *	Parameters:
// *		0:	String:	Faction that will spawn
// *
// *	Returning Value:
// *		None
// *
// ================================================================

if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs after and not players

private ["_faction"];

if (time == 0) then {
	_faction = ["Default_AI"] call GVL_Fnc_GetConfig;
} else {
	_faction = toLower ([_this, 0, ["Default_AI"] call GVL_Fnc_GetConfig, [""]] call BIS_fnc_param);
};

if (isNil "GVL_AI_Faction_Mission") then {
	GVL_AI_Faction_Mission = _faction;
	publicVariable "GVL_AI_Faction_Mission";
};

if (isNil "GVL_AI_Faction_Mission_Default") then {
	GVL_AI_Faction_Mission_Default = GVL_AI_Faction_Mission;
	publicVariable "GVL_AI_Faction_Mission_Default";
};
if (isNil "_faction") then {
	_faction = GVL_AI_Faction_Mission_Default;
};

switch (_faction) do {

	// ================================================================
	// *	The "IF" Statements should not be edited under any circumstances
	// *	West Factions

	GVL_AI_NATO 		=	["B_Soldier_TL_F","B_Soldier_F","B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F"];
	GVL_AI_FIA			=	["B_G_Soldier_TL_F","B_G_Soldier_F","B_G_Soldier_LAT_F","B_G_Soldier_GL_F","B_G_medic_F","B_G_Soldier_AR_F"];
	GVL_AI_RHS_USArmy 	=	["rhsusf_army_ocp_squadleader","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_medic","rhsusf_army_ocp_machinegunner"];
	GVL_AI_BAF			=	["GOL_SL_BAF","GOL_RM_BAF","GOL_RM_BAF","GOL_AG_BAF","GOL_AR_BAF"];
	GVL_AI_GER			=	["GOL_SL_GER","GOL_RM_GER","GOL_RM_GER","GOL_AG_GER","GOL_AR_GER"];
	GVL_AI_DEN			=	["GOL_SL_DEN","GOL_RM_DEN","GOL_RM_DEN","GOL_AG_DEN","GOL_AR_DEN"];
	GVL_AI_IDF			=	["GOL_SL_IDF","GOL_RM_IDF","GOL_RM_IDF","GOL_AG_IDF","GOL_AR_IDF"];
	GVL_AI_UKR			=	["GOL_SL_UKR","GOL_RM_UKR","GOL_RM_UKR","GOL_AG_UKR","GOL_AR_UKR"];
	GVL_AI_INS_West 	=	["GOL_SL_INS_W","GOL_RM_INS_W","GOL_AG_INS_W","GOL_AR_INS_W"];

	case "w_nato":		{	GVL_AI_Side = West;			GVL_AI_Faction = GVL_AI_NATO; };
	case "w_fia":		{	GVL_AI_Side = West;			GVL_AI_Faction = GVL_AI_FIA; };
	case "w_us":		{	GVL_AI_Side = West;			GVL_AI_Faction = GVL_AI_RHS_USArmy; };
	case "w_baf":		{	GVL_AI_Side = West;			GVL_AI_Faction = GVL_AI_BAF; };
	case "w_ger":		{	GVL_AI_Side = West;			GVL_AI_Faction = GVL_AI_GER; };
	case "w_den":		{	GVL_AI_Side = West;			GVL_AI_Faction = GVL_AI_DEN; };
	case "w_idf":		{	GVL_AI_Side = West;			GVL_AI_Faction = GVL_AI_IDF; };
	case "w_ukr":		{	GVL_AI_Side = West;			GVL_AI_Faction = GVL_AI_UKR; };
	case "w_ins":		{	GVL_AI_Side = West;			GVL_AI_Faction = GVL_AI_INS_West; };

	// ==================================
	// *	East Factions

	GVL_AI_CSAT			=		["O_Soldier_TL_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F"];
	GVL_AI_RHS_Russian	=		["rhs_msv_sergeant","rhs_msv_rifleman","rhs_msv_rifleman","rhs_msv_at","rhs_msv_grenadier","rhs_msv_machinegunner"];
	GVL_AI_INS_EAST		=		["GOL_SL_INS","GOL_RM_INS","GOL_AG_INS","GOL_AR_INS"];
	GVL_AI_TAKI			=		["GOL_SL_TALI","GOL_RM_TALI","GOL_AG_TALI","GOL_AR_TALI"];

	case "e_csat":		{	GVL_AI_Side = East;			GVL_AI_Faction = GVL_AI_CSAT; };
	case "e_russian":	{	GVL_AI_Side = East;			GVL_AI_Faction = GVL_AI_RHS_Russian; };
	case "e_ins":		{	GVL_AI_Side = East;			GVL_AI_Faction = GVL_AI_INS_EAST; };
	case "e_taki":		{	GVL_AI_Side = East;			GVL_AI_Faction = GVL_AI_TAKI; };

	// ==================================
	// *	Independent Factions

	GVL_AI_AAF 			= 	["I_Soldier_TL_F","I_soldier_F","I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F"];
	GVL_AI_INS_INDEP 	= 	["rhs_g_Soldier_TL_F","rhs_g_Soldier_lite_F","rhs_g_Soldier_LAT_F","rhs_g_Soldier_F3","rhs_g_Soldier_AR_F","rhs_g_Soldier_GL_F","rhs_g_Soldier_F2"];

	case "i_aaf":		{	GVL_AI_Side = Independent;	GVL_AI_Faction = GVL_AI_AAF; };
	case "i_ins":		{	GVL_AI_Side = Independent;	GVL_AI_Faction = GVL_AI_INS_INDEP; };

	// ================================================================
	// *	If there is any error in "GVL_AI_Faction_Mission" then this faction will be loaded as a default
	default {
		[GVL_AI_Faction_Mission_Default] call GVL_Fnc_Ai_Init;
		_DebugName = "AI-Init";
		scriptName _DebugName;
		["Error with GVL_AI_Faction_Mission",[_DebugName,__FILE__,__LINE__],"log"] call GVL_Fnc_DebugLog;
	};

};

publicVariable "GVL_AI_Faction";
publicVariable "GVL_AI_Side";
publicVariable "GVL_AI_Faction_Mission";
publicVariable "GVL_AI_Faction_Mission_Default";
