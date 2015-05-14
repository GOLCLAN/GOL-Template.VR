
	if (["MissionStart","Enabled"] call GVL_Fnc_GetConfig == 1) then {

		if (["MissionStart","SafeStart"] call GVL_Fnc_GetConfig == 1) then {
			[] spawn GVL_Fnc_SafeStart_Init;
			sleep 1;
			[] spawn GVL_Fnc_SafeStart;
		};

		if (["MissionStart","AreaLimit"] call GVL_Fnc_GetConfig == 1) then {
			AO_Markers = [];
			["respawn_west","spawn_restriction_west"] call GVL_Fnc_AO_Add_Marker;
			["respawn_east","spawn_restriction_east"] call GVL_Fnc_AO_Add_Marker;
			["respawn_guerrila","spawn_restriction_indep"] call GVL_Fnc_AO_Add_Marker;
			[] spawn GVL_Fnc_AO_Limit;
		};

	};
