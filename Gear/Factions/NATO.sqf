
	#include "functions\macros.sqf";
	#include "Classes\NATO.sqf";
	#include "Common.sqf";

	switch (_typeofUnit) do {

		case "pl": {
// *		Backpack Slots
			[
				[_smokegrenadeG,5],
				[_bandage,8],
				[_morph,3],
				[_epi,4]
			] call GVL_Fnc_AddObjectBackpack;

// *		Magazines
			[
				[_pistol_mag,2],	// Adds mag to secondary
				[_rifle_mag,5],		//  Adds mags to primary
				[_rifle_mag_tr,5],	//   Adds mags tracers to primary
				[_smokegrenadeW,2],
				[_smokegrenadeR,3],
				[_smokegrenadeY,3],
				[_grenademini,3],
				[_grenade,3]
			] call GVL_Fnc_AddObject;
		};

		case "fac": {
			[
				[_smokegrenadeG,5],
				[_smokegrenadeY,5],
				[_smokegrenadeW,5]
			] call GVL_Fnc_AddObjectBackpack;

			[
				[_pistol_mag,2],
				[_rifle_mag,5],
				[_rifle_mag_tr,5],
				[_smokegrenadeG,3],
				[_smokegrenadeY,2],
				[_grenademini,1]
			] call GVL_Fnc_AddObject;
		};

		case "ftl": {
			[
				[_rifleGL_mag,10],
				[_glHE,7],
				[_glsmokeW,3],
				[_glsmokeR,2]
			] call GVL_Fnc_AddObjectBackpack;

			[
				[_pistol_mag,2],
				[_rifleGL_mag_tr,5],
				[_smokegrenadeW,2],
				[_smokegrenadeR,3],
				[_smokegrenadeY,3],
				[_grenademini,3],
				[_grenade,3]
			] call GVL_Fnc_AddObject;
		};

		case "r": {
			[[_LATmag,1]] call GVL_Fnc_AddObjectBackpack;

// *		Magazines
			[
				[_pistol_mag,2],
				[_rifle_mag,5],
				[_rifle_mag_tr,5],
				[_smokegrenadeW,2],
				[_grenademini,2],
				[_grenade,1],
				[_LAT]
			] call GVL_Fnc_AddObject;

// *		Weapons with attachements
			removeBackpackGlobal _unit;
		};

		case "g": {
// *		Backpack Slots
			if (GVL_Gear_Extra) then {
				[
					[_LATmag,2],
					[_glHE,12],
					[_glsmokeW,6]
				] call GVL_Fnc_AddObjectBackpack;
				} else {
				[
					[_LATmag,1],
					[_glHE,6],
					[_glsmokeW,6]
				] call GVL_Fnc_AddObjectBackpack;
			};

			[
				[_pistol_mag,2],
				[_rifleGL_mag_tr,5],
				[_smokegrenadeW,2],
				[_smokegrenadeR,2],
				[_grenademini,3],
				[_grenade,2]
			] call GVL_Fnc_AddObject;
		};

		case "ag": {
			if (GVL_Gear_Extra) then {
				[
					[_bandage,30],
					[_morph,8]
				] call GVL_Fnc_AddObjectBackpack;

				if (GVL_Gear_Additional) then {
					[
						[_epi,5],
						[_blood,2]
					] call GVL_Fnc_AddObjectBackpack;
				};
			} else {
				[
					[_bandage,20],
					[_morph,6]
				] call GVL_Fnc_AddObjectBackpack;
			};

			[
				[_LMG_mag_tr,Count_AG_Mags(_LMG_mag_tr)]
			] call GVL_Fnc_AddObjectBackpack;

			[
				[_pistol_mag,2],
				[_rifle_mag,5],
				[_rifle_mag_tr,5],
				[_smokegrenadeW,3],
				[_grenademini,2],
				[_grenade,2]
			] call GVL_Fnc_AddObject;
		};

		case "ar": {
			[
				[_LMG_mag,Count_AR_Mags(_LMG_mag)],
				[_LMG_mag_tr,Count_AR_Mags(_LMG_mag_tr)]
			] call GVL_Fnc_AddObjectBackpack;

			[
				[_pistol_mag,2],
				[_smokegrenadeW,2],
				[_grenademini,2],
				[_grenade,2]
			] call GVL_Fnc_AddObject;
		};

		case "lr": {
			[
				[_pistol_mag,2],
				[_rifleALT_mag,5],
				[_rifleALT_mag_tr,5],
				[_smokegrenadeW,2],
				[_grenademini,2],
				[_grenade,1]
			] call GVL_Fnc_AddObject;
		};

		case "p": {
			[
				[_bandage,20],
				[_morph,5],
				[_epi,5],
				[_blood,3]
			] call GVL_Fnc_AddObjectBackpack;

			[
				[_pistol_mag,2],
				[_carbine_mag,5],
				[_carbine_mag_tr,5],
				[_smokegrenadeW,2],
				[_smokegrenadeP,3],
				[_grenademini,1]
			] call GVL_Fnc_AddObject;
			_unit setVariable ["AGM_IsMedic", true, true];
		};

	};
//	====================================================================================

	#include "Common.sqf";
