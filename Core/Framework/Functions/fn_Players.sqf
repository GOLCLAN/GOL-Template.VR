// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		A simple way to return all players in mutiplayer
// *
// *	Usage:
// *		[] call GOL_Fnc_Players
// *
// *	Parameters:
// *
// *	Returning Value:
// *		Returns all players in multiplayer
// *		Returns player in singleplayer
// *
// ================================================================

	private "_return";

	if (isNil "GOL_PlayerList") then {
		GOL_PlayerList = [];
	};

	_return = if (isMultiplayer) then {
		[playableUnits, { isPlayer _x }] call BIS_fnc_conditionalSelect;
	} else {
		[player];
	};
	_return
