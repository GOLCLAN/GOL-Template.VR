
#include "Common.sqf";

_AllowNVG = true;

// ===========================
// WEAPON SELECTION

_weaponCamo = {
	switch (_this select 0) do {
		case 1: {
			_pistol = "hgun_Pistol_heavy_01_F";
			_pistol_mag = "11Rnd_45ACP_Mag";
				_secondaryPistol = [];

			_rifle = "arifle_MX_pointer_F";
			_rifle_mag = "30Rnd_65x39_caseless_mag";
			_rifle_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
				_primaryRifle = ["FHQ_optic_HWS","acc_pointer_IR"];

			_rifleGL = "arifle_MX_GL_F";
			_rifleGL_mag = "30Rnd_65x39_caseless_mag";
			_rifleGL_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
				_primaryRifleGL = ["FHQ_optic_HWS","acc_pointer_IR"];

			_rifleALT = "arifle_MXC_F";
			_rifleALT_mag = "30Rnd_65x39_caseless_mag";
			_rifleALT_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
				_primaryRifleALT = ["FHQ_optic_HWS","acc_pointer_IR"];

			_carbine = "hgun_PDW2000_F";
			_carbine_mag = "30Rnd_9x21_Mag";
			_carbine_mag_tr = "30Rnd_9x21_Mag";
				_primaryCarbine = ["FHQ_optic_HWS","acc_pointer_IR"];

			_LMG = "asdg_LMG_Mk200_F";
			_LMG_mag = "200Rnd_65x39_cased_Box";
			_LMG_mag_tr = "200Rnd_65x39_cased_Box";
				_primaryLMG = ["FHQ_optic_HWS","acc_pointer_IR","bipod_01_F_snd"];

			// Rifleman AT
			_LAT = "launch_NLAW_F";
			_LATmag = "NLAW_F";

			// Rifleman AT
			_MAT = "launch_NLAW_F";
			_MATmag1 = "NLAW_F";
			_MATmag2 = "NLAW_F";
		};

	    default {
			_pistol = "hgun_Pistol_heavy_01_F";
			_pistol_mag = "11Rnd_45ACP_Mag";
				_secondaryPistol = [];

			_rifle = "arifle_MX_Black_F";
			_rifle_mag = "30Rnd_65x39_caseless_mag";
			_rifle_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
				_primaryRifle = ["FHQ_optic_HWS","acc_pointer_IR"];

			_rifleGL = "arifle_MX_GL_Black_F";
			_rifleGL_mag = "30Rnd_65x39_caseless_mag";
			_rifleGL_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";

				_primaryRifleGL = ["FHQ_optic_HWS","acc_pointer_IR"];

			_rifleALT = "arifle_MXC_Black_F";
			_rifleALT_mag = "30Rnd_65x39_caseless_mag";
			_rifleALT_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
				_primaryRifleALT = ["FHQ_optic_HWS","acc_pointer_IR"];

			_carbine = "hgun_PDW2000_F";
			_carbine_mag = "30Rnd_9x21_Mag";
			_carbine_mag_tr = "30Rnd_9x21_Mag";
				_primaryCarbine = ["FHQ_optic_HWS","acc_pointer_IR"];

			_LMG = "asdg_LMG_Mk200_F";
			_LMG_mag = "200Rnd_65x39_cased_Box";
			_LMG_mag_tr = "200Rnd_65x39_cased_Box";
				_primaryLMG = ["FHQ_optic_HWS","acc_pointer_IR","bipod_01_F_blk"];

			// Rifleman AT
			_LAT = "launch_NLAW_F";
			_LATmag = "NLAW_F";

			// Rifleman AT
			_MAT = "launch_NLAW_F";
			_MATmag1 = "NLAW_F";
			_MATmag2 = "NLAW_F";
		};
	};
};

// ===========================

// CLOTHES AND UNIFORMS
_camoflage = {
	switch (_this select 0) do {
	    default {
			// Infantry
			_baseHelmet = ["H_HelmetB","H_HelmetB_plain_mcamo"] call BIS_fnc_selectRandom;
			_baseUniform = ["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest"] call BIS_fnc_selectRandom;
			_baseVest = ["V_PlateCarrier3_rgr"] call BIS_fnc_selectRandom;
			_baseGlasses = ["G_Combat","G_Shades_Black"] call BIS_fnc_selectRandom;

			// Pilot
			_pilotHelmet = "H_PilotHelmetHeli_B";
			_pilotUniform = "U_B_HeliPilotCoveralls";
			_pilotVest = "V_TacVest_camo";

			// Vehicle Crewman
			_crewHelmet = "H_HelmetB";
			_crewVest = "V_PlateCarrier2_rgr";

			// Backpacks
			_bagRifleman = "B_AssaultPack_mcamo";
			_bagAG = "B_FieldPack_khk";
			_radioAirBackpack = "tf_rt1523g_big";		// LongRange // used by people with backpack radio
			_radioBackpack = "tf_rt1523g_big";		// MidRange // used by people with backpack radio
		};
	};
};