
#include "Common.sqf";

_AllowNVG = true;

// ===========================
// WEAPON SELECTION

_weaponCamo = {
	switch (_this select 0) do {
	    default {
			_pistol = "CUP_hgun_Glock17";
			_pistol_mag = "CUP_17Rnd_9x19_glock17";
				_secondaryPistol = [];

			_rifle = "arifle_TRG21_black_F";
			_rifle_mag = "30Rnd_556x45_Stanag";
			_rifle_mag_tr = "30Rnd_556x45_Stanag";
				_primaryRifle = ["FHQ_optic_MARS","acc_pointer_IR"];

			_rifleGL = "arifle_TRG21_black_GL_F";
			_rifleGL_mag = "30Rnd_556x45_Stanag";
			_rifleGL_mag_tr = "30Rnd_556x45_Stanag";
				_primaryRifleGL = ["FHQ_optic_MARS","acc_pointer_IR"];

			_rifleALT = "arifle_TRG21_black_F";
			_rifleALT_mag = "30Rnd_556x45_Stanag";
			_rifleALT_mag_tr = "30Rnd_556x45_Stanag";
				_primaryRifleALT = ["FHQ_optic_MARS","acc_pointer_IR"];

			_carbine = "arifle_TRG20_black_F";
			_carbine_mag = "30Rnd_556x45_Stanag";
			_carbine_mag_tr = "30Rnd_556x45_Stanag";
				_primaryCarbine = ["FHQ_optic_MARS","acc_pointer_IR"];

			_LMG = "asdg_LMG_Zafir_F";
			_LMG_mag = "150Rnd_762x51_Box_Tracer_Red";
			_LMG_mag_tr = "150Rnd_762x51_Box_Tracer_Red";
				_primaryLMG = ["FHQ_optic_MARS","acc_pointer_IR"];

			// Rifleman AT
			_LAT = "rhs_weap_M136";
			_LATmag = "rhs_m136_mag";

			// Rifleman AT
			_MAT = "rhs_weap_M136";
			_MATmag1 = "rhs_m136_mag";
			_MATmag2 = "rhs_m136_mag";
		};
	};
};

// ===========================

// CLOTHES AND UNIFORMS
_camoflage = {
	switch (_this select 0) do {
	    default {
			// Infantry
			_baseHelmet = ["IDF_Helmet_CQB_1","IDF_Helmet_CQB_5"] call BIS_fnc_selectRandom;
			_baseUniform = ["IDF_Uniform"] call BIS_fnc_selectRandom;
			
		if (332350 in (getDLCs 1)) then {
				_baseVest = ["V_PlateCarrierIAGL_oli"] call BIS_fnc_selectRandom;
				} else {
			_baseVest = ["IDF_Vest"] call BIS_fnc_selectRandom;
										};
			_baseGlasses = ["SP_Goggles_Black"] call BIS_fnc_selectRandom;

			// Pilot
			_pilotHelmet = "H_PilotHelmetHeli_O";
			_pilotUniform = "SP_0000_Standard_Coverall_GreenOlive";
			_pilotVest = "V_Chestrig_oli";

			// Vehicle Crewman
			_crewHelmet = "H_HelmetCrew_I";
			_crewVest = "SP_BluforMolle1_Green";

			// Backpacks
			_bagRifleman = "B_AssaultPack_khk";
			_bagAG = "B_Carryall_oli";
			_radioAirBackpack = "tf_rt1523g_big_bwmod";
			_radioBackpack = "tf_rt1523g_big_bwmod";
		};
	};
};
