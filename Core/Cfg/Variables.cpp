// https://community.bistudio.com/wiki/Description.ext
// ==============================================================================

	#define	true 1
	#define	false 0

// Global Mission Settings
	allowFunctionsLog = 1;
	allowFunctionsRecompile = 1;
	disabledAi = 1;
	enableDebugConsole = 1;
	joinUnassigned = 1;				// Disable auto slotting
	onLoadMissionTime = 1;			// Show time in loading screen
	scriptedPlayer = 1;

// Respawn Settings
	aiKills = 0;
	respawnDialog = 0;

// =====================================
// CleanUp Settings for better performance
	corpseManagerMode = 1;					// Enables this functions below, 0 will disable this
	corpseLimit = 20;						// Max # corpses before CleanUp timer started
	corpseRemovalMinTime = 600;				// 10 MIN
	corpseRemovalMaxTime = 1200;			// 20 MAX

	wreckManagerMode = 1;					// Enables this functions below, 0 will disable this
	wreckLimit = 15;						// Max # wrecks before CleanUp timer started
	wreckRemovalMinTime = 900;				// 15 MIN
	wreckRemovalMaxTime = 1800;				// 30 MAX

// ==============================================================================
