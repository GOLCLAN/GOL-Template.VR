#include "Common.sqf"
_AllowNVG = true;
_factionValue = false;
_factionScript = "Default";
pmcammo = false;

// ===========================
switch (GOL_Gear_Camo) do {
	case 1: {	// Desert
		// WEAPON SELECTION
		_pistol = "CUP_hgun_M9";
		_pistol_mag = "CUP_15Rnd_9x19_M9";
		_secondaryPistol = [];

		_rifle = "arifle_SPAR_01_blk_F";
		_rifle_mag = "30Rnd_556x45_Stanag";
		_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
		_primaryRifle = ["CUP_optic_Eotech533","GVL_X2000_point","CUP_muzzle_mfsup_SCAR_L"];

		_rifleGL = "arifle_SPAR_01_GL_blk_F";
		_rifleGL_mag = "30Rnd_556x45_Stanag";
		_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
		_primaryRifleGL = ["CUP_optic_Eotech533","GVL_X2000_point","CUP_muzzle_mfsup_SCAR_L"];

		_rifleALT = "CUP_arifle_Mk16_STD";
		_rifleALT_mag = "30Rnd_556x45_Stanag";
		_rifleALT_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
		_primaryRifleALT = ["CUP_optic_Eotech533","GVL_X2000_point","CUP_muzzle_mfsup_SCAR_L"];

		_carbine = "CUP_smg_MP5A5";
		_carbine_mag = "CUP_30Rnd_9x19_MP5";
		_carbine_mag_tr = "CUP_30Rnd_9x19_MP5";
		_primaryCarbine = ["CUP_optic_Eotech533","GVL_X2000_point","CUP_muzzle_mfsup_SCAR_L"];

		_LMG = "CUP_lmg_Mk48_des";
		_LMG_mag = "CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M";
		_LMG_mag_tr = "CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M";
		_primaryLMG = ["CUP_optic_CompM2_Woodland","GVL_X2000_point"];

		// Rifleman AT
		_LAT = "tf47_at4_HP";
		_LATmag = "";

		// Rifleman AT
		_MAT = "CUP_launch_Mk153Mod0";
		_MATmag1 = "CUP_SMAW_HEDP_M_N";
		_MATmag2 = "CUP_SMAW_HEAA_M_N";

		// ===========================

		// Infantry
		_baseHelmet = ["CUP_H_USArmy_HelmetMICH_earpro_ess","CUP_H_USArmy_HelmetMICH_earpro"] call BIS_fnc_selectRandom;
		_baseUniform = ["CUP_U_B_USArmy_TwoKnee","CUP_U_B_USArmy_Base"] call BIS_fnc_selectRandom;
		_baseVest = ["CUP_V_B_IOTV_MG","CUP_V_B_IOTV_AT","CUP_V_B_IOTV_AT"] call BIS_fnc_selectRandom;
		_baseGlasses = [nil] call BIS_fnc_selectRandom;

		// Echo Helo
		_pilotHelmet = "H_PilotHelmetHeli_O";
		_pilotUniform = "U_I_pilotCoveralls";
		_pilotVest = "V_TacVest_oli";

		// Echo Ground
		_pilotHelmetG = "H_PilotHelmetHeli_B";
		_pilotUniformG = ["CUP_U_B_USArmy_TwoKnee","CUP_U_B_USArmy_Base"] call BIS_fnc_selectRandom;
		_pilotVestG = "V_TacVest_oli";

		// Echo Plane
		_pilotHelmetP = "H_PilotHelmetFighter_B";
		_pilotUniformP = "U_B_PilotCoveralls";
		_pilotVestP = "V_TacVest_oli";

		// Backpacks
		_bagRifleman = "CUP_B_MedicPack_ACU";
		_bagAG = "CUP_B_USPack_Coyote";
		_radioAirBackpack = "tf_rt1523g_big";
		_radioBackpack = "tf_anprc155_coyote";
		_bagPilot = "B_Parachute";

	};

	default {	// Woodland
		
		// WEAPON SELECTION
		_pistol = "CUP_hgun_M9";
		_pistol_mag = "CUP_15Rnd_9x19_M9";
		_secondaryPistol = [];

		_rifle = "CUP_arifle_M16A4_Base";
		_rifle_mag = "30Rnd_556x45_Stanag";
		_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
			_primaryRifle = ["FHQ_optic_AIM","GVL_X2000_point"];

		_rifleGL = "CUP_arifle_M16A4_GL";
		_rifleGL_mag = "30Rnd_556x45_Stanag";
		_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
			_primaryRifleGL = ["FHQ_optic_AIM","GVL_X2000_point"];

		_rifleALT = "CUP_arifle_M16A2";
		_rifleALT_mag = "30Rnd_556x45_Stanag";
		_rifleALT_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
			_primaryRifleALT = ["FHQ_optic_AIM","GVL_X2000_point"];

		_carbine = "CUP_arifle_M4A1_black";
		_carbine_mag = "30Rnd_556x45_Stanag";
		_carbine_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
			_primaryCarbine = ["FHQ_optic_AIM","GVL_X2000_point"];

		_LMG = "CUP_lmg_m249_pip1";
		_LMG_mag = "CUP_200Rnd_TE1_Red_Tracer_556x45_M249";
		_LMG_mag_tr = "CUP_200Rnd_TE1_Red_Tracer_556x45_M249";
			_primaryLMG = ["FHQ_optic_AIM","GVL_X2000_point"];

		// Rifleman AT
		_LAT = "tf47_at4_HP";
		_LATmag = "";

		// Rifleman AT
		_MAT = "CUP_launch_Mk153Mod0";
		_MATmag1 = "CUP_SMAW_HEDP_M_N";
		_MATmag2 = "CUP_SMAW_HEAA_M_N";

		// ===========================
		// Infantry
		_baseHelmet = ["CUP_H_USMC_Headset_HelmetWDL","CUP_H_USMC_Headset_GoggleW_HelmetWDL","CUP_H_USMC_HelmetWDL"] call BIS_fnc_selectRandom;
		_baseUniform = ["CUP_U_B_FR_DirAction","CUP_U_B_FR_DirAction2"] call BIS_fnc_selectRandom;
		_baseVest = ["CUP_V_B_MTV_noCB","CUP_V_B_MTV_Marksman"] call BIS_fnc_selectRandom;
		_baseGlasses = [nil] call BIS_fnc_selectRandom;

		// Echo Helo
		_pilotHelmet = "H_PilotHelmetHeli_O";
		_pilotUniform = "U_I_pilotCoveralls";
		_pilotVest = "V_TacVest_oli";

		// Echo Ground
		_pilotHelmetG = "H_PilotHelmetHeli_B";
		_pilotUniformG = ["CUP_U_B_FR_DirAction","CUP_U_B_FR_DirAction2"] call BIS_fnc_selectRandom;
		_pilotVestG = "V_TacVest_oli";

		// Echo Plane
		_pilotHelmetP = "H_PilotHelmetFighter_B";
		_pilotUniformP = "U_B_PilotCoveralls";
		_pilotVestP = "V_TacVest_oli";

		// Backpacks
		_bagRifleman = "B_Kitbag_mcamo";
		_bagAG = "B_Carryall_cbr";
		_radioAirBackpack = "tf_rt1523g_big_bwmod";
		_radioBackpack = "tf_anprc155_coyote";
		_bagPilot = "B_Parachute";
	};
};
