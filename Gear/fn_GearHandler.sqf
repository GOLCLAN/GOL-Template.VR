// ====================================================================================
// *
// *	Author: GuzzenVonLidl
// *
// *	Description:
// *		Describe your function
// *
// *	Usage:
// *		[player,"pl"] call GOL_Fnc_GearHandler;
// *
// *	Parameter(s):
// *		#0	String:		Spawning Location, either marker or object
// *
// *	Returning Value:
// *		Nothing
// ====================================================================================

	//	INTERPRET PASSED VARIABLES
	private [
		"_unit","_typeofUnit","_isMan","_isCar","_isTank","_camo","_captivity","_Color","_boxConfigs","_item","_DebugName",
		"_nightTime","_AllowNVG","_weaponCamo","_camoflage","_state","_factionValue","_factionScript",
		"_map","_compass","_watch","_gps","_bino","_rangefinder","_laser","_laserb","_rangecard","_rangecard88","_sprayG","_sprayR","_sprayB","_sprayBl",
		"_nvg","_toolkit","_IRStrobe","_radio152","_radio1000a",
		"_cTab","_Android","_microDAGR","_HelmetCam","_DAGR",
		"_mapTools","_kestrel","_barrel","_earplugs","_cables",
		"_demoCharge","_satchelCharge","_clacker","_defusalKit",
		"_FAKBig","_FAKSmall","_bandage","_bandagePacking","_bandageElastic","_morph","_epi","_blood",
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
		"_baseHelmet","_baseHelmetALT","_baseUniform","_baseUniformALT","_baseVest","_baseGlasses",
		"_pilotHelmet","_pilotUniform","_pilotVest",		
		"_pilotHelmetG","_pilotUniformG","_pilotVestG",
		"_pilotHelmetP","_pilotUniformP","_pilotVestP",		
		"_bagRifleman","_bagAG","_radioAirBackpack","_radioBackpack","_bagPilot",
		"_secondaryAttachments","_primaryAttachments",
		"_ak545","_ak545_t","_ak762","_ak762_t","_stanag_mag","_stanag_mag_t","_stanag_65_mag","_stanag_65_mag_t","_dmr_762","_dmr_762_t","_glHER","_glsmokeWR","_glsmokeGR","_glsmokeRR"		
	];
	
	//	====================================================================================

	//	The following interpret formats what has been passed to this script element
	_unit = [_this, 0, player, [objNull]] call BIS_fnc_param;	// Defines the unit
	if !(local _unit) exitWith {false};	// Exits if script is not local
	_isMan = _unit isKindOf "CAManBase";	// We check if we're dealing with a soldier or a vehicle
	_isCar = _unit isKindOf "Car";
	_isTank = _unit isKindOf "Tank";

	if (_isMan) then {
		if ((count _this == 1) && (!isNil {(_unit getVariable "GOL_Loadout")})) then {
			_typeofUnit = ((_unit getVariable "GOL_Loadout") select 0);
		} else {
			_typeofUnit = toLower([_this, 1, "r", [""]] call bis_fnc_param);
		};

		if (captive _unit) then { _captivity = captiveNum _unit; _unit setCaptive false; } else { _captivity = 0; };

		_unit setVariable ["ACE_Medical_MedicClass", 0, true];	// Is Not Medic
		_unit setVariable ["ACE_GForceCoef", 0.60, true];	// Is Pilot
		_unit setVariable ["ACE_hasEarPlugsIn", true, true];

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
		
		//hint format["FACTION: %1", GOL_Faction_Indep];

		switch (_factionValue) do {
		    case true: {
				[] call compile preprocessFileLineNumbers ("Gear\Factions\" + _factionScript +".sqf");
		    };

		    case false: {
				#include "Factions\Default.sqf"
		    };
		};

		switch (true) do {
		    case (_typeofUnit in ["pl","sl","ftl","pi"]): {
				_Color = "GREEN";
		    };
		    case (_typeofUnit in ["r","g"]): {
				_Color = "RED";
		    };
		    case (_typeofUnit in ["ag","ar","lr","pg"]): {
				_Color = "BLUE";
		    };
		    case (_typeofUnit in ["fac","p"]): {
				_Color = "YELLOW";
		    };
		    default {
				_Color = "WHITE";
		    };
		};

	//	====================================================================================

		if !(_captivity == 0) then { _unit setCaptive _captivity; };
		[] call GOL_Fnc_Attachments;
		_unit selectWeapon primaryWeapon _unit;
		_unit setVariable ["GOL_GroupColor", _Color];	// Keeping it for backward compatibility
		_unit assignTeam _Color;

		[_unit] Spawn {
			private ["_unit"];
			waitUntil {sleep 0.1; !isNull player};
			_unit = _this select 0;
			if (!local _unit || !alive _unit) exitWith {false};
			_unit switchMove "AmovPknlMstpSlowWrflDnon";
			sleep 2;
			if (isPlayer _unit) then {
				if ((["Gear", "FullGear"] call GOL_Fnc_GetConfig) == 1) then {
					if !(isNil "GOL_Gear_Respawn") Then { player removeEventHandler ["respawn", GOL_Gear_Respawn]; };
					GOL_Gear_Respawn = player addEventHandler ["respawn", { [player, (player getVariable "GOL_Loadout") select 0] call GOL_Fnc_GearHandler; } ];
				};
				if (player distance (markerPos ([_unit] call GOL_Fnc_GetSide)) <= 100) then {
					[_unit, currentWeapon _unit, currentMuzzle _unit] call ACE_SafeMode_fnc_lockSafety;
					waitUntil {sleep 5; player distance (markerPos ([_unit] call GOL_Fnc_GetSide)) > 100};
					if ((currentWeapon _unit) in (_unit getVariable ["ACE_SafeMode_safedWeapons", []])) then {
						[_unit, currentWeapon _unit, currentMuzzle _unit] call ACE_SafeMode_fnc_unlockSafety;
					};
				};
			};
		};

	//	====================================================================================
	} else {	// Object / Vehicle
	//	====================================================================================

		if (isServer) Then {
			_typeofUnit = [_this, 1, "", ["",[]]] call BIS_fnc_param;
			_boxConfigs = [_this, 2, [true,true,false], [[]]] call BIS_fnc_param;	// Defines the unit

			if (!_isCar && !_isTank) then {	// box
				[_unit,_typeofUnit,_boxConfigs] spawn GOL_Fnc_GearCargo;
			};

		};
	};

	if (!isMultiplayer && !(_unit isEqualTo player) && _isMan) exitWith {false};	// Prevents ai spaming the rpt
	_DebugName = "GOL_Fnc_GearHandler";
	scriptName _DebugName;
	[["Unit: %1 || Loadout: %2 ",_unit, _typeofUnit],[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
	
	if !(isMultiplayer) then {
		{
			private _unit = _x;
			{
				_unit disableAI _x;
			} forEach ["TARGET","AUTOTARGET","MOVE","ANIM","FSM","CHECKVISIBLE"];
		} forEach switchableUnits;

	};
