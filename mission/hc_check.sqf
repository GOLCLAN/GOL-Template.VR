if (!isServer) then { waitUntil{!isNull player}};
if(HCPresent) then {
	if(!hasInterface && !isServer) then {
		execVM "mission\badguys.sqf";
	};
} else {
		if(isServer) then {
			execVM "mission\badguys.sqf";
		};
};

