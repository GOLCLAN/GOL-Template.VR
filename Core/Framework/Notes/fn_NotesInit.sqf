
	if (isMultiplayer && !hasInterface) exitWith {false};

	private ["_Credits","_loop","_GOL_AdminZeus","_Adminbriefing","_revive","_jip","_tickets","_modulesACE","_count","_string","_value","_modulesArray","_notesACE","_notesFramework","_dac","_aiFaction","_factionWest","_factionEast","_factionIndep","_wave","_updateRate","_minPlayers","_admin","_commandSignal"];

	player createDiarySubject ["GOL_Notes","Notes"];
	[] spawn GOL_Fnc_GearLoadout;
	if (time < 5) then {
		[] spawn GOL_Fnc_Roster;
	} else {
		[[[], {	[] spawn GOL_Fnc_Roster; }], "bis_fnc_call", true] call BIS_fnc_MP;
	};

	#include "Notes.sqf";
	player createDiaryRecord ["Log", ["Credits",_Credits]];
	player createDiaryRecord ["Log", ["Framework",_notesFramework]];
	player createDiaryRecord ["Diary", ["Command Signals",_commandSignal]];
	Fnc_getVariables(GOL_Module_Weather, "ACE Weather");
	Fnc_getVariables(GOL_Module_Wind, "ACE Wind");
	Fnc_getVariables(GOL_Module_MedicalRevive, "ACE Medical Revive");
	Fnc_getVariables(GOL_Module_MedicalAdv, "ACE Medical Advanced");
	Fnc_getVariables(GOL_Module_MedicalBasic, "ACE Medical Basic");

// ================================================================
