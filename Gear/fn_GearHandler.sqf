// ====================================================================================
// *
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Handels the gear with faction selected from the lobby screen
// *		Also makes sure that the unit spawns with correct variables and such
// *
// *	Usage:
// *		[this,"pl"] call GOL_Fnc_GearHandler;
// *		[this,"gear_box",[false,true]] call GOL_Fnc_GearHandler;
// *
// *	Parameters:
// *		0: Object:	Unit / Object
// *		1: String:	LoadOut Type
// *		2: Array:	/ Only used for boxes, Look inside fn_GearBox.sqf for more info
// *			0: Boolean: -   Moveable (Default: True)
// *			1: Boolean: -   AllowDamage (Default: False)
// *			2: Boolean: -   Allow gear to be assigend to a vehicle (Default: False)
// *
// *	Returning Value:
// *		None
// *
// ====================================================================================

_this spawn {
	//	INTERPRET PASSED VARIABLES
	private [
		"_unit","_typeofUnit","_isMan","_isCar","_isTank","_camo","_captivity","_Color","_boxConfigs","_item","_DebugName",
		"_platoon","_squad","_binoArray","_pistolArray","_ctabArray","_rifleArray","_rifleGLArray",
		"_nightTime","_AllowNVG","_weaponCamo","_camoflage","_state",
		"_map","_compass","_watch","_gps","_bino","_rangefinder","_laser",
		"_nvg","_toolkit","_IRStrobe","_radio152","_radio1000a",
		"_cTab","_Android","_microDAGR","_HelmetCam",
		"_mapTools","_kestrel","_barrel","_earplugs","_cables",
		"_demoCharge","_satchelCharge","_clacker","_defusalKit",
		"_FAKBig","_FAKSmall","_bandage","_morph","_epi","_blood",
		"_grenade","_grenademini","_flashBang",
		"_smokegrenadeW","_smokegrenadeG","_smokegrenadeR","_smokegrenadeY","_smokegrenadeP",
		"_chemG","_chemR","_chemY","_chemB",
		"_handFlareG","_handFlareR","_handFlareW","_handFlareY",
		"_glHE","_glsmokeW","_glsmokeG","_glsmokeR","_glsmokeY",
		"_glsmokeP","_glsmokeB","_glsmokeO","_glflareW",
		"_glflareG","_glflareR","_glflareY","_glflareIR",
		"_pistol","_pistol_mag","_secondaryPistol",
		"_rifle","_rifle_mag","_rifle_mag_tr","_primaryRifle",
		"_rifleGL","_rifleGL_mag","_rifleGL_mag_tr","_primaryRifleGL",
		"_rifleALT","_rifleALT_mag","_rifleALT_mag_tr","_primaryRifleALT",
		"_carbine","_carbine_mag","_carbine_mag_tr","_primaryCarbine",
		"_LMG","_LMG_mag","_LMG_mag_tr","_primaryLMG",
		"_LAT","_LATmag",
		"_MAT","_MATmag1","_MATmag2",
		"_baseHelmet","_baseUniform","_baseVest","_baseGlasses",
		"_pilotHelmet","_pilotUniform","_pilotVest",
		"_crewHelmet","_crewVest",
		"_bagRifleman","_bagAG","_radioAirBackpack","_radioBackpack",
		"_secondaryAttachments","_primaryAttachments"
	];

	//	The following interpret formats what has been passed to this script element
	_unit = [_this, 0, player, [objNull]] call BIS_fnc_param;	// Defines the unit
	_typeofUnit = [_this, 1, "r", ["",[]]] call BIS_fnc_param;	// What gear the unit should get
	if !(local _unit) exitWith {false};	// Exits if script is not local
	_isMan = _unit isKindOf "CAManBase";	// We check if we're dealing with a soldier or a vehicle
	_isCar = _unit isKindOf "Car";
	_isTank = _unit isKindOf "Tank";

	// ================================================================
	// *	Gear Configurations

	switch ((["Gear", "Blufor"] call GOL_Fnc_GetConfig)) do {
		case 2:	{
			GOL_Faction_West = "FIA";
		};
		case 3:	{
			GOL_Faction_West = "USMC";
		};
		case 4:	{
			GOL_Faction_West = "BAF";
		};
		default	{
			GOL_Faction_West = "NATO";
		};
	};

	switch ((["Gear", "Opfor"] call GOL_Fnc_GetConfig)) do {
		case 2:	{
			GOL_Faction_East = "Russians";
		};
		case 3:	{
			GOL_Faction_East = "Guerillas";
		};
		case 4:	{
			GOL_Faction_East = "Insurgents";
		};
		default	{
			GOL_Faction_East = "CSAT";
		};
	};

	switch ((["Gear", "Independent"] call GOL_Fnc_GetConfig)) do {
		default	{
			GOL_Faction_Indep = "AAF";
		};
	};

	// ================================================================
	// *	Creates backup of the faction if it for some reason would need to reset to the originial

	if (isNil "GOL_Faction_West_Orgi" || isNil "GOL_Faction_East_Orgi" || isNil "GOL_Faction_Indep_Orgi") Then {
		GOL_Faction_West_Orgi = GOL_Faction_West;
		compileFinal GOL_Faction_West_Orgi;
		GOL_Faction_East_Orgi = GOL_Faction_East;
		compileFinal GOL_Faction_East_Orgi;
		GOL_Faction_Indep_Orgi = GOL_Faction_Indep;
		compileFinal GOL_Faction_Indep_Orgi;
	};

	//	====================================================================================
	//	SELECTING FROM PARAMETERS IF EXTRA GEAR IS ENABLED

	GOL_Gear_Additional = false;
	GOL_Gear_Extra = false;
	if (("GOL_Params_Extra_Gear" call BIS_fnc_getParamValue) >= 1) then {
		if (("GOL_Params_Extra_Gear" call BIS_fnc_getParamValue) == 2) then {
			GOL_Gear_Additional = true;
		};
		GOL_Gear_Extra = true;
	};
	_camo = (["Gear", "Camoflage"] call GOL_Fnc_GetConfig);

	//	====================================================================================

	if (_isMan) then {
		if ((_this select 2) != "") Then {	_unit setVariable ["GVL_GroupID", (_this select 2), true];	};
		_unit setVariable ["GVL_Loadout", _typeofUnit, true];
		_unit setVariable ["GVL_Role_Done", false, true];
//		_unit setVariable ["AGM_IsMedic", false, true];	// Is Not Medic
//		_unit setVariable ["AGM_GForceCoef", 0.60, true];	// Is Pilot
//		_unit setVariable ["AGM_hasEarPlugsIn", true, true];

		if (captive _unit) then { _captivity = captiveNum _unit; _unit setCaptive false; } else { _captivity = 0; };

		switch (side _unit) do {
		    case Blufor: {
				[] call compile preprocessFileLineNumbers ("Gear\Factions\Classes\" + GOL_Faction_West +".sqf");
		    };
		    case Opfor: {
				[] call compile preprocessFileLineNumbers ("Gear\Factions\Classes\" + GOL_Faction_East +".sqf");
		    };
		    case Independent: {
				[] call compile preprocessFileLineNumbers ("Gear\Factions\Classes\" + GOL_Faction_Indep +".sqf");
		    };
		};

		#include "Factions\Default.sqf"

		if !(_captivity == 0) then { _unit setCaptive _captivity; };
		[] call GOL_Fnc_Attachments;
		_unit selectWeapon primaryWeapon _unit;
		[_unit, _typeofUnit, _Color, (_this select 2)] Spawn {
		    waitUntil {sleep 0.1; !isNull player};
			_unit = _this select 0;
			if (!local _unit || !alive _unit) exitWith {false};
			if (!isMultiplayer || hasInterface) then {
				_unit switchMove "AmovPknlMstpSlowWrflDnon";
				_unit setVariable ["GOL_Role_Done", true, true];
				sleep 2;
//				[_unit, (_this select 2)] call AGM_Interaction_fnc_joinTeam;
				if (isPlayer _unit) then {
					if !(isNil "GOL_Gear_Respawn") Then { player removeEventHandler ["respawn", GOL_Gear_Respawn]; };
					GOL_Gear_Respawn = player addEventHandler ["respawn", { [player, player getVariable "GOL_Loadout"] call GOL_Fnc_GearHandler; } ];
/*					[_unit, currentWeapon _unit, currentMuzzle _unit] call AGM_SafeMode_fnc_lockSafety;
					waitUntil {sleep 5; player distance (markerPos ([_unit] call GOL_Fnc_GetSide)) > 100; !GOL_Spectator_Enabled};
					if ((currentWeapon _unit) in (_unit getVariable ["AGM_SafeMode_safedWeapons", []])) then {
						[_unit, currentWeapon _unit, currentMuzzle _unit] call AGM_SafeMode_fnc_unlockSafety;
					};	*/
				};
			};
		};

	} else {

	//	====================================================================================
		if (isServer) Then {
			_boxConfigs = [_this, 2, [true,true,false], [[]]] call BIS_fnc_param;	// Defines the unit

			if (!_isMan && !_isCar && !_isTank) then {	// box
				[_unit,_typeofUnit,_boxConfigs] call GOL_Fnc_GearCargo;
			};
/*
	//		If object is a car or a tank
			if (_isCar || _isTank) then {
				private ["_item", "_i"];
				waitUntil {!isNil "AGM_Logistics_loadedItemsDummy"};

				if ((_boxConfigs select 3)) Then {
//						[_unit,["","west"],[_boxConfigs]] call GOL_Fnc_GearHandler;
//						[_unit,["","east"],[_boxConfigs]] call GOL_Fnc_GearHandler;
//						[_unit,["","indep"],[_boxConfigs]] call GOL_Fnc_GearHandler;

				};

				for "_i" from 0 to 1 do {
					_item = ['AGM_JerryCan', [-1000, -1000, 100]] call AGM_Logistics_fnc_spawnObject;
					[_unit, _item] call AGM_Logistics_fnc_initLoadedObject;
				};

				if (_isCar) then {
					for "_i" from 0 to 2 do {
						_item = ['AGM_SpareWheel', [-1000, -1000, 100]] call AGM_Logistics_fnc_spawnObject;
						[_unit, _item] call AGM_Logistics_fnc_initLoadedObject;
					};
				};

				if (_isTank) then {
					for "_i" from 0 to 2 do {
						_item = ['AGM_SpareTrack', [-1000, -1000, 100]] call AGM_Logistics_fnc_spawnObject;
						[_unit, _item] call AGM_Logistics_fnc_initLoadedObject;
					};
				};

				for "_i" from 0 to 2 do {
					_item = ['arma2_crate_empty', [-1000, -1000, 100]] call AGM_Logistics_fnc_spawnObject;
					[_item,["small_box","west"],[true,true]] call GOL_Fnc_GearHandler;
					[_unit, _item] call AGM_Logistics_fnc_initLoadedObject;
				};
			};
*/
		};
	};

	if (!isMultiplayer && !(_unit == player) && _isMan) exitWith {false};	// Prevents ai spaming the rpt
	_DebugName = "GOL_Fnc_GearHandler";
	scriptName _DebugName;
	[["Unit: %1 || Loadout: %2 ",_unit, _typeofUnit],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
};
