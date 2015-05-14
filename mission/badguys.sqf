if (isNil ("ZONE1")) then {
	ZONE1 = 0; 
	ZONE2 = 0; 
	ZONE3 = 0;
};

if (ZONE1 == 1) then {
	ZONE1 = 2;
	["zone1", [493.509,1297.22,0.00143909], "UP", 1] spawn Fnc_SpawnUnit;
};

if (ZONE2 == 1) then {
	ZONE2 = 2;

};

if (ZONE3 == 1) then {
	ZONE3 = 2;
	
};

/*	
	---[TRIGGERS]---
	
	Step 1. Remove the dashes from //execVM "mission\functions.sqf"; in the init.sqf.
			Under this line you should make a list of all the spawning zones you want so ZONE1 = 0; ZONE2 = 0; ZONE3 = 0;
	
	Step 2. Place a Trigger with the size 0 0 & add the following code.
			To the condition add (ZONE1 == 1) and to the act add null = execVM "mission\hc_check.sqf";
			
			The above trigger will run when ZONE1 == 1; so now we need to create another trigger where we will set ZONE1 to 1.			
			
	Step 3. Create another trigger of any size, spawn it zone1trigger then in the condition enter (getPos ((list zone1trigger) select 0) select 2) <= 1 and finally in the act enter ZONE1 = 1;
	
			We have now made a trigger which will only activate when someone runs into it, it can't be activated by someone flying through it. Now that you have created a two triggers you will want 
			something to actually happen when the trigger is activated. Using the the examples below you can spawn units.
			
	Step 4. You need to create an if statement in the badguys.sqf. Basispawny what is happening here is that when a player runs into your trigger ZONE1 changes from 0 to 1. When this happens
			The first trigger that was created will run the spawning script. When the if statement is ran ZONE1 will equal 1 and the code will within the if statement will run. Take note just below the if statement
			we set ZONE1 = 2; This is very important not doing this will mean that the same units will spawn every time the badguys.sqf runs.

		if (ZONE1 == 1) then {
			ZONE1 = 2;
			// Your Unit Spawns
		};
		
	Step 5. If you have looked at the examples below you will notice that a lot of the units require a marker to spawn on. Create this marker in the editor you can have any name you wish, I recommend choosing something
			that you can use as a reference such as zone1.
		
	Step 6.	Who are we fighting? open up the functions.sqf and change one of the following to true.
	
			GOLUS = true; // US West
			GOLFIA = false; // FIA West
			GOLRU = false; // Russians Independent
			GOLINS = false; // Insurgents East
			GOLTALI = false; // Taliban East
		
	Step 7. While in the editor if you press escape you will see a large window spawned "Debug Console" you can paste copy snippets into this box and click "Local Exec" this will then run the code.
			It's very useful for getting your current position, here is some examples on how the debug console can be used.
			
			hint format ["%1 %2", getposatl player, getdir player];copyToClipboard (str(text"this setposATL ") + str(getposatl player) + str(text"; this setDir ") + str(getdir player));
			// This will get your current position and direction that your facing.
			
			onMapSingleClick "copyToClipboard format ['%1',_pos]";
			
			///copyToClipboard format ["['zone1', %1, 'UP', 0] spawn Fnc_SpawnUnit;",getPosATL player]; 
			///copyToClipboard format ["['zone1', %1, 'UP'] spawn Fnc_SpawnSniper;",getPosATL player]; 
			///copyToClipboard format ["['Zone1Group1', %1, 1, 'MOVE', 'LINE', 'RED', 'AWARE', 'NORMAL'] spawn Fnc_wayPoint;",getPosATL player];
			///["Zone1Group1", [10785.7,8221.48,0.00154114], 1, "MOVE", "LINE", "YELLOW", "AWARE", "NORMAL"] spawn Fnc_wayPoint;
			///onMapSingleClick "copyToClipboard format ['%1',_pos]";
			///CopyToClipboard format ["['Land_fortified_nest_big_EP1', %1, %2 - 180, 2] spawn Fnc_SpawnBunker;",getPosATL player,getDir player];
			///CopyToClipboard format ["['RDS_KORD_high_CSAT', %1, %2] spawn Fnc_StaticWeapon;",getPosATL player,getDir player];
			///CopyToClipboard format ["['O_SD_Offroad_01_armed', %1, %2, 1, 2] spawn Fnc_SpawnVehicle;",getPosATL player,getDir player];
			
	---[DYNAMIC-UNITS]---
	
	["zone1", 10, 125, "buildings"] spawn Fnc_Populate;
	["zone1", 18, 225, "patrols"] spawn Fnc_Populate;
	
	Spawn Marker Name, Number of Units, Spawn Radius, Populate Type buildings, patrols		
	
	---[STATIC-UNITS]---
	
	["zone1", [10843.3,8158.47,0.00177002], "UP", 1] spawn Fnc_SpawnUnit;
	["zone1", [10812.9,8190.88,0.00106812], "UP", 0] spawn Fnc_SpawnUnit;
	["zone1", [10796.8,8177.33,0.00178528], "UP", 0] spawn Fnc_SpawnUnit;
	["zone1", [10777.3,8100.34,0.0014801], "UP", 0] spawn Fnc_SpawnUnit;
	
	Spawn Marker Name, Position, Stance, Leader 0/1	
	
	---[STATIC-SNIPERS]---
	
	["zone1", [10843.3,8158.47,0.00177002], "UP"] spawn Fnc_SpawnSniper;
	
	Spawn Marker Name, Position, Stance
	
	---[STATIC-ANTIAIR-TROOPS]---
	
	["zone1", [10843.3,8158.47,0.00177002], "UP"] spawn Fnc_SpawnAntiAir;
	
	Spawn Marker Name, Position, Stance
	
	---[MOBILE-UNITS]---
	
	["Zone1Group1", "zone1", 5] spawn Fnc_SpawnGroup;
	sleep 0.3;
	["Zone1Group1", [10785.7,8221.48,0.00154114], 1, "MOVE", "STAG COLUMN", "YELLOW", "SAFE", "LIMITED"] spawn Fnc_wayPoint;
	["Zone1Group1", [10877.9,8095.71,0.00172424], 2, "MOVE", "STAG COLUMN", "YELLOW", "SAFE", "LIMITED"] spawn Fnc_wayPoint;
	["Zone1Group1", [10785.7,8221.48,0.00154114], 3, "CYCLE", "STAG COLUMN", "YELLOW", "SAFE", "LIMITED"] spawn Fnc_wayPoint;
	sleep 2;
	
	Group Name, Spawn Marker Name, Number of units!
	
	The next thing we're going to do is create some waypoints. Again We refer to the group Zone1Group1 the next large number is a waypoint location that the units will move to. The number after the large number is 
	the waypoint index this should increase with increments of 1 for each waypoint added. Next we have specified the waypoint type which in this case is MOVE, next is the formation that the units should use while 
	moving STAG COLUMN. After this we specify a colour which is basispawny a mode for how the AI will react when they're engaged. Next We have specified SAFE this is how the AI will hold its weapon while moving and 
	finally we specify the speed the unit should move at in this case LIMITED.
	
	For all of the possible waypoint options you can find them on the wiki page - https://community.bistudio.com/wiki/waypoints
	
	---[CIVILIANS]---
	
	[10, "zone1", 250] spawn Fnc_SpawnCivilians;
	
	Number of Civilians, Spawn Marker, Maximum Radius of WayPoints 
	So the above example will spawn 10 random civilians that will follow random WayPoints within a Radius of 250 metres of the Spawn Marker.
	
	[] spawn Fnc_CleanUpCivilians;
	
	This will remove all spawned civilian's which is handy if your mission has multiple towns. There is no need for civilians in town 1 if players are in town 2, removing them will increase performance
	allowing you to spawn a new set of civilians in town 2.
	
	---[BUNKERS]---	
	["Land_fortified_nest_big_EP1", [1844.85,5725.56,0.00143862], 173, 4] spawn Fnc_SpawnBunker;
	Bunkers - Land_fortified_nest_big_EP1 Land_fortified_nest_small_EP1
	
	Building class name, Position, Direction, Number of units!
	
	--[VEHICLES]---
	
	["rhsusf_m1025_w_m2", [1844.85,5725.56,0.00143862], 88, 1, 3] spawn Fnc_SpawnVehicle;
	
	Vehicle class name, Position, Direction, Static 0/1, Number of units!
	
	To add waypoints add the following below the above line and make sure that the vehicle isn't in static mode.
	
	["rhsusf_m1025_w_m2", [22923.9,21013.2,0.00156403], 163, 0, 3] spawn Fnc_SpawnVehicle; sleep 2;
	["VehTeam", [23757.8,20331.1,0.00150299], 1, "MOVE", "WEDGE", "YELLOW", "AWARE", "LIMITED"] spawn Fnc_wayPoint;
	["VehTeam", [22923.9,21013.2,0.00156403], 2, "MOVE", "WEDGE", "YELLOW", "AWARE", "LIMITED"] spawn Fnc_wayPoint;
	["VehTeam", [22923.9,21013.2,0.00156403], 3, "CYCLE", "WEDGE", "YELLOW", "AWARE", "LIMITED"] spawn Fnc_wayPoint;
	
	--[PLANES]--
	
	["B_Plane_CAS_01_F", [6451.74,5437.13,0.00148487], 0] spawn Fnc_SpawnPlane;
	
	Plane class name, Position, Direction
	
	Adding waypoints for a plane is slightly different because rather than the waypoint index starting from 2 it starts from 1 instead other than that its identical.
	
	["VehTeam", [12738,12254.1,0.00131989], 1, "MOVE", "WEDGE", "YELLOW", "AWARE", "LIMITED"] spawn Fnc_wayPoint;
	["VehTeam", [10459.2,12414.8,0.00146484], 2, "MOVE", "WEDGE", "YELLOW", "AWARE", "LIMITED"] spawn Fnc_wayPoint;
	["VehTeam", [12738,12254.1,0.00131989], 3, "CYCLE", "WEDGE", "YELLOW", "AWARE", "LIMITED"] spawn Fnc_wayPoint;
	
	--[STATIC-WEAPONS]---	
	["RDS_KORD_high_CSAT", [1897.04,5729.67,0.00145102], 191] spawn Fnc_StaticWeapon;
	
	Static Weapon class name, Position, Direction
	
	--[VEHICAL-COLOURS]---	
	["0"] spawn Fnc_SetColor;
	
	0 = British Green
	1 = Russian Green
	2 = American Gold
	3 = German Grey
	4 = Armed WildCat British
	5 = Armed Ka-60 Black
	
	Run this right after spawning a vehicle, change the number depending on what colour you would like to use.
	
	---[PARADROP]---
	
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
	
	--[RANDOM-POSITIONS]---	
	[officer_01, [1280,7583.55,1.29939], [1419.49,7728.37,10.3551], [1298.1,7648.26,3.84938]] spawn Fnc_RandomPosition;
	
	Unit Name, Position1, Position2, Position3
	
	Make sure that all three locations are filled out. Use this with a unit placed in the editor name the unit officer_01 or whatever you like.
	
*/