
	if (isNil "_state") then {
		_state = 0;
	} else {
		_state = 1;
	};

	[_camo] call _camoflage;
	[_camo] call _weaponCamo;

	switch (_state) do {
	    case 0: {

			switch (_typeofUnit) do {
			    case "p": {		ADD_Uniform(_pilotHelmet,_pilotUniform,_pilotVest,_baseGlasses);	};
			    default {		ADD_Uniform(_baseHelmet,_baseUniform,_baseVest,_baseGlasses);		};
			};
			if(_nightTime && _AllowNVG) Then {	ADD_ITEM_LINKED(_nvg);	};

			ADD_ITEM_LINKED(_map);
			ADD_ITEM_LINKED(_compass);
			ADD_ITEM_LINKED(_watch);
			ADD_ITEM_PRIORITY_FOREACH(_bandage, 3);

			if (_typeofUnit in _squad) then {
				ADD_ITEM_LINKED(_radio1000a);
				if (_typeofUnit in _platoon) then {
					ADD_ITEM_PRIORITY(_mapTools);
					ADD_ITEM_PRIORITY(_radio152);
				};
			} else {
				if (_typeofUnit in _platoon) then {
					ADD_ITEM_PRIORITY(_mapTools);
					ADD_ITEM_LINKED(_radio152);
		    		ADD_ITEM_LINKED(_cTab);
				};
			};

			switch (_typeofUnit) do {
			    case "pl": {
					ADD_BACKPACK(_radioBackpack);
			    };
			    case "fac": {
					ADD_BACKPACK(_radioAirBackpack);
			    };
			    case "ftl": {
					ADD_ITEM_LINKED(_Android);
					ADD_ITEM_PRIORITY(_HelmetCam);
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
	    };

	    case 1: {
			switch (_typeofUnit) do {
			    case "pl": {
					[[_rifle]] call GOL_Fnc_AddObject;
					_primaryAttachments = _primaryRifle;
					_unit setVariable ["ACE_Medical_MedicClass", 1, true];
			    };

			    case "fac": {
					[[_rifle]] call GOL_Fnc_AddObject;
					_primaryAttachments = _primaryRifle;
			    };

			    case "ftl": {
					[[_rifleGL]] call GOL_Fnc_AddObject;
					_primaryAttachments = _primaryRifleGL;
			    };

			    case "r": {
					[[_rifle]] call GOL_Fnc_AddObject;
					_primaryAttachments = _primaryRifle;
			    };

			    case "g": {
					[[_rifleGL]] call GOL_Fnc_AddObject;
					_primaryAttachments = _primaryRifleGL;
			    };

			    case "ag": {
					[[_rifle]] call GOL_Fnc_AddObject;
					_primaryAttachments = _primaryRifle;
					_unit setVariable ["ACE_Medical_MedicClass", 1, true];
			    };

			    case "ar": {
					[[_LMG]] call GOL_Fnc_AddObject;
					_primaryAttachments = _primaryLMG;
			    };

			    case "lr": {
					[[_rifleALT]] call GOL_Fnc_AddObject;
					_primaryAttachments = _primaryRifle;
			    };

			    case "p": {
					[[_carbine]] call GOL_Fnc_AddObject;
					_primaryAttachments = _primaryCarbine;
					_unit setVariable ["ACE_Medical_MedicClass", 1, true];
			    };
			};
	    	if (_typeofUnit in _binoArray) then {
				[[_rangefinder]] call GOL_Fnc_AddObject;
	    	};
	    	if (_typeofUnit in _pistolArray) then {
				[[_pistol]] call GOL_Fnc_AddObject;
				_secondaryAttachments = _secondaryPistol;
	    	};
	    };
	};
