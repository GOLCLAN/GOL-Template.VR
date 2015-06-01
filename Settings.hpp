
// *	Settings for the mission
	briefingName = "GOL@127 Template";
	overviewText = "GOL Template";

	author = "GOL Editing Team";					// shown in loading screen and briefing
	Mission_version = "1";
	onLoadName = "";								// Loading screen name
	onLoadMission = "";								// Loading screen text
	loadScreen = "gol_menu\Media\loading.jpg";

	respawn = "BASE";			// Re-spawn type
	respawndelay = 30;			// Re-spawn Time
	respawnOnStart = 0;

	class Header {
			//	Game type, see 'link' for more options	||	https://community.bistudio.com/wiki/Multiplayer_Game_Types
			gameType = Coop; //	Unknown || Coop || DM || Team || CTF || SCont || CTI || FF || Hold

			minPlayers = 1;		//	minPlayers # of players the mission supports
			maxPlayers = 127;	//	maxPlayers # of players the mission supports
	};

// ==============================================================================

// *	Framework settings
	class GOL_FRAMEWORK {

		class Modules {
			Debug_Config = 3;		//	NUMBER:	| 0: Disabled
									//			| 1: Light Debug  -	Only show messages in rtp file
									//			| 2: Advanced Debug - Shows information on screen as well as in rtp file
									//			| 3: Advanced Debug - Only in the mission editor
			DAC_Config = false;		//	BOOL: True: Enables DAC and its content
			AI_Faction = "GOLUS";	//	STRING: Defines the default ai faction from the start of the mission
			// ==============================================================================
			// *			Side: West
			// *			GOLUS: US	||	GOLINS_W: Insurgents	||	GOLDEN: Royal Danish Army
			// *			GOLBAF: BAF	||	GOLGER: Germans			||	GOLTFSPARTAN: USMC TF Spartan
			// *			GOLFIA: FIA	||	GOLUKR: Ukrainian Army	||	GOLIDF: Israeli Defence Forces
			// ==============================================================================
			// *			Side: East
			// *			GOLINS: Insurgents	||	GOLRU: Russians	||	GOLCSAT: CSTAT 2015
			// *			GOLTALI: Taliban	||	GOLGHA_REB: Ghalean Rebels
			// ==============================================================================
			#define	SelectFromWeatherParams	true;	// Allow Admin to select Time of day & weather from the lobby screen | Disable remove entire line
			#define	SelectFromGearParams	true;	// Allow Admin to select Faction for all sides from the lobby screen | Disable remove entire line
			// ==============================================================================
			class Gear {
				FullGear = false;	//	BOOL:	True: Respawned player will respawn with original gear	| False: Player will respawn with what they had when they died
				Camoflage = 0;		//	BOOL:	0: Woodland	| 1: Desert
				Blufor = 5;			//	NUMBER	1: NATO	| 2: FIA		| 3: USMC		|	4: BAF			|	5: IDF			|
				Opfor = 1;			//	NUMBER:	1: CSAT	| 2: Russians	| 3: Guerilla	|	4: Insurgents	|
				Independent = 1;	//	NUMBER:	1: AAF	|
			};
/*
			class Cache {	// Coming soon...	Maybe 0.8
				Enabled = false;	//	BOOL:	True: Enables caching of units & objects applied to the mission
				AutoApply = false;	//	BOOL:	True: Caches all objects exept for the ones with the variable "GOL_Caching" set to false	| False: is vice versa (Only caches the one with the variable set to true)
				Man = 800;			//	Number:	Caching distance from Player on foot
				Land = 1600;		//	Number:	Caching distance from Player in vehicles
				Air = 2000;			//	Number:	Caching distance from Player in the air
			};
*/
		};
	};
