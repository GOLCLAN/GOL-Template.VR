#include "Common.sqf"
pmcammo = true;
_AllowNVG = false;
_factionValue = false;		// True if value below is anything else then Default
_factionScript = "Default";	// Name of the file that us going to be loading the loadout

_ak545 = "hlc_30Rnd_545x39_B_AK";
_ak545_t = "hlc_30Rnd_545x39_t_ak";
_ak762 = "hlc_30Rnd_762x39_b_ak";
_ak762_t = "hlc_30Rnd_762x39_t_ak";
_stanag_mag = "30Rnd_556x45_Stanag";
_stanag_mag_t = "30Rnd_556x45_Stanag_Tracer_Red";
_stanag_65_mag = "30Rnd_65x39_caseless_green";
_stanag_65_mag_t = "30Rnd_65x39_caseless_green_mag_Tracer";
_dmr_762 = "20Rnd_762x51_Mag";
_dmr_762_t = "ACE_20Rnd_762x51_Mag_Tracer";

// ==================
// WEAPON SELECTION

switch (GOL_Gear_Camo) do {
    default {	// Woodland
		_pistol = "CUP_hgun_Glock17";
		_pistol_mag = "CUP_17Rnd_9x19_glock17";
		_secondaryPistol = [];

		if (332350 in (getDLCs 1)) then {
			rifles = [1,2,3,4,5,6,7,8,9,10,11,12] call BIS_fnc_selectRandom;
		} else {
			rifles = [1,2,3,4,5,6,7,8,9,10] call BIS_fnc_selectRandom;
		};
		
		_rifles = rifles;
		
		_riflesGL = [1,2,3,4,5,6,7] call BIS_fnc_selectRandom;
		
		//hint format["%1 - %2", _rifles, _riflesGL];
		
		if (_rifles == 1) then {
			_rifle = "CUP_arifle_Mk16_CQC_FG";
			_rifle_mag = "30Rnd_556x45_Stanag";
			_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
		};
		if (_rifles == 2) then {
			_rifle = "hlc_rifle_Colt727";
			_rifle_mag = "30Rnd_556x45_Stanag";
			_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
		};
		if (_rifles == 3) then {
			_rifle = "hlc_rifle_RU556";
			_rifle_mag = "30Rnd_556x45_Stanag";
			_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
		};
		if (_rifles == 4) then {
			_rifle = "arifle_Katiba_F";
			_rifle_mag = "30Rnd_65x39_caseless_green";
			_rifle_mag_tr = "30Rnd_65x39_caseless_green_mag_Tracer";
		};
		if (_rifles == 5) then {
			_rifle = "hlc_rifle_aek971";
			_rifle_mag = "hlc_30Rnd_545x39_B_AK";
			_rifle_mag_tr = "hlc_30Rnd_545x39_B_AK_tracer";
		};
		if (_rifles == 6) then {
			_rifle = "CUP_arifle_Mk16_STD_FG";
			_rifle_mag = "30Rnd_556x45_Stanag";
			_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
		};
		if (_rifles == 7) then {
			_rifle = "hlc_rifle_ak74";
			_rifle_mag = "hlc_30Rnd_545x39_B_AK";
			_rifle_mag_tr = "hlc_30Rnd_545x39_t_ak";
		};
		if (_rifles == 8) then {
			_rifle = "hlc_rifle_akm";
			_rifle_mag = "hlc_30Rnd_545x39_B_AK";
			_rifle_mag_tr = "hlc_30Rnd_545x39_B_AK_tracer";
		};
		if (_rifles == 9) then {
			_rifle = "hlc_rifle_ak12";
			_rifle_mag = "hlc_30Rnd_545x39_B_AK";
			_rifle_mag_tr = "hlc_30Rnd_545x39_B_AK_tracer";
		};
		if (_rifles == 10) then {
			_rifle = "srifle_DMR_03_F";
			_rifle_mag = "20Rnd_762x51_Mag";
			_rifle_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
		};
		if (_rifles == 11) then {
			_rifle = "srifle_DMR_06_camo_F";
			_rifle_mag = "20Rnd_762x51_Mag";
			_rifle_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
		};
		if (_rifles == 12) then {
			_rifle = "srifle_DMR_06_olive_F";
			_rifle_mag = "20Rnd_762x51_Mag";
			_rifle_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
		};
		

		_primaryRifle = ["GVL_X2000_point"];
		
		if (_riflesGL == 1) then {
			_rifleGL = "hlc_rifle_Colt727_GL";
			_rifleGL_mag = "30Rnd_556x45_Stanag";
			_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
			_glHE = "1Rnd_HE_Grenade_shell";
			_glsmokeW = "1Rnd_Smoke_Grenade_shell";
			_glsmokeG = "1Rnd_SmokeGreen_Grenade_shell";
			_glsmokeR = "1Rnd_SmokeRed_Grenade_shell";
			_glflareW = "UGL_FlareWhite_F";
			_glflareG = "UGL_FlareGreen_F";
			_glflareR = "UGL_FlareRed_F";			
		};
		if (_riflesGL == 2) then {
			_rifleGL = "arifle_Katiba_GL_F";
			_rifleGL_mag = "30Rnd_65x39_caseless_green";
			_rifleGL_mag_tr = "30Rnd_65x39_caseless_green_mag_Tracer";
			_glHE = "1Rnd_HE_Grenade_shell";
			_glsmokeW = "1Rnd_Smoke_Grenade_shell";
			_glsmokeG = "1Rnd_SmokeGreen_Grenade_shell";
			_glsmokeR = "1Rnd_SmokeRed_Grenade_shell";
			_glflareW = "UGL_FlareWhite_F";
			_glflareG = "UGL_FlareGreen_F";
			_glflareR = "UGL_FlareRed_F";	
		};
		if (_riflesGL == 3) then {
			_rifleGL = "arifle_Katiba_GL_F";
			_rifleGL_mag = "30Rnd_65x39_caseless_green";
			_rifleGL_mag_tr = "30Rnd_65x39_caseless_green_mag_Tracer";
			_glHE = "1Rnd_HE_Grenade_shell";
			_glsmokeW = "1Rnd_Smoke_Grenade_shell";
			_glsmokeG = "1Rnd_SmokeGreen_Grenade_shell";
			_glsmokeR = "1Rnd_SmokeRed_Grenade_shell";
			_glflareW = "UGL_FlareWhite_F";
			_glflareG = "UGL_FlareGreen_F";
			_glflareR = "UGL_FlareRed_F";
		};
		if (_riflesGL == 4) then {
			_rifleGL = "hlc_rifle_aks74_GL"; // hlc_rifle_ak12GL broken?
			_rifleGL_mag = "hlc_30Rnd_545x39_B_AK";
			_rifleGL_mag_tr = "hlc_30Rnd_545x39_B_AK_tracer";
			_glHE = "hlc_VOG25_AK";
			_glsmokeW = "hlc_GRD_White";
			_glsmokeG = "hlc_GRD_Green";
			_glsmokeR = "hlc_GRD_Red";
			_glflareW = "ACE_HandFlare_White";
			_glflareG = "ACE_HandFlare_Green";
			_glflareR = "ACE_HandFlare_Red";
		};
		if (_riflesGL == 5) then {
			_rifleGL = "hlc_rifle_aks74_GL";
			_rifleGL_mag = "hlc_30Rnd_545x39_B_AK";
			_rifleGL_mag_tr = "hlc_30Rnd_545x39_t_ak";
			_glHE = "hlc_VOG25_AK";
			_glsmokeW = "hlc_GRD_White";
			_glsmokeG = "hlc_GRD_Green";
			_glsmokeR = "hlc_GRD_Red";
			_glflareW = "ACE_HandFlare_White";
			_glflareG = "ACE_HandFlare_Green";
			_glflareR = "ACE_HandFlare_Red";
		};
		if (_riflesGL == 6) then {
			_rifleGL = "hlc_rifle_akmgl";
			_rifleGL_mag = "hlc_30Rnd_762x39_b_ak";
			_rifleGL_mag_tr = "hlc_30Rnd_762x39_t_ak";
			_glHE = "hlc_VOG25_AK";
			_glsmokeW = "hlc_GRD_White";
			_glsmokeG = "hlc_GRD_Green";
			_glsmokeR = "hlc_GRD_Red";
			_glflareW = "ACE_HandFlare_White";
			_glflareG = "ACE_HandFlare_Green";
			_glflareR = "ACE_HandFlare_Red";
		};
		if (_riflesGL == 7) then {
			_rifleGL = "hlc_rifle_aks74_GL"; // hlc_rifle_ak12_gp25 broken?
			_rifleGL_mag = "hlc_30Rnd_545x39_B_AK";
			_rifleGL_mag_tr = "hlc_30Rnd_545x39_B_AK_tracer";
			_glHE = "hlc_VOG25_AK";
			_glsmokeW = "hlc_GRD_White";
			_glsmokeG = "hlc_GRD_Green";
			_glsmokeR = "hlc_GRD_Red";
			_glflareW = "ACE_HandFlare_White";
			_glflareG = "ACE_HandFlare_Green";
			_glflareR = "ACE_HandFlare_Red";
		};
		
		_primaryRifleGL = ["GVL_X2000_point"];

		_rifleALT = ["hlc_rifle_Colt727","CUP_arifle_Mk16_CQC_FG","hlc_rifle_RU556","hlc_rifle_Bushmaster300","hlc_rifle_Colt727"] call BIS_fnc_selectRandom;
		_rifleALT_mag = "30Rnd_556x45_Stanag";
		_rifleALT_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
		_primaryRifleALT = ["GVL_X2000_point"];

		_carbine = ["hlc_rifle_aek971","hlc_rifle_ak74","hlc_rifle_akm","hlc_rifle_ak12"] call BIS_fnc_selectRandom;
		_carbine_mag = "hlc_30Rnd_545x39_B_AK";
		_carbine_mag_tr = "hlc_30Rnd_545x39_t_ak";
		_primaryCarbine = ["GVL_X2000_point"];
		
		_LMG = "LMG_Mk200_F";
		_LMG_mag = "200Rnd_65x39_cased_Box_Tracer";
		_LMG_mag_tr = "200Rnd_65x39_cased_Box_Tracer";
		_primaryLMG = ["GVL_X2000_point"];

		// Rifleman AT
		_LAT = "launch_RPG32_F";
		_LATmag = "RPG32_F";

		// Rifleman AT
		_MAT = "launch_RPG32_F";
		_MATmag1 = "RPG32_F";
		_MATmag2 = "RPG32_HE_F";
	};
};

	// ==================
	// Infantry
	_baseHelmet = ["H_Booniehat_khk_hs","H_Cap_headphones","H_Bandanna_sgg","H_Cap_oli","H_Bandanna_gry","G_Bandanna_tan","H_Watchcap_blk","H_Watchcap_camo","H_Watchcap_cbr","H_Watchcap_camo","H_Watchcap_khk","H_Booniehat_khk","CUP_H_USArmy_Helmet_Pro"] call BIS_fnc_selectRandom;
	_baseUniform = ["CUP_U_C_Woodlander_04","CUP_U_C_Woodlander_03","CUP_U_C_Woodlander_02","CUP_U_C_Woodlander_01","CUP_U_O_TK_MixedCamo","CUP_U_O_Partisan_TTsKO_Mixed","CUP_U_I_GUE_Woodland1","CUP_U_I_GUE_Flecktarn2","U_C_HunterBody_grn","U_BG_Guerilla3_1","U_BG_Guerilla2_3","U_BG_Guerilla2_1","U_BG_Guerrilla_6_1","CUP_U_I_GUE_Anorak_03"] call BIS_fnc_selectRandom;
	_baseVest = ["V_TacVestIR_blk","V_TacVest_oli","V_TacVestIR_blk"] call BIS_fnc_selectRandom;
	_baseGlasses = ["G_Combat","G_Bandanna_oli","G_Bandanna_beast","G_Bandanna_khk","G_Bandanna_shades","G_Bandanna_tan","CUP_FR_NeckScarf2"] call BIS_fnc_selectRandom;

	// Echo Helo
	_pilotHelmet = "H_PilotHelmetHeli_O";
	_pilotUniform = "U_I_pilotCoveralls";
	_pilotVest = "V_TacVest_oli";

	// Echo Ground
	_pilotHelmetG = "H_PilotHelmetHeli_B";
	_pilotUniformG = ["CUP_U_C_Woodlander_04","CUP_U_C_Woodlander_03","CUP_U_C_Woodlander_02","CUP_U_C_Woodlander_01","CUP_U_O_TK_MixedCamo","CUP_U_O_Partisan_TTsKO_Mixed","CUP_U_I_GUE_Woodland1","CUP_U_I_GUE_Flecktarn2","U_C_HunterBody_grn","U_BG_Guerilla3_1","U_BG_Guerilla2_3","U_BG_Guerilla2_1","U_BG_Guerrilla_6_1","CUP_U_I_GUE_Anorak_03"] call BIS_fnc_selectRandom;
	_pilotVestG = "V_TacVest_oli";
		
	// Echo Plane
	_pilotHelmetP = "H_PilotHelmetFighter_B";
	_pilotUniformP = "U_B_PilotCoveralls";
	_pilotVestP = "V_TacVest_oli";

	// Backpacks
	_bagRifleman = ["CUP_B_Bergen_BAF","B_Kitbag_cbr","B_Kitbag_rgr","B_Kitbag_mcamo","B_AssaultPack_rgr"] call BIS_fnc_selectRandom;
	_bagAG = ["B_Carryall_cbr","B_Carryall_oli"] call BIS_fnc_selectRandom;
	_radioAirBackpack = "tf_rt1523g_big_rhs";
	_radioBackpack = "tf_rt1523g_big_rhs";
	_bagPilot = "B_Parachute";