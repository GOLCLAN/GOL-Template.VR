#include "Common.sqf"
_AllowNVG = true;
_factionValue = false;
_factionScript = "Default";
pmcammo = false;

_glHE = "CUP_1Rnd_HE_GP25_M";

_glsmokeW = "CUP_1Rnd_SMOKE_GP25_M";
_glsmokeG = "CUP_1Rnd_SmokeGreen_GP25_M";
_glsmokeR = "CUP_1Rnd_SmokeRed_GP25_M";

_glflareW = "CUP_FlareWhite_GP25_M";
_glflareG = "CUP_FlareGreen_GP25_M";
_glflareR = "CUP_FlareRed_GP25_M";

// ===========================

switch (GOL_Gear_Camo) do {

    default {	// Woodland
		_pistol = "CUP_hgun_PB6P9";
		_pistol_mag = "CUP_8Rnd_9x18_Makarov_M";
		_secondaryPistol = [];

		_rifle = "CUP_arifle_AK74M";
		_rifle_mag = "CUP_30Rnd_545x39_AK_M";
		_rifle_mag_tr = "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";
		_primaryRifle = ["optic_ACO_grn","acc_pointer_IR"];

		_rifleGL = "CUP_arifle_AK74M_GL";
		_rifleGL_mag = "CUP_30Rnd_545x39_AK_M";
		_rifleGL_mag_tr = "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";
		_primaryRifleGL = ["optic_ACO_grn","acc_pointer_IR"];

		_rifleALT = "CUP_arifle_AK107";
		_rifleALT_mag = "CUP_30Rnd_545x39_AK_M";
		_rifleALT_mag_tr = "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";
		_primaryRifleALT = ["optic_ACO_grn","acc_pointer_IR"];

		_carbine = "CUP_arifle_AKS74U";
		_carbine_mag = "CUP_30Rnd_545x39_AK_M";
		_carbine_mag_tr = "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";
		_primaryCarbine = ["optic_ACO_grn","acc_pointer_IR"];

		_LMG = "CUP_lmg_Pecheneg";
		_LMG_mag = "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M";
		_LMG_mag_tr = "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M";
		_primaryLMG = ["optic_ACO_grn","acc_pointer_IR"];

		// Rifleman AT
		_LAT = "CUP_launch_RPG18";
		_LATmag = "ACE_PreloadedMissileDummy_RPG18_CUP";

		// Rifleman AT
		_MAT = "CUP_launch_RPG7V";
		_MATmag1 = "CUP_PG7VL_M";
		_MATmag2 = "CUP_PG7VL_M";

		// ===========================

		// Infantry
		_baseHelmet = ["CUP_H_RUS_6B27","CUP_H_RUS_6B27"] call BIS_fnc_selectRandom;
		_baseUniform = ["CUP_U_O_RUS_EMR_1","CUP_U_O_RUS_EMR_2_VDV"] call BIS_fnc_selectRandom;
		_baseVest = ["CUP_V_RUS_6B3_4","CUP_V_RUS_6B3_1","CUP_V_RUS_6B3_1"] call BIS_fnc_selectRandom;
		_baseGlasses = [nil] call BIS_fnc_selectRandom;

		// Echo Helo
		_pilotHelmet = "H_PilotHelmetHeli_O";
		_pilotUniform = "U_I_pilotCoveralls";
		_pilotVest = "V_TacVest_oli";

		// Echo Ground
		_pilotHelmetG = "H_PilotHelmetHeli_B";
		_pilotUniformG = ["CUP_U_O_RUS_EMR_1","CUP_U_O_RUS_EMR_2_VDV"] call BIS_fnc_selectRandom;
		_pilotVestG = "V_TacVest_oli";
			
		// Echo Plane
		_pilotHelmetP = "H_PilotHelmetFighter_B";
		_pilotUniformP = "U_B_PilotCoveralls";
		_pilotVestP = "V_TacVest_oli";

		// Backpacks
		_bagRifleman = "CUP_B_AlicePack_Bedroll";
		_bagAG = "CUP_B_HikingPack_Civ";
		_radioAirBackpack = "tf_rt1523g_big_bwmod";
		_radioBackpack = "tf_mr3000_rhs";
		_bagPilot = "B_Parachute";
	};
};
