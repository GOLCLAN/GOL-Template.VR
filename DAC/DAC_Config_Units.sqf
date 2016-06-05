//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 2.1 - 2009    //
//--------------------------//
//    DAC_Config_Units      //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private ["_TypNumber","_TempArray","_Unit_Pool_S","_Unit_Pool_V","_Unit_Pool_T","_Unit_Pool_A"];
_TypNumber = _this select 0;
_TempArray = [];

switch (_TypNumber) do {

	//-------------------------------------------------------------------------------------------------
	// OPFOR Faction
	//-------------------------------------------------------------------------------------------------
	case 0: {	//	CSAT
		_Unit_Pool_S = ["O_crew_F","O_Helipilot_F","O_Soldier_SL_F","O_soldier_AR_F","O_soldier_AR_F","O_soldier_exp_F","O_soldier_GL_F","O_soldier_GL_F","O_soldier_M_F","O_medic_F","O_soldier_AA_F","O_soldier_repair_F","O_Soldier_F","O_Soldier_F","O_soldier_LAT_F","O_soldier_LAT_F","O_soldier_lite_F","O_soldier_TL_F","O_soldier_TL_F"];
		_Unit_Pool_V = ["O_Truck_02_covered_F","O_MRAP_02_F","O_MRAP_02_F","O_MRAP_02_hmg_F"];
		_Unit_Pool_T = ["O_MBT_02_arty_F","I_APC_Wheeled_03_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MBT_02_cannon_F","O_APC_Tracked_02_AA_F"];
		_Unit_Pool_A = ["O_Heli_Attack_02_F","O_Heli_Light_02_F","O_Heli_Light_02_armed_F"];
	};

	//-------------------------------------------------------------------------------------------------
	case 1: {	//	CUP Russians
		_Unit_Pool_S = ["CUP_O_RU_Soldier_TL_EMR","CUP_O_RU_Soldier_LAT_EMR","CUP_O_RU_Soldier_MG_EMR","CUP_O_RU_Soldier_AR_EMR","CUP_O_RU_Engineer_EMR","CUP_O_RU_Soldier_Marksman_EMR"];
		_Unit_Pool_V = ["CUP_O_Ural_RU","CUP_O_UAZ_MG_RU","CUP_O_UAZ_METIS_RU","CUP_O_UAZ_SPG9_RU","CUP_O_GAZ_Vodnik_BPPU_RU","CUP_O_GAZ_Vodnik_AGS_RU","CUP_O_GAZ_Vodnik_PK_RU"];
		_Unit_Pool_T = ["CUP_O_BMP2_RU","CUP_O_BMP3_RU","CUP_O_T72_RU"];
		_Unit_Pool_A = ["CUP_O_Mi8_RU","CUP_O_Ka52_RU","CUP_O_Mi24_V_RU"];
	};
	//-------------------------------------------------------------------------------------------------
	case 2: {	//	CUP Chedaki
		_Unit_Pool_S = ["CUP_O_INS_Story_Lopotev","CUP_O_INS_Soldier_AT","CUP_O_INS_Soldier_MG","CUP_O_INS_Soldier_AR","CUP_O_INS_Soldier_AK74","CUP_O_INS_Sniper"];
		_Unit_Pool_V = ["CUP_O_BRDM2_HQ_CHDKZ","CUP_O_BMP_HQ_CHDKZ","CUP_O_Datsun_PK","CUP_O_UAZ_MG_CHDKZ","CUP_O_Ural_CHDKZ","CUP_O_UAZ_SPG9_CHDKZ"];
		_Unit_Pool_T = ["CUP_O_BRDM2_CHDKZ","CUP_O_BMP2_CHDKZ","CUP_O_BRDM2_ATGM_CHDKZ","CUP_O_T72_CHDKZ"];
		_Unit_Pool_A = ["CUP_O_Mi8_CHDKZ","CUP_O_Mi8_medevac_CHDKZ"];
	};

	//-------------------------------------------------------------------------------------------------
	//	BLUFOR Faction
	case 3: {	//	NATO
		_Unit_Pool_S = ["B_crew_F","B_Helipilot_F","B_Soldier_SL_F","B_soldier_AR_F","B_soldier_AR_F","B_soldier_exp_F","B_soldier_GL_F","B_soldier_GL_F","B_soldier_AA_F","B_soldier_M_F","B_medic_F","B_soldier_repair_F","B_Soldier_F","B_Soldier_F","B_soldier_LAT_F","B_soldier_LAT_F","B_soldier_lite_F","B_soldier_TL_F","B_soldier_TL_F"];
		_Unit_Pool_V = ["B_Truck_01_covered_F","B_MRAP_01_F","B_MRAP_01_F","B_MRAP_01_hmg_F"];
		_Unit_Pool_T = ["B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_AA_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_MBT_01_arty_F","B_MBT_01_mlrs_F"];
		_Unit_Pool_A = ["B_Heli_Light_01_armed_F","B_Heli_Transport_01_camo_F","B_Heli_Light_01_F"];
	};
	//-------------------------------------------------------------------------------------------------
	case 4: {	//	CUP US ARMY
		_Unit_Pool_S = ["CUP_B_US_Soldier_AMG","CUP_B_US_Soldier_AR","CUP_B_US_Soldier_MG","CUP_B_US_Soldier_LAT","CUP_B_US_Soldier_SL"];
		_Unit_Pool_V = ["CUP_B_HMMWV_M2_GPK_USA","CUP_B_HMMWV_M2_USA","CUP_B_HMMWV_SOV_USA","CUP_B_HMMWV_MK19_USA","CUP_B_HMMWV_Crows_M2_USA"];
		_Unit_Pool_T = ["CUP_B_M1128_MGS_Desert","CUP_B_M1130_CV_M2_Desert","CUP_B_M1A1_DES_US_Army","CUP_B_M1A2_TUSK_MG_DES_US_Army","CUP_B_M2Bradley_USA_D"];
		_Unit_Pool_A = ["CUP_B_AH6J_Escort_USA","CUP_B_AH64D_USA","CUP_B_UH60L_FFV_US","CUP_B_CH47F_USA"];
	};
	//-------------------------------------------------------------------------------------------------
	case 5: {	//	CUP US Marines
		_Unit_Pool_S = ["CUP_B_USMC_Soldier_AR","CUP_B_USMC_Soldier_TL","CUP_B_USMC_Soldier_MG","CUP_B_USMC_Soldier_LAT","CUP_B_USMC_Soldier","CUP_B_USMC_Soldier_Marksman"];
		_Unit_Pool_V = ["CUP_B_HMMWV_M2_USMC","CUP_B_HMMWV_M1114_USMC","CUP_B_HMMWV_MK19_USMC","CUP_B_RG31_M2_OD_USMC","CUP_B_RG31_Mk19_OD_USMC"];
		_Unit_Pool_T = ["CUP_B_AAV_USMC","CUP_B_LAV25M240_USMC","CUP_B_M1A1_Woodland_USMC","CUP_B_M1A2_TUSK_MG_USMC"];
		_Unit_Pool_A = ["CUP_B_AH1Z_14RndHydra","CUP_B_MH60S_FFV_USMC","CUP_B_UH1Y_GUNSHIP_USMC"];
	};

	//-------------------------------------------------------------------------------------------------
	//	Independent Faction
	//-------------------------------------------------------------------------------------------------

	//-------------------------------------------------------------------------------------------------
	case 6: {	//	AAF
		_Unit_Pool_S = ["I_crew_F","I_helipilot_F","I_officer_F","I_Soldier_AT_F","I_Soldier_AA_F","I_Soldier_M_F","I_Soldier_GL_F","I_Soldier_exp_F","I_engineer_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
		_Unit_Pool_V = ["I_Truck_02_covered_F","I_Truck_02_transport_F","I_MRAP_03_hmg_F","I_MRAP_03_F","I_MRAP_03_F"];
		_Unit_Pool_T = ["I_MBT_03_cannon_F","I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F"];
		_Unit_Pool_A = ["I_Heli_light_03_F"];
	};
	//-------------------------------------------------------------------------------------------------
	case 7: {	//	NAPA
		_Unit_Pool_S = ["CUP_I_GUE_Soldier_AR","CUP_I_GUE_Ammobearer","CUP_I_GUE_Officer","CUP_I_GUE_Soldier_AT","CUP_I_GUE_Commander","CUP_I_GUE_Soldier_MG","CUP_I_GUE_Gamekeeper"];
		_Unit_Pool_V = ["CUP_I_Datsun_PK","CUP_I_BRDM2_NAPA","CUP_I_BMP_HQ_NAPA","CUP_I_BRDM2_HQ_NAPA"];
		_Unit_Pool_T = ["CUP_I_T34_NAPA","CUP_I_T72_NAPA","CUP_I_Ural_ZU23_NAPA"];
		_Unit_Pool_A = [];
	};

	//-------------------------------------------------------------------------------------------------
	//	CIVILIAN Faction
	//-------------------------------------------------------------------------------------------------
	case 8: {	//	Civilians
		_Unit_Pool_S = ["C_man_1","C_man_1","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F"];
		_Unit_Pool_V = ["C_Van_01_box_F","C_Van_01_transport_F","C_Offroad_01_F","C_Hatchback_01_sport_F","C_Hatchback_01_F"];
		_Unit_Pool_T = ["C_Van_01_box_F","C_Van_01_transport_F","C_Offroad_01_F","C_Hatchback_01_sport_F","C_Hatchback_01_F"];
		_Unit_Pool_A = [];
	};
	//-------------------------------------------------------------------------------------------------

	Default {
		if(DAC_Basic_Value != 5) then {
			DAC_Basic_Value = 5;
			publicvariable "DAC_Basic_Value",
			hintc "Error: DAC_Config_Units > No valid config number";
		};
		if(true) exitwith {};
	};
};

if(count _this == 2) then {
	_TempArray = _TempArray + [_Unit_Pool_S,_Unit_Pool_V,_Unit_Pool_T,_Unit_Pool_A];
} else {
	_TempArray = _Unit_Pool_V + _Unit_Pool_T + _Unit_Pool_A;
};
_TempArray
