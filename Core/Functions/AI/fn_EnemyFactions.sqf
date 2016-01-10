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
		EnemyUnits = ["rhsusf_army_ocp_squadleader","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_machinegunnera","rhsusf_army_ocp_machinegunner"];
		EnemySnipers = ["rhsusf_army_ocp_marksman"];
		EnemyAntiAir = ["rhsusf_army_ocp_aa"];
		EnemySide = WEST;
    };
 
    case "GOLUSMC": {			// USMC West
		EnemyUnits = ["rhsusf_usmc_marpat_wd_teamleader","rhsusf_usmc_marpat_wd_riflemanat","rhsusf_usmc_marpat_wd_machinegunner_ass","rhsusf_usmc_marpat_wd_machinegunner"];
		EnemySnipers = ["rhsusf_usmc_marpat_wd_marksman"];
		EnemyAntiAir = ["rhsusf_usmc_marpat_wd_stinger"];
		EnemySide = WEST;
    };  
    
    case "GOLANA": {			// Leighs OPFOR Pack - Afghan National Army
		EnemyUnits = ["LOP_AA_Infantry_TL","LOP_AA_Infantry_AT","LOP_AA_Infantry_MG_Asst","LOP_AA_Infantry_MG"];
		EnemySnipers = ["LOP_AA_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_AA_Infantry_AT"];
		EnemySide = WEST;
    };   

    case "GOLCDF": {			// Leighs OPFOR Pack - Chernarussian Defense Force
		EnemyUnits = ["LOP_CDF_Infantry_SL","LOP_CDF_Infantry_AT","LOP_CDF_Infantry_MG_Asst","LOP_CDF_Infantry_MG"];
		EnemySnipers = ["LOP_CDF_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_CDF_Infantry_AA"];
		EnemySide = WEST;
    };   
 
     case "GOLIRAQ": {			// Leighs OPFOR Pack - Iraqi Forces
		EnemyUnits = ["LOP_IA_Infantry_SL","LOP_IA_Infantry_AT","LOP_IA_Infantry_MG_Asst","LOP_IA_Infantry_MG"];
		EnemySnipers = ["LOP_IA_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_IA_Infantry_AT"];
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
	
    case "GOLRU": {			// Russians East
		EnemyUnits = ["rhs_msv_sergeant","rhs_msv_at","rhs_msv_machinegunner_assistant","rhs_msv_machinegunner"];
		EnemySnipers = ["rhs_msv_marksman"];
		EnemyAntiAir = ["rhs_msv_aa"];
		EnemySide = EAST;
    };

    case "GOLCHEDAKI": {			// Leighs OPFOR Pack - Chedaki
		EnemyUnits = ["LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_MG"];
		EnemySnipers = ["LOP_ChDKZ_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_ChDKZ_Infantry_AT"];
		EnemySide = EAST;
    };    
    
    case "GOLSLA": {			// Leighs OPFOR Pack - SLA
		EnemyUnits = ["LOP_SLA_Infantry_SL","LOP_SLA_Infantry_AT","LOP_SLA_Infantry_Rifleman","LOP_SLA_Infantry_MG"];
		EnemySnipers = ["LOP_SLA_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_SLA_Infantry_AA"];
		EnemySide = EAST;
    };    

    case "GOLTKA": {			// Leighs OPFOR Pack - TKA
		EnemyUnits = ["LOP_TKA_Infantry_SL","LOP_TKA_Infantry_AT","LOP_TKA_Infantry_Rifleman","LOP_TKA_Infantry_MG"];
		EnemySnipers = ["LOP_TKA_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_TKA_Infantry_AA"];
		EnemySide = EAST;
    };    

    case "GOLNOVO": {			// Leighs OPFOR Pack - Novorussian Forces
		EnemyUnits = ["LOP_US_Infantry_SL","LOP_US_Infantry_AT","LOP_US_Infantry_Rifleman","LOP_US_Infantry_MG"];
		EnemySnipers = ["LOP_US_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_US_Infantry_AA"];
		EnemySide = EAST;
    };    

    case "GOLCSAT": {			// CSAT Vanilla
		EnemyUnits = ["O_Soldier_AR_F","O_Soldier_AR_F","O_Soldier_F","O_Soldier_AR_F"];
		EnemySnipers = ["O_soldier_M_F"];
		EnemyAntiAir = ["LOP_US_Infantry_AA"];
		EnemySide = EAST;
    };    

//// Resistance/Independent Factions

    case "GOLNAPA": {			// Leighs OPFOR Pack - NAPA
		EnemyUnits = ["LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AR"];
		EnemySnipers = ["LOP_NAPA_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_NAPA_Infantry_AT"];
		EnemySide = RESISTANCE;
    };

    case "GOLEASTERN": {			// RHS - Eastern Militia
		EnemyUnits = ["rhs_g_Soldier_SL_F","rhs_g_Soldier_AT_F","rhs_g_Soldier_F3","rhs_g_Soldier_AR_F"];
		EnemySnipers = ["rhs_g_Soldier_M_F"];
		EnemyAntiAir = ["rhs_g_Soldier_AA_F"];
		EnemySide = RESISTANCE;
    };

    case "GOLAFRICAN": {			// Leighs OPFOR Pack - African Militia
		EnemyUnits = ["LOP_AFR_Infantry_SL","LOP_AFR_Infantry_AT","LOP_AFR_Infantry_Rifleman","LOP_AFR_Infantry_AR"];
		EnemySnipers = ["LOP_AFR_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_AFR_Infantry_AT"];
		EnemySide = RESISTANCE;
    };

    case "GOLAFGHAN": {			// Leighs OPFOR Pack - Afghan Militia / Insurgents
		EnemyUnits = ["LOP_AM_Infantry_SL","LOP_AM_Infantry_AT","LOP_AM_Infantry_Rifleman","LOP_AM_Infantry_AR"];
		EnemySnipers = ["LOP_AM_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_AM_Infantry_AT"];
		EnemySide = RESISTANCE;
    };

    case "GOLISIL": {			// Leighs OPFOR Pack - ISIL
		EnemyUnits = ["LOP_ISTS_Infantry_SL","LOP_ISTS_Infantry_AT","LOP_ISTS_Infantry_Rifleman","LOP_ISTS_Infantry_AR"];
		EnemySnipers = ["LOP_ISTS_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_ISTS_Infantry_AT"];
		EnemySide = RESISTANCE;
    };

    case "GOLPMC": {			// Leighs OPFOR Pack - ISIL
		EnemyUnits = ["LOP_PMC_Infantry_SL","LOP_PMC_Infantry_AT","LOP_PMC_Infantry_Rifleman","LOP_PMC_Infantry_MG"];
		EnemySnipers = ["LOP_PMC_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_PMC_Infantry_AT"];
		EnemySide = RESISTANCE;
    };

    case "GOLRACS": {			// Leighs OPFOR Pack - RACS
		EnemyUnits = ["LOP_RACS_Infantry_SL","LOP_RACS_Infantry_AT","LOP_RACS_Infantry_Rifleman","LOP_RACS_Infantry_MG"];
		EnemySnipers = ["LOP_RACS_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_RACS_Infantry_AT"];
		EnemySide = RESISTANCE;
    };

    case "GOLUN": {			// Leighs OPFOR Pack - United Nations
		EnemyUnits = ["LOP_UN_Infantry_SL","LOP_UN_Infantry_AT","LOP_UN_Infantry_Rifleman","LOP_UN_Infantry_MG"];
		EnemySnipers = ["LOP_UN_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_UN_Infantry_AA"];
		EnemySide = RESISTANCE;
    };

    case "GOLULTRA": {			// Leighs OPFOR Pack - Ultranationalists
		EnemyUnits = ["LOP_UA_Infantry_SL","LOP_UA_Infantry_AT","LOP_UA_Infantry_Rifleman","LOP_UA_Infantry_MG"];
		EnemySnipers = ["LOP_UA_Infantry_Marksman"];
		EnemyAntiAir = ["LOP_UA_Infantry_AT"];
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
