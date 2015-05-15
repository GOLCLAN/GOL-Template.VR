
	switch (true) do {
	    case (_typeofUnit in ["pl","fac","r","ag"]): {
			[[_rifle]] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryRifle;
	    };

	    case (_typeofUnit in ["sl","ftl","g"]): {
			[[_rifleGL]] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryRifleGL;
	    };

	    case (_typeofUnit == "ar"): {
			[[_LMG]] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryLMG;
	    };

	    case (_typeofUnit == "lr"): {
			[[_rifleALT]] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryRifle;
	    };

	    case (_typeofUnit == "p"): {
			[[_carbine]] call GOL_Fnc_AddObjects;
			_primaryAttachments = _primaryCarbine;
	    };
	};
	if (_typeofUnit in ["pl","fac","ftl","ag"]) then {
		[[_rangefinder]] call GOL_Fnc_AddObjects;
	};
	if (_typeofUnit in ["pl","fac","sl","ftl","r","g","ag","ar","lr"]) then {
		[[_pistol]] call GOL_Fnc_AddObjects;
		_secondaryAttachments = _secondaryPistol;
	};
