#include "Common.sqf"
_AllowNVG = true;
_factionValue = false;		// True if value below is anything else then Default
_factionScript = "Default";	// Name of the file that us going to be loading the loadout
pmcammo = false;

// ===========================
// WEAPON SELECTION

switch (GOL_Gear_Camo) do {
	case 1: {	// Desert weapons
		_pistol = "hgun_Pistol_heavy_01_F";
		_pistol_mag = "11Rnd_45ACP_Mag";
		_secondaryPistol = [];

		_rifle = "arifle_MX_pointer_F";
		_rifle_mag = "30Rnd_65x39_caseless_mag";
		_rifle_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
		_primaryRifle = ["FHQ_optic_HWS","GVL_X2000_point"];

		_rifleGL = "arifle_MX_GL_F";
		_rifleGL_mag = "30Rnd_65x39_caseless_mag";
		_rifleGL_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
		_primaryRifleGL = ["FHQ_optic_HWS","GVL_X2000_point"];

		_rifleALT = "arifle_MXC_F";
		_rifleALT_mag = "30Rnd_65x39_caseless_mag";
		_rifleALT_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
		_primaryRifleALT = ["FHQ_optic_HWS","GVL_X2000_point"];

		_carbine = "hgun_PDW2000_F";
		_carbine_mag = "30Rnd_9x21_Mag";
		_carbine_mag_tr = "30Rnd_9x21_Mag";
		_primaryCarbine = ["FHQ_optic_HWS","GVL_X2000_point"];

		_LMG = "asdg_LMG_Mk200_F";
		_LMG_mag = "200Rnd_65x39_cased_Box";
		_LMG_mag_tr = "200Rnd_65x39_cased_Box";
		_primaryLMG = ["FHQ_optic_HWS","GVL_X2000_point","bipod_01_F_snd"];

		// Rifleman AT
		_LAT = "launch_NLAW_F";
		_LATmag = "NLAW_F";

		// Rifleman AT
		_MAT = "launch_NLAW_F";
		_MATmag1 = "NLAW_F";
		_MATmag2 = "NLAW_F";
	};

    default {	// Black weapons
		_pistol = "hgun_Pistol_heavy_01_F";
		_pistol_mag = "11Rnd_45ACP_Mag";
		_secondaryPistol = [];

		_rifle = "arifle_MX_Black_F";
		_rifle_mag = "30Rnd_65x39_caseless_mag";
		_rifle_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
			_primaryRifle = ["FHQ_optic_HWS","GVL_X2000_point"];

		_rifleGL = "arifle_MX_GL_Black_F";
		_rifleGL_mag = "30Rnd_65x39_caseless_mag";
		_rifleGL_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
		_primaryRifleGL = ["FHQ_optic_HWS","GVL_X2000_point"];

		_rifleALT = "arifle_MXC_Black_F";
		_rifleALT_mag = "30Rnd_65x39_caseless_mag";
		_rifleALT_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
		_primaryRifleALT = ["FHQ_optic_HWS","GVL_X2000_point"];

		_carbine = "hgun_PDW2000_F";
		_carbine_mag = "30Rnd_9x21_Mag";
		_carbine_mag_tr = "30Rnd_9x21_Mag";
		_primaryCarbine = ["FHQ_optic_HWS","GVL_X2000_point"];

		_LMG = "asdg_LMG_Mk200_F";
		_LMG_mag = "200Rnd_65x39_cased_Box";
		_LMG_mag_tr = "200Rnd_65x39_cased_Box";
			_primaryLMG = ["FHQ_optic_HWS","GVL_X2000_point","bipod_01_F_blk"];

		// Rifleman AT
		_LAT = "launch_NLAW_F";
		_LATmag = "NLAW_F";

		// Rifleman AT
		_MAT = "launch_NLAW_F";
		_MATmag1 = "NLAW_F";
		_MATmag2 = "NLAW_F";
	};
};

	// ===========================
	// Infantry
	_baseHelmet = ["H_HelmetB","H_HelmetB_plain_mcamo"] call BIS_fnc_selectRandom;
	_baseUniform = ["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest"] call BIS_fnc_selectRandom;
	_baseVest = ["V_PlateCarrier3_rgr"] call BIS_fnc_selectRandom;
	_baseGlasses = ["G_Combat"] call BIS_fnc_selectRandom;

	// Echo Helo
	_pilotHelmet = "H_PilotHelmetHeli_O";
	_pilotUniform = "U_I_pilotCoveralls";
	_pilotVest = "V_TacVest_oli";

	// Echo Ground
	_pilotHelmetG = "H_PilotHelmetHeli_B";
	_pilotUniformG = ["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest"] call BIS_fnc_selectRandom;
	_pilotVestG = "V_TacVest_oli";
		
	// Echo Plane
	_pilotHelmetP = "H_PilotHelmetFighter_B";
	_pilotUniformP = "U_B_PilotCoveralls";
	_pilotVestP = "V_TacVest_oli";

	// Backpacks
	_bagRifleman = "B_AssaultPack_mcamo";
	_bagAG = "B_FieldPack_khk";
	_radioAirBackpack = "tf_rt1523g_big";		// LongRange // used by people with backpack radio
	_radioBackpack = "tf_rt1523g_big";		// MidRange // used by people with backpack radio
	_bagPilot = "B_Parachute";