// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Looks at the item passed to the script and shows it type
// *
// ================================================================
// *	hint typeName []; //ARRAY
// *	hint typeName true; //BOOL
// *	hint typeName {}; //CODE
// *	hint typeName configFile; //CONFIG
// *	hint typeName controlNull; //CONTROL
// *	hint typeName displayNull; //DISPLAY
// *	hint typeName grpNull; //GROUP
// *	hint typeName locationNull; //LOCATION
// *	hint typeName objNull; //OBJECT
// *	hint typeName 0; //SCALAR
// *	hint typeName opfor; //SIDE
// *	hint typeName ""; //STRING
// *	hint typeName parseText ""; //TEXT
// *	hint typeName taskNull; //TASK
// *	hint typeName teamMemberNull; //TEAM_MEMBER
// *	hint typeName missionNamespace; //NAMESPACE

	private ["_type"];
	_type = _this select 0;

	if (typeName _type == "ARRAY") then {	hint "[]";	};

	if (typeName _type == "BOOL") then {	hint "true";	};

	if (typeName _type == "CODE") then {	hint "{}";	};

	if (typeName _type == "CONFIG") then {	hint "configFile";	};

	if (typeName _type == "CONTROL") then {	hint "controlNull";	};

	if (typeName _type == "DISPLAY") then {	hint "displayNull";	};

	if (typeName _type == "GROUP") then {	hint "grpNull";	};

	if (typeName _type == "LOCATION") then {hint "locationNull";	};

	if (typeName _type == "OBJECT") then {	hint "objNull";	};

	if (typeName _type == "SCALAR") then {	hint "0";	};

	if (typeName _type == "SIDE") then {	hint "opfor";	};

	if (typeName _type == "STRING") then {	hint "Text";	};

	if (typeName _type == "TASK") then {	hint "taskNull";	};

	if (typeName _type == "TEXT") then {	hint "parseText";	};

	if (typeName _type == "TEAM_MEMBER") then {	hint "teamMemberNull";	};

	if (typeName _type == "NAMESPACE") then {	hint "missionNamespace";	};
