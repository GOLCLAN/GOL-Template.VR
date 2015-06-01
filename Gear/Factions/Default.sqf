
	#include "functions\macros.sqf"
	#include "Common.sqf"

	switch (_typeofUnit) do {

		case "pl": {
// *		Backpack Slots
			[
				[_smokegrenadeG,5],
				[_bandage,8],
				[_morph,3],
				[_epi,4]
			] call GOL_Fnc_AddObjectsToBackpack;

// *		Magazines
			[
				[_pistol_mag,2],	// Adds mag to secondary
				[_rifle_mag,5],		//  Adds mags to primary
				[_rifle_mag_tr,5],	//   Adds mags tracers to primary
				[_smokegrenadeR,3],
				[_smokegrenadeY,5],
				[_grenademini,3],
				[_grenade,3]
			] call GOL_Fnc_AddObjects;
			_unit setVariable ["ACE_Medical_MedicClass", 1, true];
		};

		case "fac": {
			[
				[_smokegrenadeG,7],
				[_smokegrenadeY,6]
			] call GOL_Fnc_AddObjectsToBackpack;

			[
				[_pistol_mag,2],
				[_rifle_mag,5],
				[_rifle_mag_tr,5],
				[_smokegrenadeG,3],
				[_smokegrenadeY,2],
				[_grenademini,1]
			] call GOL_Fnc_AddObjects;
		};

		case "sl": {
			[
				[_rifleGL_mag,8],
				[_glHE,7],
				[_glsmokeR,6]
			] call GOL_Fnc_AddObjectsToBackpack;

			[
				[_pistol_mag,2],
				[_rifleGL_mag_tr,5],
				[_smokegrenadeY,3],
				[_smokegrenadeG,4],
				[_grenademini,2],
				[_grenade,2]
			] call GOL_Fnc_AddObjects;
		};

		case "ftl": {
			[
				[_rifleGL_mag,8],
				[_glHE,7],
				[_glsmokeR,6]
			] call GOL_Fnc_AddObjectsToBackpack;

			[
				[_pistol_mag,2],
				[_rifleGL_mag_tr,5],
				[_smokegrenadeY,4],
				[_smokegrenadeG,2],
				[_grenademini,2],
				[_grenade,2]
			] call GOL_Fnc_AddObjects;
		};

		case "r": {
			[
				[_LATmag,1],
				[_demoCharge,2],
				[_satchelCharge,1],
				[_clacker,1],
				[_defusalKit,1],
				[_cables,3]
			] call GOL_Fnc_AddObjectsToBackpack;

// *		Magazines
			[
				[_pistol_mag,2],
				[_rifle_mag,5],
				[_rifle_mag_tr,3],
				[_smokegrenadeY,2],
				[_grenademini,2],
				[_grenade,1],
				[_LAT]
			] call GOL_Fnc_AddObjects;
		};

		case "g": {
// *		Backpack Slots
			if (GOL_Gear_Extra) then {
				[
					[_LATmag,2],
					[_glHE,12],
					[_glsmokeW,6]
				] call GOL_Fnc_AddObjectsToBackpack;
				} else {
				[
					[_LATmag,1],
					[_glHE,6],
					[_glsmokeW,6]
				] call GOL_Fnc_AddObjectsToBackpack;
			};

			[
				[_pistol_mag,2],
				[_rifleGL_mag,5],
				[_rifleGL_mag_tr,3],
				[_smokegrenadeY,2],
				[_smokegrenadeR,2],
				[_grenademini,3],
				[_grenade,2]
			] call GOL_Fnc_AddObjects;
		};

		case "ag": {
			[
				[_bandage,20],
				[_morph,6],
				[_epi,4],
				[_LMG_mag_tr,Count_AG_Mags(_LMG_mag_tr)]
			] call GOL_Fnc_AddObjectsToBackpack;

			if (GOL_Gear_Extra) then {
				[
					[_bandage,20],
					[_morph,8],
					[_epi,8]
				] call GOL_Fnc_AddObjectsToBackpack;
			};
			if (GOL_Gear_Additional) then {
				[
					[_blood,2]
				] call GOL_Fnc_AddObjectsToBackpack;
			};

			[
				[_pistol_mag,2],
				[_rifle_mag,5],
				[_rifle_mag_tr,3],
				[_smokegrenadeY,3],
				[_grenademini,2],
				[_grenade,2]
			] call GOL_Fnc_AddObjects;
			_unit setVariable ["ACE_Medical_MedicClass", 1, true];
		};

		case "ar": {
			[
				[_LMG_mag,Count_AR_Mags(_LMG_mag)],
				[_LMG_mag_tr,Count_AR_Mags(_LMG_mag_tr)]
			] call GOL_Fnc_AddObjectsToBackpack;

			[
				[_pistol_mag,2],
				[_smokegrenadeY,2],
				[_grenademini,2],
				[_grenade,2]
			] call GOL_Fnc_AddObjects;
		};

		case "lr": {
			[
				[_pistol_mag,2],
				[_rifleALT_mag,3],
				[_rifleALT_mag_tr,3],
				[_smokegrenadeY,2],
				[_grenademini,2],
				[_grenade,1]
			] call GOL_Fnc_AddObjects;
		};

		case "p": {
			[
				[_bandage,20],
				[_morph,5],
				[_epi,5],
				[_blood,3]
			] call GOL_Fnc_AddObjectsToBackpack;

			[
				[_pistol_mag,2],
				[_carbine_mag,5],
				[_carbine_mag_tr,5],
				[_smokegrenadeY,2],
				[_smokegrenadeP,3],
				[_grenademini,1]
			] call GOL_Fnc_AddObjects;
			_unit setVariable ["ACE_Medical_MedicClass", 1, true];
		};
	};

//	====================================================================================

	#include "Weapons.sqf"
