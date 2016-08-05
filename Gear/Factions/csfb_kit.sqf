
	#include "functions\macros.sqf"

	REMOVE_ALL;

	switch (_typeofUnit) do {

		case "pl": {
			ADD_Uniform(_baseHelmetALT,_baseUniform,_baseVest,_baseGlasses);
			ADD_BACKPACK(_radioBackpack);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio152);
			ADD_ITEM_LINKED(_cTab);
			NightTimeOnce(_nvg);
			NightTimeOnce(_IRStrobe);
			NightTimeOnce("ACE_Flashlight_XL50");
			[
				[_mapTools],		// Items
				[_pistol_mag,1],	// Magazines
				[_rifleALT_mag,4],
				[_rifleALT_mag_tr,3],
				[_smokegrenadeR,3],
				[_smokegrenadeY,5],
				[_bandage,4, true],
				[_smokegrenadeG,5, true],	// Backpack Slots
				[_rangefinder],
				[_pistol],
				[_rifleALT]
			] call GOL_Fnc_AddObjects;
			_unit setVariable ["ACE_Medical_MedicClass", 1, true];
			_primaryAttachments = _primaryRifle;
			_secondaryAttachments = _secondaryPistol;
			_headGear = headgear player; if(_headGear != _baseHelmetALT) then { player addHeadgear _baseHelmetALT; };
		};

		case "fac": {
			ADD_Uniform(_baseHelmet,_baseUniform,_baseVest,_baseGlasses);
			ADD_BACKPACK(_radioAirBackpack);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio152);
			ADD_ITEM_LINKED(_cTab);
			NightTimeOnce(_nvg);
			NightTimeOnce(_IRStrobe);
			NightTimeOnce("ACE_Flashlight_XL50");
			[
				[_mapTools],
				[_laser],
				[_laserb],
				[_pistol_mag,1],
				[_rifle_mag,4],
				[_smokegrenadeG,3],
				[_smokegrenadeY,3],
				[_smokegrenadeG,6, true],
				[_glsmokeR,10, false],
				[_glsmokeG,10, false],
				[_pistol],
				[_rifleGL]
			] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryRifle;
			_secondaryAttachments = _secondaryPistol;
			_headGear = headgear player; if(_headGear != _baseHelmet) then { player addHeadgear _baseHelmet; };
		};

		case "sl": {
			ADD_Uniform(_baseHelmetALT,_baseUniform,_baseVest,_baseGlasses);
			ADD_BACKPACK(_radioBackpack);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio1000a);
			NightTimeOnce(_nvg);
			NightTimeOnce(_IRStrobe);
			NightTimeOnce("ACE_Flashlight_XL50");
			[
				[_mapTools],
				[_DAGR],
				[_pistol_mag,1],
				[_rifleGL_mag_tr,7],
				[_smokegrenadeY,3],
				[_smokegrenadeG,4],
				[_grenademini,2],
				[_grenade,2],
				[_rifleGL_mag,3, true],
				[_glHE,7, true],
				[_glsmokeR,6, true],
				[_rangefinder],
				[_pistol],
				[_rifleGL],
				[_sprayG]
			] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryRifleGL;
			_secondaryAttachments = _secondaryPistol;
			_headGear = headgear player; if(_headGear != _baseHelmetALT) then { player addHeadgear _baseHelmetALT; };
		};

		case "ftl": {
			ADD_Uniform(_baseHelmet,_baseUniform,_baseVest,_baseGlasses);
			ADD_BACKPACK(_bagRifleman);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio1000a);
			NightTimeOnce(_nvg);
			NightTimeOnce(_IRStrobe);
			NightTimeOnce("ACE_Flashlight_XL50");
			[
				[_radio152],
				[_mapTools],
				[_DAGR],
				[_pistol_mag,1],
				[_rifleGL_mag_tr,7],
				[_smokegrenadeY,3],
				[_smokegrenadeG,4],
				[_grenademini,2],
				[_grenade,2],
				[_rifleGL_mag,3, true],
				[_glHE,7, true],
				[_glsmokeR,6, true],
				[_rangefinder],
				[_pistol],
				[_rifleGL],
				[_sprayG]
			] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryRifleGL;
			_secondaryAttachments = _secondaryPistol;
			_headGear = headgear player; if(_headGear != _baseHelmet) then { player addHeadgear _baseHelmet; };
		};

		case "r": {
			ADD_Uniform(_baseHelmet,_baseUniform,_baseVest,_baseGlasses);
			ADD_BACKPACK(_bagRifleman);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio1000a);
			NightTimeOnce(_nvg);
			NightTimeOnce("ACE_Flashlight_XL50");
			[
				[_pistol_mag,1],
				[_rifle_mag,2],
				[_rifle_mag_tr,3],
				[_smokegrenadeY,2],
				[_grenademini,2],
				[_grenade,1],
				[_LATmag,1, true],
				[_demoCharge,2, true],
				[_satchelCharge,1, true],
				[_clacker,1, true],
				[_defusalKit,1, true],
				[_cables,3, true],
				[_pistol],
				[_rifle],
				[_LAT]
			] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryRifle;
			_secondaryAttachments = _secondaryPistol;
			_headGear = headgear player; if(_headGear != _baseHelmet) then { player addHeadgear _baseHelmet; };
		};

		case "g": {
			ADD_Uniform(_baseHelmet,_baseUniform,_baseVest,_baseGlasses);
			ADD_BACKPACK(_bagRifleman);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio1000a);
			NightTimeOnce(_nvg);
			NightTimeOnce("ACE_Flashlight_XL50");
			[
				[_pistol_mag,1],
				[_rifleGL_mag,2],
				[_rifleGL_mag_tr,3],
				[_smokegrenadeY,2],
				[_smokegrenadeR,2],
				[_grenademini,3],
				[_grenade,2],
				[_LATmag,1, true],
				[_glHE,6, true],
				[_glsmokeW,6, true],
				[_pistol],
				[_rifleGL]
			] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryRifleGL;
			_secondaryAttachments = _secondaryPistol;
			_headGear = headgear player; if(_headGear != _baseHelmet) then { player addHeadgear _baseHelmet; };
			if (GOL_Gear_Extra) then {
				[
					[_LATmag,1, true],
					[_glHE,6, true],
					[_glsmokeW,3, true]
				] call GOL_Fnc_AddObjects;
			};
		};

		case "ag": {
			ADD_Uniform(_baseHelmet,_baseUniform,_baseVest,_baseGlasses);
			ADD_BACKPACK(_bagAG);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio1000a);
			NightTimeOnce(_nvg);
			NightTimeOnce("ACE_Flashlight_XL50");
			[
				[_pistol_mag,1],
				[_rifle_mag,2],
				[_rifle_mag_tr,3],
				[_smokegrenadeY,3],
				[_grenademini,2],
				[_grenade,2],
				[_bandage,15, true],
				[_morph,4, true],
				[_LMG_mag_tr,Count_AG_Mags(_LMG_mag_tr), true],
				[_rangefinder],
				[_pistol],
				[_rifle]
			] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryRifle;
			_secondaryAttachments = _secondaryPistol;
			_headGear = headgear player; if(_headGear != _baseHelmet) then { player addHeadgear _baseHelmet; };
			_unit setVariable ["ACE_Medical_MedicClass", 1, true];
			if (GOL_Gear_Extra) then {
				[
					[_bandage,20, true],
					[_morph,8, true]
				] call GOL_Fnc_AddObjects;
			};
			if (GOL_Gear_Additional) then {
				[
					[_epi,8, true],
					[_blood,2, true]
				] call GOL_Fnc_AddObjects;
			};
		};

		case "ar": {
			ADD_Uniform(_baseHelmet,_baseUniform,_baseVest,_baseGlasses);
			ADD_BACKPACK(_bagRifleman);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio1000a);
			NightTimeOnce(_nvg);
			NightTimeOnce("ACE_Flashlight_XL50");
			[
				[_pistol_mag,1],
				[_smokegrenadeY,2],
				[_grenademini,2],
				[_grenade,2],
				[_LMG_mag,Count_AR_Mags(_LMG_mag), true],
				[_LMG_mag_tr,Count_AR_Mags(_LMG_mag_tr), true],
				[_pistol],
				[_LMG]
			] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryLMG;
			_secondaryAttachments = _secondaryPistol;
			_headGear = headgear player; if(_headGear != _baseHelmet) then { player addHeadgear _baseHelmet; };
		};

		case "p": {
			ADD_Uniform(_pilotHelmet,_pilotUniform,_pilotVest,_baseGlasses);
			ADD_BACKPACK(_radioAirBackpack);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio152);
			ADD_ITEM_LINKED(_cTab);
			NightTimeOnce(_nvg);
			[
				[_bandage,20, true],
				[_morph,5, true],
				[_epi,5, true],
				[_blood,3, true]
			] call GOL_Fnc_AddObjects;
			_unit setVariable ["ACE_Medical_MedicClass", 1, true];
			_headGear = headgear player; if(_headGear != _pilotHelmet) then { player addHeadgear _pilotHelmet; };
		};
		
		case "pg": {
			ADD_Uniform(_pilotHelmetG,_pilotUniformG,_pilotVestG,_baseGlasses);
			ADD_BACKPACK(_radioAirBackpack);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio152);
			ADD_ITEM_LINKED(_cTab);
			NightTimeOnce(_nvg);
			[
				[_laser],
				[_laserb],
				[_rangecard88],
				[_rifleALT],
				[_rifle_mag,2],
				[_bandage,20, true],
				[_morph,5, true],
				[_epi,5, true],
				[_blood,3, true]				
			] call GOL_Fnc_AddObjects;
			_unit setVariable ["ACE_Medical_MedicClass", 1, true];
			_headGear = headgear player; if(_headGear != _pilotHelmetG) then { player addHeadgear _pilotHelmetG; };
		};
		
		case "pi": {
			ADD_Uniform(_pilotHelmetP,_pilotUniformP,_pilotVestP,_baseGlasses);
			ADD_BACKPACK(_bagPilot);
			DEFAULT_UNIFORM;
			ADD_ITEM_LINKED(_radio152);
			ADD_ITEM_LINKED(_cTab);
			NightTimeOnce(_nvg);
			[
				[_bandage,20, true],
				[_morph,5, true],
				[_epi,5, true],
				[_blood,3, true]
			] call GOL_Fnc_AddObjects;
			_unit setVariable ["ACE_Medical_MedicClass", 1, true];
			_headGear = headgear player; if(_headGear != _pilotHelmetP) then { player addHeadgear _pilotHelmetP; };
		};
		
	};

//	====================================================================================