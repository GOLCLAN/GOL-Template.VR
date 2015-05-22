
	_dac = str(["DAC_Config"] call GOL_Fnc_GetConfig);
	_aiFaction = str(["AI_Faction"] call GOL_Fnc_GetConfig);
// ================================================================
	_factionWest = str(["Gear", "Blufor"] call GOL_Fnc_GetConfig);
	_factionEast = str(["Gear", "Opfor"] call GOL_Fnc_GetConfig);
	_factionIndep = str(["Gear", "Independent"] call GOL_Fnc_GetConfig);

// ================================================================

	_notesFramework = "
		<br/>
		<br/>	==============================================
		<br/>	Main settings
		<br/>
		<br/>	DAC Configs:	"+ _dac +"
		<br/>	Default AI Faction:	"+ _aiFaction +"
		<br/>
		<br/>	==============================================
		<br/>
		<br/>	Gear Configuration
		<br/>
		<br/>	West Faction:	"+ _factionWest +"
		<br/>	East Faction:	"+ _factionEast +"
		<br/>	Independent Faction:	"+ _factionIndep +"
		<br/>
		<br/>	==============================================
		<br/>";

	_Credits = "
		<br/>
		<br/>	==============================================
		<br/>
		<br/>	Current Mission in progress:
		<br/>	"+getText(missionConfigFile >> "briefingName")+"
		<br/>	Briefing Summary:
		<br/>	"+getText(missionConfigFile >> "overviewText")+"
		<br/>
		<br/>	==============================================
		<br/>
		<br/>	Made by: "+getText(missionConfigFile >> "author")+"
		<br/>	Version: "+getText(missionConfigFile >> "Mission_version")+"
		<br/>
		<br/>	==============================================
		<br/>
		<br/>	Framework by: "+GOL_Author+"
		<br/>	Version: "+GOL_Version+"
		<br/>
		<br/>	==============================================
		<br/>
		<br/>	Guerrillas of Liberation
		<br/>	Teamspeak: "+GOL_Teamspeak+"
		<br/>	Website: "+GOL_url+"
		<br/>
		<br/>	==============================================
		<br/>";

	_commandSignal = "
		<br/>	--------------------------------------------------------------
		<br/>	=== <font color='#fad425'>CallSigns</font color> ===
		<br/>	-----------------
		<br/>	<font color='#fad425'>Infantry:</font color>
		<br/>	1-Actual - Platoon HQ
		<br/>	Hammer - Forward Air Controller
		<br/>	1-1 - 1st Squad
		<br/>	1-2 - 2nd Squad
		<br/>	1-3 - 3rd Squad
		<br/>	-----------------
		<br/>	<font color='#fad425'>Other:</font color>
		<br/>	Echo 1 - 1st Pilot
		<br/>	Echo 2 - 2nd Pilot
		<br/>	Echo 3 - 3rd Pilot
		<br/>	Echo 4 - 4th Pilot
		<br/>	-----------------
		<br/>	<font color='#fad425'>AirCrafts:</font color>
		<br/>	Raven - Transport Helicopter
		<br/>	Giant - Large Transport Helicopter
		<br/>	Angel - Recon Helicopter
		<br/>	Zeus - Attack Helicopter
		<br/>	Condor - Transport plane
		<br/>	Phantom - Attack plane
		<br/>	--------------------------------------------------------------
		<br/>	=== <font color='#fad425'>SHORT RANGE</font color> ===
		<br/>	<font color='#fad425'>Infantry:</font color>
		<br/>	CH 1 Freq 10 - Used by 1-1
		<br/>	CH 2 Freq 20 - Used by 1-2
		<br/>	CH 3 Freq 30 - Used by Platoon HQ
		<br/>	-----------------
		<br/>	<font color='#fad425'>Other:</font color>
		<br/>	Platoon Net - CH 6 Freq 50.1
		<br/>	Air Support Net - CH 7 Freq 50.2
		<br/>	AAC Net - CH 8 Freq 50.3
		<br/>	--------------------------------------------------------------
		<br/>	=== <font color='#fad425'>LONG RANGE</font color> ===
		<br/>	<font color='#fad425'>Infantry:</font color>
		<br/>	Platoon Net - CH 1 Freq 50.1
		<br/>	Air Support Net - CH 2 Freq 50.2
		<br/>	AAC Net - CH 3 Freq 50.3
		<br/>	Convoy Net - CH 3 Freq 50.5
		<br/>	--------------------------------------------------------------";

	#define Fnc_getVariables(Var,DiaryName)\
		private ["_modulesACE","_count","_string","_value","_modulesArray","_notesACE","_ignore"];\
		_modulesACE = [];\
		_count = (count (allVariables Var));\
		_ignore = ["bis_fnc_initmodules_activate","bis_fnc_moduleinit_status","bis_fnc_initmodules_priroty","bis_fnc_moduleinit_iscuratorplaced","bis_fnc_moduleexecute_activate"];\
		for "_i" from 0 to (_count - 1) do {\
				_string = (allVariables Var select _i);\
				_value = Var getVariable (_string);\
			if !(_string in _ignore) then {\
				_modulesACE pushBack formatText ["%1: %2 <br/>", _string, _value];\
			};\
		};\
		_modulesArray = format ["%1", _modulesACE]; \
		_notesACE = "<br/>	"+ _modulesArray;\
		player createDiaryRecord ["Log", [DiaryName,_notesACE]];

//				diag_log format ["%1: %2 <br/>", _string, _value];\		// Line 112
