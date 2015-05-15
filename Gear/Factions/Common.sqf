
	[_camo] call _camoflage;
	[_camo] call _weaponCamo;

	switch (_typeofUnit) do {
	    case "p": {		ADD_Uniform(_pilotHelmet,_pilotUniform,_pilotVest,_baseGlasses);	};
	    default {		ADD_Uniform(_baseHelmet,_baseUniform,_baseVest,_baseGlasses);		};
	};

	if(_nightTime && _AllowNVG) Then {	ADD_ITEM_LINKED(_nvg);	};

	ADD_ITEM_LINKED(_map);
	ADD_ITEM_LINKED(_compass);
	ADD_ITEM_LINKED(_watch);
	ADD_ITEM_PRIORITY_FOREACH(_bandage, 3);

	if (_typeofUnit in ["pl","fac","sl","ftl","r","g","ag","ar","lr"]) then {	// Squad
		ADD_ITEM_LINKED(_radio1000a);
	};
	if (_typeofUnit in ["pl","fac","sl","ftl","p"]) then {	// Leaders
		ADD_ITEM_PRIORITY(_mapTools);
	};
	if (_typeofUnit in ["sl","ftl"]) then {	// FTL's
		ADD_ITEM_LINKED(_Android);
		ADD_ITEM_PRIORITY(_HelmetCam);
	};
	if (_typeofUnit in ["pl","fac","p"]) then {	// HQ Team
		ADD_ITEM_LINKED(_cTab);
	};

	switch (_typeofUnit) do {
	    case "pl": {
			ADD_BACKPACK(_radioBackpack);
	    };
	    case "fac": {
			ADD_BACKPACK(_radioAirBackpack);
	    };
	    case "sl": {
			ADD_BACKPACK(_radioBackpack);
	    };
	    case "ftl": {
			ADD_ITEM_LINKED(_radio152);
			ADD_BACKPACK(_bagRifleman);
	    };
	    case "r": {
			ADD_BACKPACK(_bagRifleman);
	    };
	    case "g": {
			ADD_BACKPACK(_bagRifleman);
	    };
	    case "ag": {
			ADD_BACKPACK(_bagAG);
	    };
	    case "ar": {
			ADD_BACKPACK(_bagRifleman);
	    };
	    case "p": {
			ADD_BACKPACK(_radioAirBackpack);
	    };
    };
