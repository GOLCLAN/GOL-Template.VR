
#include "Common.sqf"

_AllowNVG = true;

// ===========================
// WEAPON SELECTION

_weaponCamo = {
	switch (_this select 0) do {

	    default {
			_pistol = "hgun_ACPC2_F";
			_pistol_mag = "9Rnd_45ACP_Mag";
				_secondaryPistol = [];

			_rifle = "arifle_Mk20_F";
			_rifle_mag = "30Rnd_556x45_Stanag";
			_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Yellow";
				_primaryRifle = ["FHQ_optic_HWS","GVL_X2000_point"];

			_rifleGL = "arifle_Mk20_GL_MRCO_pointer_F";
			_rifleGL_mag = "30Rnd_556x45_Stanag";
			_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Yellow";
				_primaryRifleGL = ["FHQ_optic_HWS","GVL_X2000_point"];

			_rifleALT = "arifle_Mk20C_F";
			_rifleALT_mag = "30Rnd_556x45_Stanag",
			_rifleALT_mag_tr = "30Rnd_556x45_Stanag_Tracer_Yellow";
				_primaryRifleALT = ["FHQ_optic_HWS","GVL_X2000_point"];

			_carbine = "arifle_Mk20C_F";
			_carbine_mag = "30Rnd_556x45_Stanag";
			_carbine_mag_tr = "30Rnd_556x45_Stanag_Tracer_Yellow";
				_primaryCarbine = ["FHQ_optic_HWS","GVL_X2000_point"];

			_LMG = "LMG_Mk200_F";
			_LMG_mag = "200Rnd_65x39_cased_Box";
			_LMG_mag_tr = "200Rnd_65x39_cased_Box_Tracer";
				_primaryLMG = ["FHQ_optic_HWS","GVL_X2000_point"];

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
			_baseHelmet = ["H_HelmetIA_net","H_HelmetIA_camo","H_HelmetIA"] call BIS_fnc_selectRandom;
			_baseUniform = ["U_I_CombatUniform","U_I_CombatUniform_shortsleeve","U_I_CombatUniform_tshirt"] call BIS_fnc_selectRandom;
			_baseVest = ["V_PlateCarrierIA2_dgtl","V_PlateCarrierIA1_dgtl"] call BIS_fnc_selectRandom;
			_baseGlasses = ["G_Combat"] call BIS_fnc_selectRandom;

			// Pilot
			_pilotHelmet = "H_PilotHelmetHeli_I";
			_pilotUniform = "U_I_HeliPilotCoveralls";
			_pilotVest = "V_TacVest_oli";

			// Vehicle Crewman
			_crewHelmet = ["H_HelmetCrew_I"] call BIS_fnc_selectRandom;
			_crewVest = "V_TacVest_oli";

			// Backpacks
			_bagRifleman = "B_FieldPack_oli";
			_bagAG = "B_Carryall_oli";
			_radioAirBackpack = "tf_anprc155_coyote";
			_radioBackpack = "tf_anprc155";
		};
	};
};
