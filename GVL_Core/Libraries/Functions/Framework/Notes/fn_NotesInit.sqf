
	if (isMultiplayer && !hasInterface) exitWith {false};

	private ["_Credits","_loop","_GVL_AdminZeus","_Adminbriefing","_revive","_jip","_tickets","_modulesAGM","_count","_string","_value","_modulesArray","_notesAGM","_notesFramework","_asr","_aiFaction","_factionWest","_factionEast","_factionIndep","_wave","_updateRate","_minPlayers","_admin","_commandSignal"];

	player createDiarySubject ["GVL_Notes","Notes"];
	[] spawn GVL_Fnc_GearLoadout;
	[] spawn GVL_Fnc_MapDimmer;
	if (time < 5) then {
		[] spawn GVL_Fnc_Roster;
	} else {
		[[[], {	[] spawn GVL_Fnc_Roster; }], "bis_fnc_call", true] call BIS_fnc_MP;
	};

	#include "Notes.sqf";
	player createDiaryRecord ["Log", ["Credits",_Credits]];
	player createDiaryRecord ["Log", ["Framework",_notesFramework]];
	player createDiaryRecord ["Diary", ["Command Signals",_commandSignal]];
	Fnc_getVariables(GVL_Module_Medical, "AGM Medical");
	Fnc_getVariables(GVL_Module_Logistic, "AGM Logistics");
	Fnc_getVariables(GVL_Module_Respawn, "AGM Respawn");

// ================================================================
