// ====================================================================================
// *
// *	Author: GuzzenVonLidl
// *
// *	Description:
// *
// *	Usage:
// *		["jail"] call GVL_Fnc_ConnectionHandler;
// *
// *	Parameter(s):
// *		#0	String:
// *			#0	String:	"gear"
// *			#1	String:	"jail"
// *
// *	Returning Value:
// *		Nothing
// *
// ====================================================================================

	private ["_connection","_player","_playerUID","_fadeOut","_Text","_DebugName"];

	_connection = [_this, 0, "", [""]] call BIS_fnc_param;
	_player = player;
	_playerUID = _player getVariable "GVL_Player" select 1;

	waitUntil {sleep 1; GVL_playerSync};

	player enableSimulation false;
	disableUserInput true;
	titleText ["", "BLACK FADED",0];

	switch (_connection) do {
	    case "gear": {
	    	_Text = "Gathering info of your old gear and position";
			[_player, (GVL_Gamelogic getVariable format ["Gear_%1", _playerUID])] call AGM_Respawn_fnc_restoreGear;	// Will make a better script for this
			_player setPosATL ((GVL_Gamelogic getVariable format ["Pos_%1", _playerUID]) select 0);
			_player setDir ((GVL_Gamelogic getVariable format ["Pos_%1", _playerUID]) select 1);
	    };

	    case "jail": {
	    	_Text = "Moving you to a safezone";
	    	[] call _fadeOut;
			removeGoggles _player;
			removeBackpackGlobal _player;
			removeAllAssignedItems _player;
			removeAllItems _player;
			removeAllWeapons _player;

			player allowDamage true;
			player setPosATL getMarkerPos "jail";
			sleep 1;
			[player,player,true] call f_fnc_CamInit;
	    };
	};
	[5, [], "{}", _Text, "{}"] call AGM_Core_fnc_progressBar;
	sleep 5;
	disableUserInput false;
	player enableSimulation true;
	titleText ["","PLAIN",0];

	_DebugName = "GVL_Fnc_ConnectionHandler";
	scriptName _DebugName;
	[["Unit: %1 || Handler: %2 ",_player, _connection],[_DebugName,__FILE__],"log"] call GVL_Fnc_DebugLog;
	true
