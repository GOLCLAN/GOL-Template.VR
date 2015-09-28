/*	================================================================
	AUTHOR: GuzzenVonLidl

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
    case "GOLUS": {			// US West
		EnemyUnits = ["rhsusf_army_ocp_squadleader","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_machinegunnera","rhsusf_army_ocp_machinegunner"];
		EnemySnipers = ["rhsusf_army_ocp_marksman"];
		EnemyAntiAir = ["rhsusf_army_ocp_aa"];
		EnemySide = WEST;
    };
    case "GOLBAF": {		// BAF West R4IDER/Oksman
		EnemyUnits = ["GOL_PL_BAF","GOL_SL_BAF","GOL_RM_BAF","GOL_AG_BAF","GOL_AR_BAF"];
		EnemySnipers = ["GOL_SN_BAF"];
		EnemyAntiAir = ["GOL_AA_BAF"];
		EnemySide = WEST;    };
    case "GOLFIA": {		// FIA West
		EnemyUnits = ["B_G_Soldier_SL_F","B_G_Soldier_TL_F","B_G_Soldier_LAT_F","B_G_Soldier_GL_F","B_G_medic_F","B_G_Soldier_AR_F","B_G_Soldier_A_F"];
		EnemySnipers = ["B_G_Soldier_M_F"];
		EnemyAntiAir = ["GOL_AA_INS"];
		EnemySide = WEST;    };
    case "GOLRU": {			// Russians East
		EnemyUnits = ["rhs_msv_sergeant","rhs_msv_at","rhs_msv_machinegunner_assistant","rhs_msv_machinegunner"];
		EnemySnipers = ["rhs_msv_marksman"];
		EnemyAntiAir = ["rhs_msv_aa"];
		EnemySide = EAST;

    };
    case "GOLINS": {		// Insurgents East R4IDER
		EnemyUnits = ["GOL_PL_INS","GOL_SL_INS","GOL_RM_INS","GOL_AG_INS","GOL_AR_INS","GOL_INS6_INS","GOL_INS7_INS","GOL_INS8_INS","GOL_INS9_INS","GOL_INS10_INS","GOL_INS11_INS","GOL_INS12_INS","GOL_INS13_INS"];
		EnemySnipers = ["GOL_SN_INS","GOL_SN2_INS"];
		EnemyAntiAir = ["GOL_AA_INS"];
		EnemySide = EAST;
    };
    case "GOLINS_W": {		// Insurgents West R4IDER
		EnemyUnits = ["GOL_PL_INS_W","GOL_SL_INS_W","GOL_RM_INS_W","GOL_AG_INS_W","GOL_AR_INS_W","GOL_INS6_INS_W","GOL_INS7_INS_W","GOL_INS8_INS_W","GOL_INS9_INS_W","GOL_INS10_INS_W","GOL_INS11_INS_W","GOL_INS12_INS_W","GOL_INS13_INS_W"];
		EnemySnipers = ["GOL_SN_INS_W","GOL_SN2_INS_W"];
		EnemyAntiAir = ["GOL_AA_INS_W"];
		EnemySide = WEST;
    };
    case "GOLGER": {		// Germans West R4IDER/Oksman
		EnemyUnits = ["GOL_PL_GER","GOL_SL_GER","GOL_RM_GER","GOL_AG_GER","GOL_AR_GER"];
		EnemySnipers = ["GOL_SN_GER"];
		EnemyAntiAir = ["GOL_AA_GER"];
		EnemySide = WEST;
    };
    case "GOLTALI": {		// Taliban East R4IDER/Oksman
		EnemyUnits = ["GOL_PL_TALI","GOL_SL_TALI","GOL_RM_TALI","GOL_AG_TALI","GOL_AR_TALI"];
		EnemySnipers = ["GOL_SN_TALI"];
		EnemyAntiAir = ["GOL_AA_TALI"];
		EnemySide = EAST;
    };
    case "GOLDEN": {		// Royal Danish Army West R4IDER/Oksman
		EnemyUnits = ["GOL_PL_DEN","GOL_SL_DEN","GOL_RM_DEN","GOL_AG_DEN","GOL_AR_DEN"];
		EnemySnipers = ["GOL_SN_DEN"];
		EnemyAntiAir = ["GOL_AA_DEN"];
		EnemySide = WEST;
    };
    case "GOLIDF": {		// Israeli Defence Forces West R4IDER/Oksman
		EnemyUnits = ["GOL_PL_IDF","GOL_SL_IDF","GOL_RM_IDF","GOL_AG_IDF","GOL_AR_IDF"];
		EnemySnipers = ["GOL_SN_IDF"];
		EnemyAntiAir = ["GOL_AA_IDF"];
		EnemySide = WEST;
    };
    case "GOLUKR": {		// Ukrainian Army West R4IDER/Oksman
		EnemyUnits = ["GOL_PL_UKR","GOL_SL_UKR","GOL_RM_UKR","GOL_AG_UKR","GOL_AR_UKR"];
		EnemySnipers = ["GOL_SN_UKR"];
		EnemyAntiAir = ["GOL_AA_UKR"];
		EnemySide = WEST;
    };
    case "GOLTFSPARTAN": {	// USMC TF Spartan West Jason
		EnemyUnits = ["GOL_PL_TFSPARTAN","GOL_SL_TFSPARTAN","GOL_RM_TFSPARTAN","GOL_AG_TFSPARTAN","GOL_AR_TFSPARTAN"];
		EnemySnipers = ["GOL_SN_TFSPARTAN"];
		EnemyAntiAir = ["GOL_AA_TFSPARTAN"];
		EnemySide = WEST;
    };
    case "GOLLoyalists": {	// "Loyalists";
		EnemyUnits = ["GOL_PL_LOYA","GOL_SL_LOYA","GOL_RM_LOYA","GOL_AG_LOYA","GOL_AR_LOYA","GOL_SN_LOYA","GOL_PI_LOYA","GOL_AA_LOYA"];
		EnemySnipers = [""];
		EnemyAntiAir = [""];
		EnemySide = East;
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
