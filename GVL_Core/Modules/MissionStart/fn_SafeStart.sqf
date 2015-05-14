
	if (!hasInterface && !(local player)) exitWith {false};

	switch (GVL_Gamelogic getVariable "GVL_SafeStart_Active") do {
	    case true: {
			player allowDamage false;
			player setCaptive true;
			GVL_SAFTEY_CHECKER = player addEventHandler ["Fired", {deleteVehicle (_this select 6);}];
	    };

	    default {
	    	if !(isNil "GVL_SAFTEY_CHECKER") then {
    		    player removeEventHandler ["Fired", GVL_SAFTEY_CHECKER];
	    	};
			player allowDamage true;
			player setCaptive false;
	    };
	};
