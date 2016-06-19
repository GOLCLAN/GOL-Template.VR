#include "Common.sqf"

pmcammo = false;
_AllowNVG = false;
_factionValue = true;		// True if value below is anything else then Default
_factionScript = "csfb_kit";	// Name of the file that us going to be loading the loadout
// ==================
// WEAPON SELECTION

switch (GOL_Gear_Camo) do {
    default {	// Woodland
		
		_pistol = "CUP_hgun_PB6P9";
		_pistol_mag = "CUP_8Rnd_9x18_Makarov_M";
		_secondaryPistol = [];

		_rifle = "hlc_rifle_aks74";
		_rifle_mag = "hlc_30Rnd_545x39_B_AK";
		_rifle_mag_tr = "hlc_30Rnd_545x39_t_ak";

		_rifleGL = "hlc_rifle_aks74_GL";
		_rifleGL_mag = "hlc_30Rnd_545x39_B_AK";
		_rifleGL_mag_tr = "hlc_30Rnd_545x39_t_ak";		
		
		_rifleALT = "hlc_rifle_aks74u";
		_rifleALT_mag = "hlc_30Rnd_545x39_B_AK";
		_rifleALT_mag_tr = "hlc_30Rnd_545x39_B_AK_tracer";

		_glHE = "hlc_VOG25_AK";
		_glsmokeW = "hlc_GRD_White";
		_glsmokeG = "hlc_GRD_Green";
		_glsmokeR = "hlc_GRD_Red";
		_glflareW = "UGL_FlareWhite_F";
		_glflareG = "UGL_FlareGreen_F";
		_glflareR = "UGL_FlareRed_F";			
	
		_carbine = ["hlc_rifle_aek971","hlc_rifle_ak74","hlc_rifle_akm","hlc_rifle_ak12"] call BIS_fnc_selectRandom;
		_carbine_mag = "hlc_30Rnd_545x39_B_AK";
		_carbine_mag_tr = "hlc_30Rnd_545x39_t_ak";		
		
		_LMG = "hlc_rifle_rpk";
		_LMG_mag = "hlc_75Rnd_762x39_m_rpk";
		_LMG_mag_tr = "hlc_75Rnd_762x39_m_rpk";
		_primaryLMG = ["GVL_X2000_point"];

		// Rifleman AT
		_LAT = "launch_RPG32_F";
		_LATmag = "RPG32_F";

		// Rifleman AT
		_MAT = "launch_RPG32_F";
		_MATmag1 = "RPG32_F";
		_MATmag2 = "RPG32_HE_F";
		
		_primaryRifle = ["GVL_X2000_point"];
		_primaryRifleGL = ["GVL_X2000_point"];
		_primaryRifleALT = ["GVL_X2000_point"];
		_primaryCarbine = ["GVL_X2000_point"];
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