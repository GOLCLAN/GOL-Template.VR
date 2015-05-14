// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		If there is a headless client connected it will
// *		return its functions true
// *
// *	Usage:
// *		[] call GOL_Fnc_HeadlessClient;
// *
// *	Parameters:
// *		None
// *
// *	Returning Value:
// *		Returning if there is a headless client and its funitions
// *
// ================================================================

		if (isServer) Then {
			if (!isMultiplayer || isNil "HCSlot") then {
				if (isNil "HeadlessVariable") then {
					HeadlessVariable = false;
				};
			} else {
				HeadlessVariable = true;
			};
			publicVariable "HeadlessVariable";
		};

	// ===============================================

		HeadlessController = if (!isMultiplayer || isNil "HCSlot")  Then {
			isServer;
		} else {
			switch (HeadlessVariable) do {
			    case true: {
					(!isServer) && {player == HCSlot}
			    };
			    case false: {
					isServer
			    };
			};
		};

	// ===============================================

		if (isNil "HCSlot2") then {
			HeadlessController2 = HeadlessController;
		} else {
			HeadlessController2 = if (!isMultiplayer)  Then {
				isServer;
			} else {
				switch (HeadlessVariable) do {
				    case true: {
						(!isServer) && {player == HCSlot2}
				    };
				    case false: {
						isServer
				    };
				};
			};
	    };

	    if (isServer) Then {
			publicVariable "HeadlessController";
			publicVariable "HeadlessController2";
	    };

	// ===============================================

		_DebugName = "Headless Check";
		scriptName _DebugName;
		if ((!isNil "HeadlessController") && (HeadlessVariable)) Then {
			["Headless Checking INITIALIZED SUCCESSFULLY",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
			if (serverCommandAvailable "#logout") then {
				systemChat "Loading Headless Client - SUCCESSFULLY";
			};
		} else {
			["Headless Checking initialize failed",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
			if (serverCommandAvailable "#logout") then {
				systemChat "Loading Headless Client - FAILED";
				systemChat "Loading AI on to Server Instead";
			};

		};

	// ===============================================
