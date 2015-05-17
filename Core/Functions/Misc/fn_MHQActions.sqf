// ====================================================================================
// *
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Defines the vehicle as a mhq and makes you able to teleport to it
// *
// *	Usage:
// *		null = [this] spawn GOL_Fnc_MHQActions;
// *
// *	Parameters:
// *		0: Vehicle
// *
// *	Returning Value:
// *		None
// *
// ====================================================================================

	if (!hasInterface) exitWith {false};

	_MHQ = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

	private ["_MHQ","_MHQName"];
	_MHQName = vehicleVarName _MHQ;
	removeAllActions _MHQ;
	removeAllActions gol_flag;

	switch (_MHQ getVariable "GOL_MHQ_Active") do {
	    case true: {
			if (!isNil "mhq") Then {
				gol_flag addAction ["<t color='#FF0000'>Teleport to MHQ</t>"," [player,mhq] call GOL_Fnc_Teleport ",nil,1,false,false,"","((_target distance _this) < 7) && !(vehicle player != player)"];
			};

			_MHQ addAction ["<t color='#FF0000'>Deactivate MHQ</t>"," (_this select 0) setVariable ['GOL_MHQ_Active', false, true]; ",nil,1,false,false,"","((_target distance _this) < 7) && !(vehicle player != player) && (_target getVariable 'GOL_MHQ_Active')"];
			_MHQ addAction ["<t color='#7FFF00'>Teleport to Base</t>", "[player,gol_flag] call GOL_Fnc_Teleport",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];

			_MHQ addAction ["Platoon > Actual"," [player,'pl'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			_MHQ addAction ["Platoon > Forward Air Controller"," [player, 'fac'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			_MHQ addAction ["Squad > Squad Leader"," [player,'sl'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			_MHQ addAction ["Squad > Fire Team Leader"," [player,'ftl'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			_MHQ addAction ["Squad > Rifleman"," [player,'r'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			_MHQ addAction ["Squad > Grenadier"," [player,'g'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			_MHQ addAction ["Squad > Asst. Gunner"," [player,'ag'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			_MHQ addAction ["Squad > Automatic Rifleman"," [player,'ar'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			_MHQ addAction ["Squad > Light Rifleman"," [player,'lr'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
			_MHQ addAction ["Echo > Pilot"," [player,'p'] call GOL_Fnc_GearHandler; ",nil,1,false,false,"","((_target distance _this) < 5) && !(vehicle player != player)"];
	    };

	    default {
			_MHQ addAction ["<t color='#FF0000'>Activate MHQ</t>"," (_this select 0) setVariable ['GOL_MHQ_Active', true, true]; ",nil,1,false,false,"","((_target distance _this) < 7) && !(vehicle player != player) && !(_target getVariable 'GOL_MHQ_Active')"];
	    };
	};
