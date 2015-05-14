// ====================================================================================
// *
// *	Author: GuzzenVonLidl
// *
// *	Description:
// *		When a player joins the server this function desides what will happen
// *
// *	Usage:
// *		[newplayer] spawn GVL_Fnc_Connection;
// *
// *	Parameter(s):
// *		#0	String:		what type of connection
// *
// *	Returning Value:
// *		Nothing
// *
// ====================================================================================

	private ["_DebugName","_connection"];

	#define	ChatMessage(TextInfo)	\
			systemChat format ["%1 %2", name player, TextInfo]; \
			[[[player, TextInfo], { diag_log format ["%1 %2", name (_this select 0),(_this select 1)]; }], "bis_fnc_call", false] call BIS_fnc_MP;

	_connection = [_this, 0, "", [""]] call BIS_fnc_param;
	switch (_connection) do {
	    case "reslot": {	// Bad Reconnect
		    ChatMessage("is trying to re-slot");
			["jail"] spawn GVL_Fnc_ConnectionHandler;
	    };

	    case "newplayer": {	// New Player
		    ChatMessage("connected to server");
	    };

	    case "reconnect": {	// Good Reconnect
		    ChatMessage("reconnected to the server");
			["gear"] spawn GVL_Fnc_ConnectionHandler;
	    };

	    case "jipdenied": {	// New Player Denied
		    ChatMessage("connected, JIP not allowed, sending player to spectator");
			["jail"] spawn GVL_Fnc_ConnectionHandler;
	    };

	    default {
		    ChatMessage("Error with script, moving player to spectator");
			["jail"] spawn GVL_Fnc_ConnectionHandler;
	    };
	};

	_DebugName = "GVL_Fnc_Connection";
	scriptName _DebugName;
	[["Type of Connection: %2 ", _connection],[_DebugName,__FILE__],"log"] call GVL_Fnc_DebugLog;
