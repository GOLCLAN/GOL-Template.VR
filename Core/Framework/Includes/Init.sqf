
	if (isMultiplayer && !hasInterface) exitWith {false};

	[] spawn {
		if ((player getVariable "GOL_Player") select 2) then {
		    waitUntil {sleep 0.5; !isNull player};
		};

		if (!isNil {(player getVariable "GOL_Loadout")}) then {
			[player] call GOL_Fnc_GearHandler;
		};

		private ["_Credits","_loop","_GOL_AdminZeus","_Adminbriefing","_revive","_jip","_tickets","_modulesACE","_count","_string","_value","_modulesArray","_notesACE","_notesFramework","_dac","_aiFaction","_factionWest","_factionEast","_factionIndep","_wave","_updateRate","_minPlayers","_admin","_commandSignal"];

		player createDiarySubject ["GOL_Notes","Notes"];

		#include "GearLoadout.sqf";

		if ((player getVariable "GOL_Player") select 2) then {
			[[], "GOL_Fnc_Roster", true, false, false] call BIS_fnc_MP;
		} else {
			[] spawn GOL_Fnc_Roster;
		};

		#include "Notes.sqf";
		player createDiaryRecord ["Log", ["Credits",_Credits]];
		player createDiaryRecord ["Log", ["Framework",_notesFramework]];
		player createDiaryRecord ["Diary", ["Command Signals",_commandSignal]];
	};
	// ================================================================