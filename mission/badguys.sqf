
if (isMultiplayer && hasInterface) exitWith {false};		// Ensures only server or HC runs this script
//	GOL_UnitVarMove = ([0,0,-1] call BIS_fnc_selectRandom)
//	(Default: 0,0,-1), makes units have 1 out of 3 change to be able to move when under fire
//	0 disables movement while -1 resets it

switch (_this select 0) do {
	case 1: {	// Zone 1
		[[1], "GOL_Buildings", false] call BIS_fnc_MP;

	};

	case 2: {	// Zone 2
		[[2], "GOL_Buildings", false] call BIS_fnc_MP;

	};

	case 3: {	// Zone 3
		[[3], "GOL_Buildings", false] call BIS_fnc_MP;

	};
};




/*
	---[TIPS]---16/05/2015

	Tip 1. Don't migrate the template, simply rename the folder of this template so for example change GOL-Template.VR to GOL-Template.Stratis the template can then be loaded on Stratis.
			If you migrate the template to another map then you will need to copy over all of the scripts and you will need to set all the units to playable.

	Tip 2. If you want to start making missions then keep it simple and build up from there. If you try and build something complex then you're just going to end up getting stuck and confused.
			Get used to how everything works, don't worry about the mission not being interesting or fun, some of the best missions we've played have been simple ones.

	Tip 3.

	---[TRIGGERS-EXPLAINED]---15/05/2015

	Step 1. Each trigger or zone trigger activates when a player on the ground enters the radius, once this happens ZONE1 will change from being 0 to 1 which will then execute the BadGuys.sqf and then
			run one of the if statements above. When creating a mission the trigger placements should be carefully considered. You should never place a trigger over where players load in. This is
			because some times players load quicker than the HeadlessClient. Placing the ZONE1 trigger over the helicopters or some where you know players will run to at the start of the mission.

	Step 2. So one trigger contains three parts the trigger that activates when players run into the area, this changes the ZONE1 = 0 to ZONE1 = 1, then there is another trigger that detects that
			ZONE1 is equal to 1 and executes the BadGuys.sqf. This file contains all of your unit spawns so because ZONE1 now equals 1 the statement above is true so the script will be ran.
			Finally there is a zone1 marker this should be placed in an open area but hidden from player view.

	Step 3. By default we have three triggers, depending on the side we're playing as you may need to update the activation side on the trigger by default this is set to BLUEFOR. If you want to create a
			new trigger then copy both triggers and a zone marker. Rename the zone marker to zone4 for example and then edit the trigger without a radius, change the condition so that ZONE3 becomes
			ZONE4. Next edit the trigger with the radius and edit the name so that the name looks like zonetrigger4 and make sure this is replicated in the condition of that trigger. Finally change the
			ON ACT to ZONE4 = 1; for example.

	---[USEFUL-SNIPPETS]---13/02/2016
	
			[500,EAST] call GOL_Fnc_CopyAIEdenZeus;
			hint format ["%1 %2", getposatl player, getdir player];copyToClipboard (str(text"this setposATL ") + str(getposatl player) + str(text"; this setDir ") + str(getdir player));
			onMapSingleClick "copyToClipboard format ['%1',_pos]";
			copyToClipboard format ["['zone1', %1, 'UP', 0] spawn Fnc_SpawnUnit;",getPosATL player];
			copyToClipboard format ["['zone1', %1, 'UP'] spawn Fnc_SpawnSniper;",getPosATL player];
			copyToClipboard format ["['Zone1Group1', %1, 1, 'MOVE', 'LINE', 'RED', 'AWARE', 'NORMAL'] spawn Fnc_wayPoint;",getPosATL player];
			["Zone1Group1", [10785.7,8221.48,0.00154114], 1, "MOVE", "LINE", "YELLOW", "AWARE", "NORMAL"] spawn Fnc_wayPoint;
			onMapSingleClick "copyToClipboard format ['%1',_pos]";
			CopyToClipboard format ["['Land_fortified_nest_big_EP1', %1, %2 - 180, 2] spawn Fnc_SpawnBunker;",getPosATL player,getDir player];
			CopyToClipboard format ["['RDS_KORD_high_CSAT', %1, %2] spawn Fnc_StaticWeapon;",getPosATL player,getDir player];
			CopyToClipboard format ["['O_SD_Offroad_01_armed', %1, %2, 1, 2] spawn Fnc_SpawnVehicle;",getPosATL player,getDir player];
			copyToClipboard format ["Weapons: %1 \n\n Magazines: %2 \n\n Items: %3 Vest: %4 \n\n Helmet: %5 \n\n Uniform: %6 \n\n Goggles: %7 \n\n Backpack: %8",weapons player, magazines player, items player, vest player, headgear player, uniform player, goggles player, backPack player];

	---[POPULATE-FUNCTION]---15/05/2015

			Marker Name, Number of units, Maximum distance from Marker units can spawn or travel, Type of units "buildings" or "patrols", Number of units in each group

			["zone1", 10, 150, "buildings", 3] spawn Fnc_Populate;

			["zone2", 5, 250, "patrols", 5] spawn Fnc_Populate;

	---[MOBILE-UNITS]---16/05/2015

			["Zone1Group1", "zone1", 5] spawn Fnc_SpawnGroup;
			sleep 0.3;
			["Zone1Group1", [10785.7,8221.48,0.00154114], 1, "MOVE", "FILE", "YELLOW", "SAFE", "NORMAL"] spawn Fnc_wayPoint;
			["Zone1Group1", [10877.9,8095.71,0.00172424], 2, "MOVE", "FILE", "YELLOW", "SAFE", "NORMAL"] spawn Fnc_wayPoint;
			["Zone1Group1", [10785.7,8221.48,0.00154114], 3, "CYCLE", "FILE", "YELLOW", "SAFE", "NORMAL"] spawn Fnc_wayPoint;
			sleep 2;

			Group Name, Spawn Marker Name, Number of units!

			The next thing we're going to do is create some waypoints. Again We refer to the group Zone1Group1 the next large number is a waypoint location that the units will move to. The number after the large number is
			the waypoint index this should increase with increments of 1 for each waypoint added. Next we have specified the waypoint type which in this case is MOVE, next is the formation that the units should use while
			moving FILE. After this we specify a colour which is basispawny a mode for how the AI will react when they're engaged. Next We have specified NORMAL this is how the AI will hold its weapon while moving and
			finally we specify the speed the unit should move at in this case NORMAL.

			For all of the possible waypoint options you can find them on the wiki page - https://community.bistudio.com/wiki/waypoints

	---[STATIC-UNITS]---15/05/2015

		["zone1", [10843.3,8158.47,0.00177002], "UP", 1] spawn Fnc_SpawnUnit;
		["zone1", [10812.9,8190.88,0.00106812], "UP", 0] spawn Fnc_SpawnUnit;
		["zone1", [10796.8,8177.33,0.00178528], "UP", 0] spawn Fnc_SpawnUnit;
		["zone1", [10777.3,8100.34,0.0014801], "UP", 0] spawn Fnc_SpawnUnit;

		Spawn Marker Name, Position, Stance, Leader 0/1

	---[SPECIAL-UNITS]---15/05/2015

		["zone1", [10843.3,8158.47,0.00177002], "UP", "SN"] spawn Fnc_SpecialUnit;
		["zone1", [10843.3,8158.47,0.00177002], "UP", "AA"] spawn Fnc_SpecialUnit;

		Spawn Marker Name, Position, Stance, Unit Type "SN" or "AA"

	---[STATIC-WEAPONS]---16/05/2015

		["RDS_KORD_high_CSAT", [1897.04,5729.67,0.00145102], 191] spawn Fnc_StaticWeapon;

		Static Weapon class name, Position, Direction

	---[BUNKERS]---16/05/2015
		["Land_fortified_nest_big_EP1", [1844.85,5725.56,0.00143862], 173, 4] spawn Fnc_SpawnBunker;
		Bunkers - Land_fortified_nest_big_EP1 Land_fortified_nest_small_EP1

		Building class name, Position, Direction, Number of units!

	---[VEHICLES]---16/05/2015

		["rhsusf_m1025_w_m2", [1844.85,5725.56,0.00143862], 88, 1, 3] spawn Fnc_SpawnVehicle;

		Vehicle class name, Position, Direction, Static 0/1, Number of units!

		To add waypoints add the following below the above line and make sure that the vehicle isn't in static mode.

		["rhsusf_m1025_w_m2", [22923.9,21013.2,0.00156403], 163, 0, 3] spawn Fnc_SpawnVehicle; sleep 2;
		["VehTeam", [23757.8,20331.1,0.00150299], 1, "MOVE", "WEDGE", "YELLOW", "AWARE", "NORMAL"] spawn Fnc_wayPoint;
		["VehTeam", [22923.9,21013.2,0.00156403], 2, "MOVE", "WEDGE", "YELLOW", "AWARE", "NORMAL"] spawn Fnc_wayPoint;
		["VehTeam", [22923.9,21013.2,0.00156403], 3, "CYCLE", "WEDGE", "YELLOW", "AWARE", "NORMAL"] spawn Fnc_wayPoint;

	---[PLANES]---16/05/2015

		["B_Plane_CAS_01_F", [6451.74,5437.13,0.00148487], 0] spawn Fnc_SpawnPlane;

		Plane class name, Position, Direction

		Adding waypoints for a plane is slightly different because rather than the waypoint index starting from 2 it starts from 1 instead other than that its identical.

		["VehTeam", [12738,12254.1,0.00131989], 1, "MOVE", "WEDGE", "YELLOW", "AWARE", "NORMAL"] spawn Fnc_wayPoint;
		["VehTeam", [10459.2,12414.8,0.00146484], 2, "MOVE", "WEDGE", "YELLOW", "AWARE", "NORMAL"] spawn Fnc_wayPoint;
		["VehTeam", [12738,12254.1,0.00131989], 3, "CYCLE", "WEDGE", "YELLOW", "AWARE", "NORMAL"] spawn Fnc_wayPoint;

	---[PARADROP]---16/05/2015

		["O_Heli_Transport_04_covered_F", "zone1", "NW", 250, 850] spawn Fnc_Paradrop;

		Helicopter class name, Marker to move to, direction to fly in from, altitude in metres, distance from marker to start jumping in metres

		N = North
		NE = North East
		E = East
		SE = South East
		S = South
		SW = South West
		W = West
		NW = North West

	---[CIVILIANS]---16/05/2015

		[10, "zone1", 250] spawn Fnc_SpawnCivilians;

		Number of Civilians, Spawn Marker, Maximum Radius of WayPoints
		So the above example will spawn 10 random civilians that will follow random WayPoints within a Radius of 250 metres of the Spawn Marker.

	--[CLEAN-UP]--16/05/2015

		[] call Fnc_CleanUpSoldier;

		This will remove every enemy AI that has spawned using BadGuys.sqf, its a good idea to run this just below where ZONE3 = 2; for example. It's good for preserving server performance.

		[] call Fnc_CleanUpCivilians;

		Same as above but this time for the Civilians.

	--[FACTIONS]--17/05/2015/

		// OUT OF DATE	- LOOK IN TO GOL_Fnc_EnemyFactions INSTEAD!

		Friendly and enemy factions can be selected using the mission parameters however its possible to override the defaults by editing the description.ext. Like before it's possible to change
		the enemy faction mid mission by including something like the following in your BadGuys.sqf

		if (ZONE2 == 1) then {
			ZONE2 = 2;
			EnemyUnits = ["GOL_PL_TALI","GOL_SL_TALI","GOL_RM_TALI","GOL_AG_TALI","GOL_AR_TALI"];
			EnemySnipers = ["GOL_SN_TALI"];
			EnemyAntiAir = ["GOL_AA_TALI"];
			EnemySide = EAST;

			["zone2", 5, 250, "patrols", 5] spawn Fnc_Populate;
		};

		A list of the enemy factions can be found here --> \Core\Functions\AI\fn_EnemyFactions.sqf

*/
