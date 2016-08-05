#include "Common.sqf"

pmcammo = false;
_AllowNVG = false;
_factionValue = true;		// True if value below is anything else then Default
_factionScript = "csfb_kit";	// Name of the file that us going to be loading the loadout
// ==================
// WEAPON SELECTION

switch (GOL_Gear_Camo) do {
    default {	// Woodland
		
		_pistol = "hgun_Pistol_01_F";
		_pistol_mag = "10Rnd_9x21_Mag";
		_secondaryPistol = [];

		_rifle = "arifle_AK12_F";
		_rifle_mag = "30Rnd_762x39_Mag_F";
		_rifle_mag_tr = "30Rnd_762x39_Mag_Green_F";

		_rifleGL = "arifle_AK12_GL_F";
		_rifleGL_mag = "30Rnd_762x39_Mag_F";
		_rifleGL_mag_tr = "30Rnd_762x39_Mag_Green_F";		
		
		_rifleALT = "arifle_AKS_F";
		_rifleALT_mag = "30Rnd_545x39_Mag_F";
		_rifleALT_mag_tr = "30Rnd_545x39_Mag_Green_F";

		_glHE = "1Rnd_HE_Grenade_shell";
		_glsmokeW = "1Rnd_Smoke_Grenade_shell";
		_glsmokeG = "1Rnd_SmokeGreen_Grenade_shell";
		_glsmokeR = "1Rnd_SmokeRed_Grenade_shell";
		_glflareW = "UGL_FlareWhite_F";
		_glflareG = "UGL_FlareGreen_F";
		_glflareR = "UGL_FlareRed_F";			
	
		_carbine = ["arifle_AKM_F","arifle_AK12_F"] call BIS_fnc_selectRandom;
		_carbine_mag = "30Rnd_762x39_Mag_F";
		_carbine_mag_tr = "30Rnd_762x39_Mag_Green_F";		
		
		_LMG = "LMG_Zafir_F";
		_LMG_mag = "150Rnd_762x51_Box_Tracer";
		_LMG_mag_tr = "150Rnd_762x51_Box_Tracer";

		// Rifleman AT
		_LAT = "launch_RPG7_F";
		_LATmag = "RPG7_F";

		// Rifleman AT
		_MAT = "launch_RPG7_F";
		_MATmag1 = "RPG7_F";
		_MATmag2 = "RPG7_F";
		
		_primaryRifle = ["GVL_X2000_point"];
		_primaryRifleGL = ["GVL_X2000_point"];
		_primaryRifleALT = ["GVL_X2000_point"];
		_primaryCarbine = ["GVL_X2000_point"];
		_primaryLMG = ["GVL_X2000_point"];
	};
};

	// ==================
	// Infantry
	_baseHelmet = "CUP_H_RUS_6B27_NVG";
	_baseHelmetALT = "CUP_H_ChDKZ_Beret";

	_baseUniform = ["U_BG_Guerrilla_6_1","CUP_U_I_GUE_Anorak_02","CUP_U_O_RUS_Gorka_Partizan"] call BIS_fnc_selectRandom;
	_baseUniformALT = "";

	_baseVest = "CUP_V_I_RACS_Carrier_Vest";
	_baseGlasses = [] call BIS_fnc_selectRandom;

	// Echo Helo
	_pilotHelmet = "H_PilotHelmetHeli_O";
	_pilotUniform = "U_I_pilotCoveralls";
	_pilotVest = "V_TacVest_oli";

	// Echo Ground
	_pilotHelmetG = "H_PilotHelmetHeli_B";
	_pilotUniformG = ["U_BG_Guerrilla_6_1","CUP_U_I_GUE_Anorak_02","CUP_U_O_RUS_Gorka_Partizan"] call BIS_fnc_selectRandom;
	_pilotVestG = "V_TacVest_oli";
		
	// Echo Plane
	_pilotHelmetP = "H_PilotHelmetFighter_B";
	_pilotUniformP = "U_B_PilotCoveralls";
	_pilotVestP = "V_TacVest_oli";

	// Backpacks
	_bagRifleman = "B_FieldPack_khk";
	_bagAG = "B_Kitbag_mcamo";
	_radioAirBackpack = "tf_rt1523g_big_rhs";
	_radioBackpack = "tf_anprc155_coyote";
	_bagPilot = "B_Parachute";