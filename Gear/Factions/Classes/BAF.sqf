
#include "Common.sqf";

_AllowNVG = true;

// ===========================
// WEAPON SELECTION

_weaponCamo = {
	switch (_this select 0) do {
	    default {
			_pistol = "CUP_hgun_Colt1911";
			_pistol_mag = "CUP_7Rnd_45ACP_1911";
				_secondaryPistol = [];

			_rifle = "CUP_arifle_L85A2";
			_rifle_mag = "CUP_30Rnd_556x45_Stanag";
			_rifle_mag_tr = "CUP_30Rnd_556x45_Stanag";
				_primaryRifle = ["CUP_optic_Eotech533","GVL_X2000_point"];

			_rifleGL = "CUP_arifle_L85A2_GL";
			_rifleGL_mag = "CUP_30Rnd_556x45_Stanag";
			_rifleGL_mag_tr = "CUP_30Rnd_556x45_Stanag";
				_primaryRifleGL = ["CUP_optic_Eotech533","GVL_X2000_point"];

			_rifleALT = "CUP_arifle_L86A2";
			_rifleALT_mag = "CUP_30Rnd_556x45_Stanag";
			_rifleALT_mag_tr = "CUP_30Rnd_556x45_Stanag";
				_primaryRifleALT = ["CUP_optic_Eotech533","GVL_X2000_point"];

			_carbine = "CUP_arifle_L85A2";
			_carbine_mag = "CUP_30Rnd_556x45_Stanag";
			_carbine_mag_tr = "CUP_30Rnd_55645_Stanag";
				_primaryCarbine = ["CUP_optic_Eotech533","GVL_X2000_point"];

			_LMG = "CUP_lmg_M249_para";
			_LMG_mag = "CUP_200Rnd_TE4_Red_Tracer_556x45_M249";
			_LMG_mag_tr = "CUP_200Rnd_TE4_Red_Tracer_556x45_M249";
				_primaryLMG = ["CUP_optic_Eotech533","GVL_X2000_point"];

			// Rifleman AT
			_LAT = "CUP_launch_NLAW";
			_LATmag = "CUP_NLAW_M";

			// Rifleman AT
			_MAT = "CUP_launch_NLAW";
			_MATmag1 = "CUP_NLAW_M";
			_MATmag2 = "CUP_NLAW_M";
		};
	};
};

// ===========================

// CLOTHES AND UNIFORMS
_camoflage = {
	switch (_this select 0) do {
	    default {
			// Infantry
			_baseHelmet = ["H_HelmetB_snakeskin"] call BIS_fnc_selectRandom;
			_baseUniform = ["U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3"] call BIS_fnc_selectRandom;
			_baseVest = ["V_PlateCarrierH_CTRG"] call BIS_fnc_selectRandom;
			_baseGlasses = ["G_Combat","G_Shades_Black"] call BIS_fnc_selectRandom;

			// Pilot
			_pilotHelmet = "H_PilotHelmetHeli_B";
			_pilotUniform = "U_B_HeliPilotCoveralls";
			_pilotVest = "V_TacVest_camo";

			// Vehicle Crewman
			_crewHelmet = "rhsusf_ach_bare_wood_headset_ess";
			_crewVest = "rhsusf_iotv_ocp_repair";

			// Backpacks
			_bagRifleman = "CUP_B_Bergen_BAF";
			_bagAG = "B_Carryall_cbr";
			_radioAirBackpack = "tf_rt1523g_big";
			_radioBackpack = "tf_rt1523g_big";
		};
	};
};
