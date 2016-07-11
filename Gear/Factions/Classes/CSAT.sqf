#include "Common.sqf"
_AllowNVG = true;
_factionValue = false;
_factionScript = "Default";
pmcammo = false;

// ===========================
// WEAPON SELECTION

switch (GOL_Gear_Camo) do {
    default {	// Woodland
		_pistol = "hgun_Rook40_F";
		_pistol_mag = "16Rnd_9x21_Mag";
		_secondaryPistol = [];

		_rifle = "arifle_Katiba_F";
		_rifle_mag = "30Rnd_65x39_caseless_green";
		_rifle_mag_tr = "30Rnd_65x39_caseless_green_mag_Tracer";
		_primaryRifle = ["optic_ACO_grn","GVL_X2000_point"];

		_rifleGL = "arifle_Katiba_GL_F";
		_rifleGL_mag = "30Rnd_65x39_caseless_green";
		_rifleGL_mag_tr = "30Rnd_65x39_caseless_green_mag_Tracer";
		_primaryRifleGL = ["optic_ACO_grn","GVL_X2000_point"];

		_rifleALT = "arifle_Katiba_C_F";
		_rifleALT_mag = "30Rnd_65x39_caseless_green";
		_rifleALT_mag_tr = "30Rnd_65x39_caseless_green_mag_Tracer";
		_primaryRifleALT = ["optic_ACO_grn","GVL_X2000_point"];

		_carbine = "SMG_02_F";
		_carbine_mag = "30Rnd_9x21_Mag";
		_carbine_mag_tr = "30Rnd_9x21_Mag";
			_primaryCarbine = ["optic_ACO_grn","GVL_X2000_point"];

		_LMG = "asdg_LMG_Zafir_F";
		_LMG_mag = "150Rnd_762x51_Box";
		_LMG_mag_tr = "150Rnd_762x51_Box_Tracer";
		_primaryLMG = ["optic_ACO_grn","GVL_X2000_point"];

		// Rifleman AT
		_LAT = "launch_RPG7_F";
		_LATmag = "RPG7_F";

		// Rifleman AT
		_MAT = "launch_RPG7_F";
		_MATmag1 = "RPG7_F";
		_MATmag2 = "RPG7_F";
	};
};

	// ===========================
	// Infantry
	_baseHelmet = ["H_HelmetLeaderO_ocamo"] call BIS_fnc_selectRandom;
	_baseUniform = ["U_O_CombatUniform_ocamo"] call BIS_fnc_selectRandom;
	_baseVest = ["V_HarnessOSpec_brn"] call BIS_fnc_selectRandom;
	_baseGlasses = ["G_Combat",nil] call BIS_fnc_selectRandom;

	// Echo Helo
	_pilotHelmet = "H_PilotHelmetHeli_O";
	_pilotUniform = "U_I_pilotCoveralls";
	_pilotVest = "V_TacVest_oli";

	// Echo Ground
	_pilotHelmetG = "H_PilotHelmetHeli_B";
	_pilotUniformG = ["U_O_CombatUniform_ocamo"] call BIS_fnc_selectRandom;
	_pilotVestG = "V_TacVest_oli";
		
	// Echo Plane
	_pilotHelmetP = "H_PilotHelmetFighter_B";
	_pilotUniformP = "U_B_PilotCoveralls";
	_pilotVestP = "V_TacVest_oli";

	// Backpacks
	_bagRifleman = "B_FieldPack_ocamo";
	_bagAG = "B_Carryall_ocamo";
	_radioAirBackpack = "tf_mr3000";
	_radioBackpack = "tf_mr3000";
	_bagPilot = "B_Parachute";