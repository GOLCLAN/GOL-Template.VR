
#include "Common.sqf";

_AllowNVG = true;

_glHE = "rhs_VOG25";

_glsmokeW = "rhs_GRD40_White";
_glsmokeG = "rhs_GRD40_Green";
_glsmokeR = "rhs_GRD40_Red";

_glflareW = "rhs_VG40OP_white";
_glflareG = "rhs_VG40OP_green";
_glflareR = "rhs_VG40OP_red";

// ===========================
// WEAPON SELECTION

_weaponCamo = {
	switch (_this select 0) do {
	    default {
			_pistol = "rhs_weap_makarov_pmm";
			_pistol_mag = "rhs_mag_9x18_12_57N181S";
				_secondaryPistol = [];

			_rifle = "rhs_weap_ak74m";
			_rifle_mag = "rhs_30Rnd_545x39_AK";
			_rifle_mag_tr = "rhs_30Rnd_545x39_7N10_AK";
				_primaryRifle = ["optic_ACO_grn","acc_pointer_IR"];

			_rifleGL = "rhs_weap_ak74m_gp25";
			_rifleGL_mag = "rhs_30Rnd_545x39_AK";
			_rifleGL_mag_tr = "rhs_30Rnd_545x39_7N10_AK";
				_primaryRifleGL = ["optic_ACO_grn","acc_pointer_IR"];

			_rifleALT = "rhs_weap_ak74m";
			_rifleALT_mag = "rhs_30Rnd_545x39_AK";
			_rifleALT_mag_tr = "rhs_30Rnd_545x39_7N10_AK";
				_primaryRifleALT = ["optic_ACO_grn","acc_pointer_IR"];

			_carbine = "rhs_weap_ak74m_folded";
			_carbine_mag = "rhs_30Rnd_545x39_AK";
			_carbine_mag_tr = "rhs_30Rnd_545x39_7N10_AK";
				_primaryCarbine = ["optic_ACO_grn","acc_pointer_IR"];

			_LMG = "rhs_weap_pkp";
			_LMG_mag = "rhs_100Rnd_762x54mmR";
			_LMG_mag_tr = "rhs_100Rnd_762x54mmR_green";
				_primaryLMG = ["optic_ACO_grn","acc_pointer_IR"];

			// Rifleman AT
			_LAT = "rhs_weap_rpg26";
			_LATmag = "rhs_rpg26_mag";

			// Rifleman AT
			_MAT = "rhs_weap_rpg7";
			_MATmag1 = "rhs_rpg7_PG7VL_mag";
			_MATmag2 = "rhs_rpg7_PG7VL_mag";
		};
	};
};

// ===========================

// CLOTHES AND UNIFORMS
_camoflage = {
	switch (_this select 0) do {
	    default {
			// Infantry
			_baseHelmet = ["rhs_6b26","rhs_6b26"] call BIS_fnc_selectRandom;
			_baseUniform = ["rhs_uniform_flora_patchless"] call BIS_fnc_selectRandom;
			_baseVest = ["rhs_6b13_Flora_6sh92"] call BIS_fnc_selectRandom;
			_baseGlasses = ["SP_Goggles_Black"] call BIS_fnc_selectRandom;

			// Pilot
			_pilotHelmet = "rhs_zsh7a_mike";
			_pilotUniform = "rhs_uniform_flora_patchless";
			_pilotVest = "rhs_6b23_6sh92";

			// Vehicle Crewman
			_crewHelmet = ["rhs_tsh4","rhs_tsh4_ess"] call BIS_fnc_selectRandom;
			_crewVest = "rhs_6b23_digi_crew";

			// Backpacks
			_bagRifleman = "rhs_assault_umbts";
			_bagAG = "B_Carryall_oli";
			_radioAirBackpack = "tf_mr3000_rhs";
			_radioBackpack = "tf_mr3000_rhs";
		};
	};
};
