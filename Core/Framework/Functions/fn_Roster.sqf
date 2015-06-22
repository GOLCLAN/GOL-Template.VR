//	Based of Skippys platoon roster, Modified by GuzzenVonLidl

	private ["_strGrp","_strFinal","_oldGrp","_newGrp","_unitsArr","_strRole","_strColorGrp"];

	_strGrp 	= "";		//	will contain unit's group name
	_strFinal 	= "";		//	will contain final string to be displayed
	_oldGrp 	= grpNull;	//	group of last checked unit
	_newGrp 	= grpNull;	//	group of current unit
	_unitsArr	= [];

	{
		if (!isNil {(_x getVariable "GOL_Loadout")}) then {
			_unitsArr pushBack _x;
		};
	} forEach (call GOL_Fnc_Players);	//	will contain all units that have to be processed

	{
		if((side _x) isEqualTo (side player)) then {
			_x setGroupId [((_x getVariable "GOL_Loadout") select 1)];
			_newGrp = group _x;
			switch ((_x getVariable "GOL_Loadout") select 0) do {
			    case "pl": {
					_strRole = "Platoon Leader: ";
			    };
			    case "fac": {
					_strRole = "Forward Air Controller: ";
			    };
			    case "sl": {
					_strRole = "Squad Leader: ";
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
			    case "p": {
					_strRole = "Pilot: ";
			    };
			    default {
			    	_strRole = "";
			    };
			};

			_strGrp = "";
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

	player createDiarySubject ["roster","Platoon Roster"];
	player createDiaryRecord ["roster",[format ["Platoon Roster - %1", time],_strFinal]];
