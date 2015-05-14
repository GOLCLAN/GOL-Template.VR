//	Based of Skippys platoon roster, Modified by GuzzenVonLidl

	private ["_strGrp","_strFinal","_oldGrp","_newGrp","_unitsArr","_strRole","_strColorGrp"];

	_strGrp 		= "";		//	will contain unit's group name
	_strFinal 		= "";		//	will contain final string to be displayed
	_oldGrp 		= grpNull;	//	group of last checked unit
	_newGrp 		= grpNull;	//	group of current unit
	_unitsArr 		= [];		//	will contain all units that have to be processed
/*
	if (isMultiplayer) then {
		_unitsArr = call CBA_Fnc_Players;
	} else {
		_unitsArr = switchableUnits;
	};
*/
	waitUntil {!isNil "GVL_PlayerList"};
	_unitsArr = GVL_PlayerList;

	{
		if(side _x == side player) then {
			_newGrp = group _x;
			if !(isNil {_x getVariable "GVL_Loadout"}) then {
				switch (_x getVariable "GVL_Loadout") do {
				    case "pl": {
						_strRole = "Platoon Leader: ";
				    };
				    case "fac": {
						_strRole = "Forward Air Controller: ";
				    };
				    case "ftl": {
						_strRole = "Fire Team Leader: ";
				    };
				    case "r": {
						_strRole = "Rifleman ";
				    };
				    case "g": {
						_strRole = "Grenadier: ";
				    };
				    case "ag": {
						_strRole = "Assist. Gunner: ";
				    };
				    case "ar": {
						_strRole = "Automatic Rifleman: ";
				    };
				    case "lr": {
						_strRole = "Light Rifleman: ";
				    };
				    case "p": {
						_strRole = "Pilot: ";
				    };

				    default {
				    	_strRole = "";
				    };
				};
			} else {
		    	_strRole = "";
			};

			_strGrp = "";
			if !(isNil {_x getVariable "GVL_GroupID"}) then { _x setGroupId [(_x getVariable "GVL_GroupID")]; };
			if(_newGrp != _oldGrp) then {
				_strGrp = "<br/>" + (groupID(group _x)) + "<br/>";
				switch (side _x) do {
					case west:{
						_strColorGrp = "'#0066CC'";
					};
					case east:{
						_strColorGrp = "'#990000'";
					};
					case independent:{
						_strColorGrp = "'#339900'";
					};
					case civilian:{
						_strColorGrp = "'#990099'";
					};
				};
			};

			_strFinal =  _strFinal + "<font color="+_strColorGrp+">"+_strGrp+"</font>" + _strRole + name _x + "<br/>";

			_oldGrp = group _x;
		};
	}forEach _unitsArr;

	player createDiarySubject ["roster","Team Roster"];
	player createDiaryRecord ["roster",[format ["Roster - %1", time],_strFinal]];
