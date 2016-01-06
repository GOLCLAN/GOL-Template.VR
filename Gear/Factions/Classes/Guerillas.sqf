
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
    default {	// Woodland
		_pistol = "rhs_weap_pya";
		_pistol_mag = "rhs_mag_9x19_17";
			_secondaryPistol = [];

		_rifle = "rhs_weap_akm";
		_rifle_mag = "rhs_30Rnd_762x39mm_tracer";
		_rifle_mag_tr = "rhs_30Rnd_762x39mm_tracer";
			_primaryRifle = [];

		_rifleGL = "rhs_weap_akm_gp25";
		_rifleGL_mag = "rhs_30Rnd_762x39mm_tracer";
		_rifleGL_mag_tr = "rhs_30Rnd_762x39mm_tracer";
			_primaryRifleGL = [];

		_rifleALT = "rhs_weap_akms";
		_rifleALT_mag = "rhs_30Rnd_762x39mm_tracer";
		_rifleALT_mag_tr = "rhs_30Rnd_762x39mm_tracer";
			_primaryRifleALT = [];

		_carbine = "CUP_arifle_AKS74U";
		_carbine_mag = "CUP_30Rnd_545x39_AK_M";
		_carbine_mag_tr = "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";
			_primaryCarbine = [];

		_LMG = "rhs_weap_pkm";
		_LMG_mag = "rhs_100Rnd_762x54mmR";
		_LMG_mag_tr = "rhs_100Rnd_762x54mmR_green";
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
_baseHelmet = ["SP_BaseballCap_Green","H_Bandanna_khk","SP_Hood_Green"] call BIS_fnc_selectRandom;
_baseUniform = ["U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla2_1","U_BG_Guerilla2_3"] call BIS_fnc_selectRandom;
_baseVest = ["V_I_G_resistanceLeader_F","V_TacVest_oli","V_TacVest_camo"] call BIS_fnc_selectRandom;
_baseGlasses = ["G_Combat"] call BIS_fnc_selectRandom;

// Pilot
_pilotHelmet = "H_PilotHelmetHeli_B";
_pilotUniform = "SP_0000_Standard_Coverall_GreenOlive";
_pilotVest = "SP_Modular1_Green";

// Vehicle Crewman
_crewHelmet = ["SP_PASGTHelmet_Green1"] call BIS_fnc_selectRandom;
_crewVest = "SP_PlateCarrier1_Green";

// Backpacks
_bagRifleman = "B_FieldPack_oli";
_bagAG = "SP_Carryall_Green";
_radioAirBackpack = "tf_anprc155";
_radioBackpack = "tf_anprc155";
