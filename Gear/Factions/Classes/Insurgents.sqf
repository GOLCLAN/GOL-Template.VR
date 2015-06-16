
#include "Common.sqf"

_AllowNVG = true;
_factionValue = false;
_factionScript = "Default";

_glHE = "rhs_VOG25";

_glsmokeW = "rhs_GRD40_White";
_glsmokeG = "rhs_GRD40_Green";
_glsmokeR = "rhs_GRD40_Red";

_glflareW = "rhs_VG40OP_white";
_glflareG = "rhs_VG40OP_green";
_glflareR = "rhs_VG40OP_red";

// ===========================
// WEAPON SELECTION

switch (GOL_Gear_Camo) do {
    default {	// Desert
		_pistol = "rhs_weap_pya";
		_pistol_mag = "rhs_mag_9x19_17";
			_secondaryPistol = [];

		_rifle = "rhs_weap_akms";
		_rifle_mag = "rhs_30Rnd_762x39mm_tracer";
		_rifle_mag_tr = "rhs_30Rnd_762x39mm_tracer";
			_primaryRifle = [];

		_rifleGL = "rhs_weap_akms_gp25";
		_rifleGL_mag = "rhs_30Rnd_762x39mm_tracer";
		_rifleGL_mag_tr = "rhs_30Rnd_762x39mm_tracer";
			_primaryRifleGL = [];

		_rifleALT = "rhs_weap_akm";
		_rifleALT_mag = "rhs_30Rnd_762x39mm_tracer";
		_rifleALT_mag_tr = "rhs_30Rnd_762x39mm_tracer";
			_primaryRifleALT = [];

		_carbine = "CUP_arifle_AKS74U";
		_carbine_mag = "CUP_30Rnd_545x39_AK_M";
		_carbine_mag_tr = "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";
			_primaryCarbine = [];

		_LMG = "CUP_arifle_RPK74";
		_LMG_mag = "CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M";
		_LMG_mag_tr = "CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M";
			_primaryLMG = [];

		// Rifleman AT
		_LAT = "rhs_weap_rpg7";
		_LATmag = "rhs_rpg7_PG7VL_mag";

		// Rifleman AT
		_MAT = "rhs_weap_rpg7";
		_MATmag1 = "rhs_rpg7_PG7VL_mag";
		_MATmag2 = "rhs_rpg7_TBG7V_mag";
	};
};

// ===========================

// Infantry
_baseHelmet = ["H_ShemagOpen_tan","H_ShemagOpen_khk","SP_Shemagh_Tan","SP_Shemagh_CheckGreen","H_ShemagOpen_khk"] call BIS_fnc_selectRandom;
_baseUniform = ["U_CAF_AG_ME_ROBES_Mil_01","U_CAF_AG_ME_ROBES_01b","U_CAF_AG_ME_ROBES_02b","U_CAF_AG_ME_ROBES_04a","U_CAF_AG_ME_ROBES_04c","U_CAF_AG_ME_ROBES_03c"] call BIS_fnc_selectRandom;
_baseVest = ["V_TacVest_camo"] call BIS_fnc_selectRandom;
_baseGlasses = [nil] call BIS_fnc_selectRandom;

// Pilot
_pilotHelmet = "H_PilotHelmetHeli_B";
_pilotUniform = "SP_0000_Standard_Coverall_Green";
_pilotVest = "SP_Modular1_Green";

// Vehicle Crewman
_crewHelmet = ["SP_PASGTHelmet_Green1"] call BIS_fnc_selectRandom;
_crewVest = "SP_PlateCarrier1_Green";

// Backpacks
_bagRifleman = "B_AssaultPack_cbr";
_bagAG = "B_Carryall_cbr";
_radioAirBackpack = "tf_anprc155_coyote";
_radioBackpack = "tf_anprc155_coyote";
