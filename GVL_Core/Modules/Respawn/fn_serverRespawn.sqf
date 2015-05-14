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
// *		[player] spawn GVL_Fnc_serverRespawn;
// *
// *	Parameter(s):
// *		#0	Object:		The player
// *
// *	Returning Value:
// *		Nothing
// *
// ====================================================================================

	private ["_DebugName","_player","_playerUID","_tickets"];

	_player = (_this select 0);
	_playerUID = _player getVariable "GVL_Player" select 1;
    _tickets = (_player getVariable "GVL_RespawnLimit_Lives") - 1;
    _player setVariable ["GVL_RespawnLimit_Lives",_tickets,true];

	GVL_RespawnLimit_ServerDead pushBack _playerUID;
	if (_tickets == -1) then {	GVL_RespawnLimit_ServerDeadPermanent pushBack _playerUID;	};

	[[[_tickets], {
		GVL_RespawnLimit_ServerRespawns = (_this select 0);

		if (GVL_RespawnLimit_ServerRespawns == -1) then {
			systemChat "You are out of tickets, moving you to spectator";
			["jail"] spawn GVL_Fnc_ConnectionHandler;
		} else {
			if (GVL_RespawnLimit_ServerRespawns == 0) then {
				systemChat "This is your last/ Only ticket. use your life carefully";
			};
			if (GVL_RespawnLimit_ServerRespawns >= 1) then {
				systemChat format ["Tickets remaining %1", GVL_RespawnLimit_ServerRespawns];
			};
			player setPosATL (getMarkerPos ([_player] call GVL_Fnc_GetSide));
		};

	}], "bis_fnc_call", _player] call BIS_fnc_MP;

	_DebugName = "GVL_Fnc_serverRespawn";
	scriptName _DebugName;
	[["Unit: %1 || Respawns: %2 ",_player, _tickets],[_DebugName,__FILE__],"log"] call GVL_Fnc_DebugLog;
