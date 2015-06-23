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
// *		Returning if there is a headless client and its functions
// *
// ================================================================

	if (!isMultiplayer || isNil "HCSlot") then {
		if (isNil "HeadlessVariable") then {
			HeadlessVariable = false;
		};
	} else {
		HeadlessVariable = true;
	};

	// ===============================================

	HeadlessController = if (!isMultiplayer || isNil "HCSlot")  Then {
		isServer;
	} else {
		switch (HeadlessVariable) do {
			case true: {
				(!isServer) && {player isEqualTo HCSlot}
			};
			case false: {
				isServer
			};
		};
	};

	// ===============================================

	if (isServer) then {
		[] spawn {
			publicVariable "HeadlessVariable";
			publicVariable "HeadlessController";
		};
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
