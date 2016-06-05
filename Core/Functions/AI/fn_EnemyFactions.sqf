/*	================================================================
	AUTHOR: GuzzenVonLidl - Edit by Oksman

	Description:
		Selects a new faction to spawn

	Usage:
		["GOLFIA"] call GOL_Fnc_EnemyFactions;

	Parameters:
		#0:	STRING - Name of the faction to select

	Returning Value:
		Nothing

// ================================================================ */

if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs after and not players

_faction = toUpper ([_this, 0, (["AI_Faction"] call GOL_Fnc_GetConfig), [""]] call bis_fnc_param);

CivilianUnits = ["GOL_CHRIS_CIV","GOL_BARON_CIV","GOL_GUZZENVONLIDL_CIV","GOL_HOOFED_CIV","GOL_MACGREGOR_CIV","GOL_OKSMAN_CIV","GOL_PIRATE_CIV","GOL_R4IDER_CIV","GOL_YORKIEKEV_CIV","GOL_PILGRIM_CIV","GOL_BOG_CIV","GOL_THECMASTER_CIV","GOL_PRESS_CIV","CAF_AG_ME_CIV","CAF_AG_ME_CIV_02","CAF_AG_ME_CIV_03","CAF_AG_ME_CIV_04","C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F"];

switch (_faction) do {

//// Western Factions

    case "GOLUS": {			// US West Army
		EnemyUnits = ["CUP_B_US_Soldier_AMG","CUP_B_US_Soldier_AR","CUP_B_US_Soldier_MG","CUP_B_US_Soldier_LAT","CUP_B_US_Soldier_SL"];
		EnemySnipers = ["CUP_B_US_Soldier_Marksman"];
		EnemyAntiAir = ["CUP_B_US_Soldier_AA"];
		EnemySide = WEST;
    };
 
    case "GOLUSMC": {			// CUP USMC West
		EnemyUnits = ["CUP_B_USMC_Soldier_AR","CUP_B_USMC_Soldier_TL","CUP_B_USMC_Soldier_MG","CUP_B_USMC_Soldier_LAT","CUP_B_USMC_Soldier"];
		EnemySnipers = ["CUP_B_USMC_Soldier_Marksman"];
		EnemyAntiAir = ["CUP_B_USMC_Soldier_AA"];
		EnemySide = WEST;
    };  

    case "GOLFIA": {		// FIA West
		EnemyUnits = ["B_G_Soldier_SL_F","B_G_Soldier_TL_F","B_G_Soldier_LAT_F","B_G_Soldier_F","B_G_Soldier_AR_F","B_G_Soldier_A_F"];
		EnemySnipers = ["B_G_Soldier_M_F"];
		EnemyAntiAir = ["B_G_Soldier_LAT_F"];
		EnemySide = WEST;  
    };	

    case "GOLNATO": {		// NATO West
		EnemyUnits = ["B_Soldier_SL_F","B_soldier_LAT_F","B_Soldier_A_F","B_soldier_AR_F"];
		EnemySnipers = ["B_soldier_M_F"];
		EnemyAntiAir = ["B_soldier_AA_F"];
		EnemySide = WEST;  
    };	

//// Eastern Factions
	
    case "GOLRU": {			// CUP Russians East
		EnemyUnits = ["CUP_O_RU_Soldier_TL_EMR","CUP_O_RU_Soldier_LAT_EMR","CUP_O_RU_Soldier_MG_EMR","CUP_O_RU_Soldier_AR_EMR","CUP_O_RU_Engineer_EMR"];
		EnemySnipers = ["CUP_O_RU_Soldier_Marksman_EMR"];
		EnemyAntiAir = ["CUP_O_RU_Soldier_AA_EMR"];
		EnemySide = EAST;
    };

    case "GOLCHEDAKI": {			// CUP - Chedaki
		EnemyUnits = ["CUP_O_INS_Story_Lopotev","CUP_O_INS_Soldier_AT","CUP_O_INS_Soldier_MG","CUP_O_INS_Soldier_AR","CUP_O_INS_Soldier_AK74"];
		EnemySnipers = ["CUP_O_INS_Sniper"];
		EnemyAntiAir = ["CUP_O_INS_Soldier_AA"];
		EnemySide = EAST;
    };    
    
    case "GOLSLA": {			// CUP SLA
		EnemyUnits = ["CUP_O_sla_Soldier_AMG","CUP_O_sla_Soldier_AR","CUP_O_sla_Soldier_HAT","CUP_O_sla_Soldier_MG","CUP_O_sla_Soldier_AT","CUP_O_sla_Soldier_SL"];
		EnemySnipers = ["CUP_O_sla_Sniper"];
		EnemyAntiAir = ["CUP_O_sla_Soldier_AA"];
		EnemySide = EAST;
    };    

    case "GOLTKA": {			// CUP -TKA
		EnemyUnits = ["CUP_O_TK_Soldier_SL","CUP_O_TK_Soldier_AMG","CUP_O_TK_Soldier_HAT","CUP_O_TK_Soldier_AR","CUP_O_TK_Soldier_AT"];
		EnemySnipers = ["CUP_O_TK_Sniper"];
		EnemyAntiAir = ["CUP_O_TK_Soldier_AA"];
		EnemySide = EAST;
    };    

    case "GOLTKM": {			// CUP - Takistani Militia
		EnemyUnits = ["CUP_O_TK_INS_Soldier_AR","CUP_O_TK_INS_Soldier_MG","CUP_O_TK_INS_Commander","CUP_O_TK_INS_Soldier_AAT","CUP_O_TK_INS_Soldier_AT"];
		EnemySnipers = ["CUP_O_TK_INS_Sniper"];
		EnemyAntiAir = ["CUP_O_TK_INS_Soldier_AA"];
		EnemySide = EAST;
    };    

    case "GOLCSAT": {			// CSAT Vanilla
		EnemyUnits = ["O_Soldier_AR_F","O_Soldier_AR_F","O_Soldier_F","O_Soldier_AR_F"];
		EnemySnipers = ["O_soldier_M_F"];
		EnemyAntiAir = ["LOP_US_Infantry_AA"];
		EnemySide = EAST;
    };

    case "GOLFIAE": {		// FIA East
		EnemyUnits = ["O_G_Soldier_SL_F","O_G_Soldier_TL_F","O_G_Soldier_LAT_F","O_G_Soldier_F","O_G_Soldier_AR_F","O_G_Soldier_A_F"];
		EnemySnipers = ["O_G_Soldier_M_F"];
		EnemyAntiAir = ["O_G_Soldier_LAT_F"];
		EnemySide = EAST;  
    };		

//// Resistance/Independent Factions

    case "GOLNAPA": {			// Leighs OPFOR Pack - NAPA
		EnemyUnits = ["CUP_I_GUE_Soldier_AR","CUP_I_GUE_Ammobearer","CUP_I_GUE_Officer","CUP_I_GUE_Soldier_AT","CUP_I_GUE_Commander","CUP_I_GUE_Soldier_MG"];
		EnemySnipers = ["CUP_I_GUE_Gamekeeper"];
		EnemyAntiAir = ["CUP_I_GUE_Soldier_AA"];
		EnemySide = RESISTANCE;
    };

    case "GOLTKL": {			// CUP - Takistani Locals
		EnemyUnits = ["CUP_I_TK_GUE_Soldier_AR","CUP_I_TK_GUE_Soldier_M16A2","CUP_I_TK_GUE_Soldier_MG","CUP_I_TK_GUE_Soldier_TL"];
		EnemySnipers = ["CUP_I_TK_GUE_Sniper"];
		EnemyAntiAir = ["CUP_I_TK_GUE_Soldier_AA"];
		EnemySide = RESISTANCE;
    };

    case "GOLPMC": {			// CUP - PMC
		EnemyUnits = ["CUP_I_PMC_Soldier_TL","CUP_I_PMC_Soldier_MG","CUP_I_PMC_Soldier","CUP_I_PMC_Soldier_M4A3","CUP_I_PMC_Engineer"];
		EnemySnipers = ["CUP_I_PMC_Sniper"];
		EnemyAntiAir = ["CUP_I_PMC_Soldier_AA"];
		EnemySide = RESISTANCE;
    };

    case "GOLRACS": {			// CUP - RACS
		EnemyUnits = ["CUP_I_RACS_Soldier_MAT","CUP_I_RACS_SL","CUP_I_RACS_RoyalGuard","CUP_I_RACS_MMG"];
		EnemySnipers = ["CUP_I_RACS_Sniper"];
		EnemyAntiAir = ["CUP_I_RACS_Soldier_AA"];
		EnemySide = RESISTANCE;
    };

    case "GOLUN": {			// CUP - United Nations
		EnemyUnits = ["CUP_I_UN_CDF_Soldier_SL","CUP_I_UN_CDF_Soldier_AMG","CUP_I_UN_CDF_Soldier_Backpack","CUP_I_UN_CDF_Soldier_AT","CUP_I_UN_CDF_Soldier","CUP_I_UN_CDF_Soldier_MG"];
		EnemySnipers = ["CUP_I_UN_CDF_Soldier_MG"];
		EnemyAntiAir = ["CUP_I_UN_CDF_Soldier_AT"];
		EnemySide = RESISTANCE;
    };

    case "GOLAAF": {			// Altis Armed Forces - Vanilla
		EnemyUnits = ["I_Soldier_TL_F","I_Soldier_LAT_F","I_Soldier_A_F","I_Soldier_AR_F"];
		EnemySnipers = ["I_Soldier_M_F"];
		EnemyAntiAir = ["I_Soldier_AA_F"];
		EnemySide = RESISTANCE;
    };

	// *	If there is any error with it then GOLFIA will be loaded as a default
	default {
		["GOLFIA"] call GOL_Fnc_EnemyFactions;
		_DebugName = "AI-Init";
		scriptName _DebugName;
		["Error with GOL_Fnc_EnemyFactions",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
	};

};

publicVariable "EnemyUnits";
publicVariable "EnemySnipers";
publicVariable "EnemyAntiAir";
publicVariable "EnemySide";
publicVariable "CivilianUnits";