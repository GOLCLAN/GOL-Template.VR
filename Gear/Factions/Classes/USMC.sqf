
#include "Common.sqf";

_AllowNVG = true;

// ===========================
// WEAPON SELECTION

_weaponCamo = {
	switch (_this select 0) do {
		case 1: {
			_pistol = "CUP_hgun_M9";
			_pistol_mag = "CUP_15Rnd_9x19_M9";
				_secondaryPistol = [];

			_rifle = "CUP_arifle_Mk16_CQC_FG";
			_rifle_mag = "30Rnd_556x45_Stanag";
			_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
				_primaryRifle = ["CUP_optic_Eotech533","acc_pointer_IR","CUP_muzzle_mfsup_SCAR_L"];

			_rifleGL = "CUP_arifle_Mk16_CQC_EGLM";
			_rifleGL_mag = "30Rnd_556x45_Stanag";
			_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
				_primaryRifleGL = ["CUP_optic_Eotech533","acc_pointer_IR","CUP_muzzle_mfsup_SCAR_L"];

			_rifleALT = "CUP_arifle_Mk16_STD";
			_rifleALT_mag = "30Rnd_556x45_Stanag";
			_rifleALT_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
				_primaryRifleALT = ["CUP_optic_Eotech533","acc_pointer_IR","CUP_muzzle_mfsup_SCAR_L"];

			_carbine = "CUP_smg_MP5A5";
			_carbine_mag = "CUP_30Rnd_9x19_MP5";
			_carbine_mag_tr = "CUP_30Rnd_9x19_MP5";
				_primaryCarbine = ["CUP_optic_Eotech533","acc_pointer_IR","CUP_muzzle_mfsup_SCAR_L"];

			_LMG = "CUP_lmg_Mk48_des";
			_LMG_mag = "CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M";
			_LMG_mag_tr = "CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M";
				_primaryLMG = ["CUP_optic_CompM2_Woodland","acc_pointer_IR"];

			// Rifleman AT
			_LAT = "rhs_weap_M136_hedp";
			_LATmag = "rhs_m136_hedp_mag";

			// Rifleman AT
			_MAT = "CUP_launch_Mk153Mod0";
			_MATmag1 = "CUP_SMAW_HEDP_M_N";
			_MATmag2 = "CUP_SMAW_HEAA_M_N";
		};

	    default {
			_pistol = "CUP_hgun_M9";
			_pistol_mag = "CUP_15Rnd_9x19_M9";
				_secondaryPistol = [];

			_rifle = "rhs_weap_m16a4_carryhandle";
			_rifle_mag = "rhs_mag_30Rnd_556x45_M855A1_Stanag";
			_rifle_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
				_primaryRifle = ["rhsusf_acc_eotech_552","GOL_Flashlight_wide"];

			_rifleGL = "rhs_weap_m16a4_carryhandle_M203";
			_rifleGL_mag = "rhs_mag_30Rnd_556x45_M855A1_Stanag";
			_rifleGL_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
				_primaryRifleGL = ["rhsusf_acc_eotech_552","GOL_Flashlight_wide"];

			_rifleALT = "rhs_weap_m16a4_carryhandle_grip_pmag";
			_rifleALT_mag = "rhs_mag_30Rnd_556x45_M855A1_Stanag";
			_rifleALT_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
				_primaryRifleALT = ["rhsusf_acc_eotech_552","GOL_Flashlight_wide"];

			_carbine = "rhs_weap_m4_grip";
			_carbine_mag = "rhs_mag_30Rnd_556x45_M855A1_Stanag";
			_carbine_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
				_primaryCarbine = ["rhsusf_acc_eotech_552","GOL_Flashlight_wide"];

			_LMG = "rhs_weap_m249_pip";
			_LMG_mag = "rhsusf_200Rnd_556x45_soft_pouch";
			_LMG_mag_tr = "rhsusf_200Rnd_556x45_soft_pouch";
				_primaryLMG = ["CUP_optic_CompM2_Woodland","GOL_Flashlight_wide"];

			// Rifleman AT
			_LAT = "rhs_weap_M136_hedp";
			_LATmag = "rhs_m136_hedp_mag";

			// Rifleman AT
			_MAT = "CUP_launch_Mk153Mod0";
			_MATmag1 = "CUP_SMAW_HEDP_M_N";
			_MATmag2 = "CUP_SMAW_HEAA_M_N";
		};
	};
};

// ===========================

// CLOTHES AND UNIFORMS
_camoflage = {
	switch (_this select 0) do {
	    case 1: {
			// Infantry
			_baseHelmet = ["rhsusf_ach_helmet_ucp","rhsusf_ach_helmet_ess_ucp"] call BIS_fnc_selectRandom;
			_baseUniform = ["rhs_uniform_cu_ucp_patchless"] call BIS_fnc_selectRandom;
			_baseVest = ["rhsusf_iotv_ucp_Rifleman","rhsusf_iotv_ucp_Squadleader","rhsusf_iotv_ucp_Teamleader"] call BIS_fnc_selectRandom;
			_baseGlasses = ["G_Combat","G_Shades_Black"] call BIS_fnc_selectRandom;

			// Pilot
			_pilotHelmet = "H_PilotHelmetHeli_B";
			_pilotUniform = "U_B_HeliPilotCoveralls";
			_pilotVest = "V_TacVest_camo";

			// Vehicle Crewman
			_crewHelmet = "rhsusf_ach_bare_wood_headset_ess";
			_crewVest = "rhsusf_iotv_ucp_repair";

			// Backpacks
			_bagRifleman = "rhsusf_assault_eagleaiii_ucp";
			_bagAG = "rhsusf_assault_eagleaiii_ucp_medic";
			_radioAirBackpack = "tf_rt1523g_big";
			_radioBackpack = "tf_rt1523g_big";
		};
	    default {
			// Infantry
			_baseHelmet = ["rhsusf_mich_helmet_marpatwd"] call BIS_fnc_selectRandom;
			_baseUniform = ["rhs_uniform_FROG01_wd"] call BIS_fnc_selectRandom;
			_baseVest = ["rhsusf_spc"] call BIS_fnc_selectRandom;
			_baseGlasses = ["G_Combat","G_Shades_Black"] call BIS_fnc_selectRandom;

			// Pilot
			_pilotHelmet = "H_PilotHelmetHeli_B";
			_pilotUniform = "U_B_HeliPilotCoveralls";
			_pilotVest = "V_TacVest_camo";

			// Vehicle Crewman
			_crewHelmet = "rhsusf_ach_bare_wood_headset_ess";
			_crewVest = "rhsusf_iotv_ocp_repair";

			// Backpacks
			_bagRifleman = "rhsusf_assault_eagleaiii_coy";
			_bagAG = "rhsusf_assault_eagleaiii_coy";
			_radioAirBackpack = "tf_rt1523g_big_bwmod";
			_radioBackpack = "tf_rt1523g_big_bwmod";
		};
	};
};
