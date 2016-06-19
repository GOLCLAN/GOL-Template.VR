#include "Common.sqf"
_AllowNVG = true;
_factionValue = false;
_factionScript = "Default";
pmcammo = false;

// ===========================
// WEAPON SELECTION

switch (GOL_Gear_Camo) do {
    default {	// Woodland
		_pistol = "rhsusf_weap_m1911a1";
		_pistol_mag = "rhsusf_mag_7x45acp_MHP";
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

	// ===========================
	// Infantry
	_baseHelmet = ["H_HelmetB_snakeskin"] call BIS_fnc_selectRandom;
	_baseUniform = ["U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3"] call BIS_fnc_selectRandom;
	_baseVest = ["V_PlateCarrierH_CTRG"] call BIS_fnc_selectRandom;
	_baseGlasses = ["G_Combat"] call BIS_fnc_selectRandom;

	// Echo Helo
	_pilotHelmet = "H_PilotHelmetHeli_O";
	_pilotUniform = "U_I_pilotCoveralls";
	_pilotVest = "V_TacVest_oli";

	// Echo Ground
	_pilotHelmetG = "H_PilotHelmetHeli_B";
	_pilotUniformG = ["U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3"] call BIS_fnc_selectRandom;
	_pilotVestG = "V_TacVest_oli";
		
	// Echo Plane
	_pilotHelmetP = "H_PilotHelmetFighter_B";
	_pilotUniformP = "U_B_PilotCoveralls";
	_pilotVestP = "V_TacVest_oli";

	// Backpacks
	_bagRifleman = "CUP_B_Bergen_BAF";
	_bagAG = "B_Carryall_cbr";
	_radioAirBackpack = "tf_rt1523g_big";
	_radioBackpack = "tf_rt1523g_big";
	_bagPilot = "B_Parachute";