// ====================================================================================
// *
// *	Author: GuzzenVonLidl
// *
// *	Description:
// *		This function is handeled by the server and makes sure that
// *		Each time a player dies that person will lose a ticket
// *		And eventually be moved to spectator
// *
// *	Usage:
// *		[player] spawn GVL_Fnc_RestoreLife;
// *
// *	Parameter(s):
// *		#0	Object:		The player
// *
// *	Returning Value:
// *		Nothing
// *
// ====================================================================================

	_player = (_this select 0);

	[[[], {

		[] call f_fnc_ForceExit;
		player enableSimulation false;
		sleep 2;
		titleText ["", "BLACK FADED",0];
		[5, [], "{}", "Admin gave you a second chance", "{}"] call AGM_Core_fnc_progressBar;
		sleep 5;
		titleText ["","PLAIN",0];
	    player setVariable ["GVL_RespawnLimit_Lives",0,true];
		player setPosATL getMarkerPos "respawn_west";
		player allowDamage true;
		player enableSimulation true;

	}], "bis_fnc_call", _player] call BIS_fnc_MP;

	_DebugName = "GVL_Fnc_RestoreLife";
	scriptName _DebugName;
	[["Unit: %1 ",name _player],[_DebugName,__FILE__],"log"] call GVL_Fnc_DebugLog;
