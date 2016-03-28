Fnc_Populate = {
	_marker = _this select 0; _markerPOS = (GetMarkerPos _marker);
	_unitcount = _this select 1;
	_radius = _this select 2;
	_type = _this select 3;
	_groupsize = _this select 4;
	GoLUnitCount = 0;
	BuildingListArray = nearestObjects [_markerPOS, ["house"], _radius]; BuildingListArray call BIS_fnc_arrayShuffle;
	ObjectMarkerList = _markerPOS nearObjects _radius; ObjectMarkerList call BIS_fnc_arrayShuffle;

	while {GoLUnitCount <= _unitcount} do {
		if (GoLUnitCount == _unitcount) exitWith {};
		if (_type == "buildings") then {
			PopulateType = 0;
		};
		if (_type == "patrols") then {
			PopulateType = 1;
		};

		if (PopulateType == 0) then {
			GoLUnitCount = GoLUnitCount + 1; sleep 1;
			_building = BuildingListArray call BIS_fnc_selectRandom;
			_buildingenterable = [_building] call BIS_fnc_isBuildingEnterable;
			if (_buildingenterable) then {
				_buildingpos = [_building] call BIS_fnc_buildingPositions; _buildingpos = _buildingpos call BIS_fnc_selectRandom;
				[_marker, _buildingpos, "UP", 1] call Fnc_SpawnUnit;
				_count = count BuildingListArray; if (_count > 15) then { BuildingListArray = BuildingListArray - [_building]; };
			};
		};

		if (PopulateType == 1) then {
			GoLUnitCount = GoLUnitCount + _groupsize; sleep 2; //hint format["%1", GoLUnitCount];
			["DeathSquad", _marker, _groupsize] call Fnc_SpawnGroup;
			[NewGroup, _marker, _radius, 3, "MOVE", "NORMAL", "RED", "LIMITED", "FILE", "", [3,6,9]] call CBA_fnc_taskPatrol;
		};
	};
		ObjectMarkerList = nil;
};

Fnc_SpawnUnit = {
	_unit = EnemyUnits call BIS_fnc_selectRandom;
	_marker = _this select 0;
	_spawn = (GetMarkerPos _marker);
	_position = _this select 1;
	_stance = _this select 2;
	_leader = _this select 3;
	if (_leader == 1) then {
		_group = "StaticUnit";
		_group = CreateGroup EnemySide;
		_soldier = _group createUnit [_unit, _spawn, [], 0, "FORM"];
		_soldier setposATL _position;_soldier setUnitPos _stance;_soldier forceSpeed 0; [_soldier] call Fnc_RandomDirection;
		StaticGroup = _group; NewUnit = _soldier;
	} else {
		_soldier = StaticGroup createUnit [_unit, _spawn, [], 0, "FORM"];
		_soldier setposATL _position;_soldier setUnitPos _stance;_soldier forceSpeed 0; [_soldier] call Fnc_RandomDirection; NewUnit = _soldier;
	};

	[NewUnit, "SOL"] call Fnc_StoreUnit;

	// Check Surroundings
	_unitobjectarray = GetPos NewUnit nearObjects 2; _baseside = side NewUnit;
	{
		_side = side _x;
		if (_side == _baseside && NewUnit != _x) then {
			_unitPOS = GetPos _x;
			_newpos = [(_unitPOS select 0) - random(25), (_unitPOS select 1) + random(25), _unitPOS select 2]; _unitPOS = _newpos;
			_x setposATL _unitPOS;
		};
	} forEach _unitobjectarray;
};

Fnc_SpawnGroup = {
	_group = _this select 0;
	_marker = _this select 1;
	_number = _this select 2;
	_group = CreateGroup EnemySide; NewGroup = _group;

	for "_i" from 1 to _number do {
		_unit = EnemyUnits call BIS_fnc_selectRandom;
		_soldier = _group createUnit [_unit,(GetMarkerPos _marker),[],0,"private"];
		//[_soldier, "SOL"] call Fnc_StoreUnit;
	};
};

Fnc_SpawnCivilians = {
	_number = _this select 0;
	_marker = _this select 1;
	_range = _this select 2;
	_speeds = ["LIMITED","NORMAL","FULL"];
	ObjectMarkerList = getMarkerPos _marker nearObjects _range;

	for "_i" from 1 to _number do {
		_unit = CivilianUnits call BIS_fnc_selectRandom;
		_group = CreateGroup Civilian; NewGroup = _group;
		_soldier = _group createUnit [_unit,(GetMarkerPos _marker),[],0,"private"];
		[_soldier, "CIV"] call Fnc_StoreUnit;
		_speed = _speeds call BIS_fnc_selectRandom;
		[NewGroup, _marker, _range, 3, "MOVE", "NORMAL", "RED", _speed, "FILE", "", [3,6,9]] call CBA_fnc_taskPatrol;

	};
	{
	if (side _x == Civilian) then {
		// _x disableAI "FSM";
		_x setOwner 0; //_clientID = owner _x; hint format["%1", _x];
		//_x addRating -10000;
		//hint format["%1", _x];
		};
	} ForEach AllUnits;
		ObjectMarkerList = nil;
};

Fnc_StoreUnit = {
	_unit = _this select 0;
	_type = _this select 1;
	if(_type == "SOL") then {
		//Store Unit in Array for deletion
		if (isNil ("SoldierArrayList")) then {
			SoldierArrayList = [_unit];
		} else {
			SoldierArrayList = SoldierArrayList + [_unit];
		};
	};
	if(_type == "CIV") then {
		//Store Unit in Array for deletion
		if (isNil ("CivilianArrayList")) then {
			CivilianArrayList = [_unit];
		} else {
			CivilianArrayList = CivilianArrayList + [_unit];
		};
	};
};

Fnc_CleanUpCivilians = {
	if (!isNil ("CivilianArrayList")) then {
		{
			deleteVehicle _x;
		} forEach CivilianArrayList;
		CivilianArrayList = nil;
	};
};

Fnc_CleanUpSoldier = {
	if (!isNil ("SoldierArrayList")) then {
		{
			deleteVehicle _x;
		} forEach SoldierArrayList;
		SoldierArrayList = nil;
	};
};

Fnc_wayPoint = {
	_group = _this select 0;
	_moveto = _this select 1;
	_index = _this select 2;
	_type = _this select 3;
	_formation = _this select 4;
	_mode = _this select 5;
	_behaviour = _this select 6;
	_speed = _this select 7;
	_wp = NewGroup addWaypoint [_moveto, _index];
	_wp = [NewGroup, _index] setWaypointType _type;
	_wp = [NewGroup, _index] setWaypointFormation _formation;
	_wp = [NewGroup, _index] setWaypointCombatMode _mode;
	_wp = [NewGroup, _index] setWaypointBehaviour _behaviour;
	_wp = [NewGroup, _index] SetWaypointSpeed _speed;
};

Fnc_wayPointRandom = {
	_group = _this select 0;
	_moveto = _this select 1;
	_index = _this select 2;
	_type = _this select 3;
	_formation = _this select 4;
	_mode = _this select 5;
	_behaviour = _this select 6;
	_speed = _this select 7;
	_X = _moveto select 0;
	_Y = _moveTo select 1;
	_X = _X + ((Random 200)-50);
	_Y = _Y + ((Random 200)-50);
	_wp = NewGroup addWaypoint [[_X,_Y,0], _index];
	_wp = [NewGroup, _index] setWaypointType _type;
	_wp = [NewGroup, _index] setWaypointFormation _formation;
	_wp = [NewGroup, _index] setWaypointCombatMode _mode;
	_wp = [NewGroup, _index] setWaypointBehaviour _behaviour;
	_wp = [NewGroup, _index] SetWaypointSpeed _speed;
};

Fnc_SpawnBunker = {
	_fortification = _this select 0;
	_location = _this select 1;
	_direction = _this select 2;
	_number = _this select 3;
	_bunker = createVehicle [_fortification, _location, [], 0, "CAN_COLLIDE"];
	_bunker SetDir (_direction) + 180;
	_bunker setVectorUp [0,0,0.01];
	_cnt = 0; _posarray = []; while {format ["%1", _bunker BuildingPos _cnt] != "[0,0,0]" } do { _pos = _bunker BuildingPos _cnt; _posarray = _posarray + [_pos]; _cnt = _cnt + 1; sleep 0.01; }; //hint format["%1", _cnt];

	_group = CreateGroup EnemySide;
	for "_i" from 1 to _number do {
		_unit = EnemyUnits call BIS_fnc_selectRandom;
		_buildingPos = random _cnt;
		_soldier = _group createUnit [_unit,_location, [], 0, "FORM"];
		_soldier forceSpeed 0;
		_soldier setUnitPos "UP";
		_soldier setPos (_bunker buildingPos _buildingPos);
		[_soldier] call Fnc_RandomDirection;
		//[_soldier, "SOL"] call Fnc_StoreUnit;
	};
	NewGroup = _group;
};

Fnc_SpawnVehicle = {
	_vehicle = _this select 0;
	_location = _this select 1;
	_direction = _this select 2;
	_static = _this select 3;
	_number = _this select 4;
	_vehicle = createVehicle [_vehicle, _location, [], 0, "CAN_COLLIDE"];
	_vehicle setDir _direction;
	if (_static == 1) then {
		_vehicle setFuel 0;
	};

	_group = CreateGroup EnemySide; NewGroup = _group;
	for "_i" from 1 to _number do {
		_unit = EnemyUnits call BIS_fnc_selectRandom;
		_soldier = _group createUnit [_unit,_location, [], 0, "FORM"];
		_soldier moveInAny _vehicle;
		//[_soldier, "SOL"] call Fnc_StoreUnit;
	};
	NewVehicle = _vehicle;
	clearWeaponCargoGlobal _vehicle;ClearMagazineCargoGlobal _vehicle;ClearItemCargoGlobal _vehicle;clearBackpackCargoGlobal _vehicle;
};

Fnc_SpawnPlane = {
	_vehicle = _this select 0;
	_location = _this select 1;
	_direction = _this select 2;
	_vehicle = createVehicle [_vehicle, _location, [], 0, "FLY"];
	_vehicle setDir _direction;
	_vehicle setVelocity [(sin (getDir _vehicle))*100, (cos (getDir _vehicle))*100, 0];

	_group = CreateGroup EnemySide;
	_unit = EnemyUnits call BIS_fnc_selectRandom;
	_soldier = _group createUnit [_unit,_location, [], 0, "FORM"];
	_soldier assignAsDriver _vehicle; _soldier moveInDriver _vehicle;
	//[_soldier, "SOL"] call Fnc_StoreUnit;
	NewGroup = _group;
	NewVehicle = _vehicle;
};

Fnc_StaticWeapon = {
	_vehicle = _this select 0;
	_location = _this select 1;
	_direction = _this select 2;
	_vehicle = createVehicle [_vehicle, _location, [], 0, "CAN_COLLIDE"];
	_vehicle setDir _direction;
	sleep 2;
	_group = CreateGroup EnemySide;
	_unit = EnemyUnits call BIS_fnc_selectRandom;
	_soldier = _group createUnit [_unit,_location, [], 0, "FORM"];
	_soldier assignAsGunner _vehicle; _soldier moveInGunner _vehicle;
	[_soldier] call Fnc_RandomDirection;
	//[_soldier, "SOL"] call Fnc_StoreUnit;
};

/*Fnc_SpecialUnit = {
	_marker = _this select 0;
	_spawn = (GetMarkerPos _marker);
	_position = _this select 1;
	_stance = _this select 2;
	_type = _this select 3;

	if(_type == "SN") then {
		_unit = EnemySnipers call BIS_fnc_selectRandom;
	};
	if(_type == "AA") then {
		_unit = EnemyAntiAir call BIS_fnc_selectRandom;
	} else {
		_unit = EnemySnipers call BIS_fnc_selectRandom;
	};

	hint format["%1 HI", _unit];

	_group = "StaticUnit";
	_group = CreateGroup EnemySide;
	_soldier = _unit createUnit [_spawn,_group,"this setDir _direction;this setposATL _position;this setUnitPos _stance;this forceSpeed 0;[this] call Fnc_RandomDirection;",0.5];
	StaticGroup = _group;
	//[_soldier, "SOL"] call Fnc_StoreUnit;
};*/

Fnc_SpecialUnit = {
	_marker = _this select 0;
	_spawn = (GetMarkerPos _marker);
	_position = _this select 1;
	_stance = _this select 2;
	_type = _this select 3;
	_unit = EnemySnipers call BIS_fnc_selectRandom;
	_group = "StaticUnit";
	_group = CreateGroup EnemySide;
	_soldier = _unit createUnit [_spawn,_group,"this setDir _direction;this setposATL _position;this setUnitPos _stance;this forceSpeed 0;[this] call Fnc_RandomDirection;",0.5];
	StaticGroup = _group;
};

Fnc_RandomDirection = {
	_unit = _this select 0;
	ObjectMarkerList = GetPos _unit nearObjects 50;
	Obj1 = ObjectMarkerList call BIS_fnc_selectRandom; Loc1 = GetPosASL Obj1;
	_typeX = typeOf Obj1;
	_inignore = (str _typeX) in ['"HouseFly"','"ButterFly_random"','"HoneyBee"','"Mosquito"','"#mark"','"FxWindPollen1"','"FireFly"'];
	if (_inignore) then { } else { _unit commandWatch Obj1; };
	ObjectMarkerList = nil;
};

Fnc_RandomPosition = {
	_unit = _this select 0;
	_pos1 = _this select 1;
	_pos2 = _this select 2;
	_pos3 = _this select 3;
	_positions = [_pos1,_pos2,_pos3]; _position = _positions call BIS_fnc_selectRandom;
	_unit setposATL _position;
};

Fnc_SetColor = {
	_colour = _this select 0;
	if (_colour == "0") then { for "_i" from 0 to 4 do {NewVehicle setObjectTextureGlobal [_i, "gol_menu\textures\british_green.jpg"];}; };
	if (_colour == "1") then { for "_i" from 0 to 4 do {NewVehicle setObjectTextureGlobal [_i, "gol_menu\textures\russian_green.jpg"];}; };
	if (_colour == "2") then { for "_i" from 0 to 4 do {NewVehicle setObjectTextureGlobal [_i, "gol_menu\textures\american_gold.jpg"];}; };
	if (_colour == "3") then { for "_i" from 0 to 4 do {NewVehicle setObjectTextureGlobal [_i, "gol_menu\textures\german_grey.jpg"];}; };
	if (_colour == "4") then { NewVehicle setObjectTextureGlobal [0, "\A3\Air_F_EPB\Heli_Light_03\data\Heli_Light_03_base_CO.paa"]; };
	if (_colour == "5") then { NewVehicle setObjectTextureGlobal [0, "A3\Air_F\Heli_Light_02\Data\Heli_Light_02_ext_CO.paa"]; };
	if (_colour == "russian_ammo") then { NewVehicle setObjectTextureGlobal [0, "mission\textures\russian_green.jpg"]; NewVehicle setObjectTextureGlobal [1, "gol_menu\russian_ammo.jpg"]; };
	if (_colour == "russian_fuel") then { NewVehicle setObjectTextureGlobal [0, "mission\textures\russian_green.jpg"]; NewVehicle setObjectTextureGlobal [1, "gol_menu\russian_fuel.jpg"]; };
	if (_colour == "russian_mend") then { NewVehicle setObjectTextureGlobal [0, "mission\textures\russian_green.jpg"]; NewVehicle setObjectTextureGlobal [1, "gol_menu\russian_mend.jpg"]; };
};

Fnc_setName = {
	_object = _this select 0;
	_name = _this select 1;
	_object SetVehicleVarName _name;
	_object Call Compile Format ["%1=_This; PublicVariable ""%1""",_name];
};

Fnc_FixVehiclePosition = {
	_vehicle = _this select 0;
	_vehicle allowDamage false; sleep 0.5;
	_position = GetPos _vehicle;
	_newpos = [_position select 0, _position select 1, (_position select 2) + 0.5]; _objectpos = _newpos;
	_vehicle setPos _objectpos;	sleep 0.5;
	_vehicle allowDamage true;
	clearWeaponCargoGlobal _vehicle;ClearMagazineCargoGlobal _vehicle;ClearItemCargoGlobal _vehicle;clearBackpackCargoGlobal _vehicle;
	_vehicle addBackpackCargoGlobal ["RDS_Metis_Gun_Bag",2];
	_vehicle addBackpackCargoGlobal ["RDS_Metis_Tripod_Bag",2];
	_vehicle addBackpackCargoGlobal ["I_Mortar_01_support_F",2];
	_vehicle addBackpackCargoGlobal ["I_Mortar_01_weapon_F",2];
};

Fnc_CreateSmoke = {
	_location = _this select 0;
	_smoke = createVehicle ["test_EmptyObjectForSmoke", _location, [], 0, "CAN_COLLIDE"];
};

Fnc_DefendArea = { // A function for a group to defend, run directly after spawning a group! [] spawn Fnc_DefendArea;
	[NewGroup] spawn CBA_fnc_taskDefend;
};

Fnc_SearchBuildings = { // A function for a group to search a nearby building, run directly after spawning a group! [] spawn Fnc_SearchBuildings;
	[NewGroup] spawn CBA_fnc_searchNearby;
};

Fnc_AttackGroup = { // Force group to Search and Destroy random players, run directly after spawning a group! *DOESN'T WORK IN THE EDITOR* [] spawn Fnc_AttackGroup;
	{
		if(isTouchingGround _x) then {
			if (isNil ("PlayerArrayList")) then {
					PlayerArrayList = [_x];
			} else {
				PlayerArrayList = PlayerArrayList + [_x];
			};
		};
	} forEach playableUnits;

	_inignore = ["wecho1","wecho2","wecho3","wecho4","eecho1","eecho2","eecho3","eecho4","iecho1","iecho2","iecho3","iecho4"];
	{
		PlayerArrayList = PlayerArrayList - [_x];
	} forEach _inignore;

	PlayerArrayList call BIS_fnc_arrayShuffle;
	_RandomPlayer = PlayerArrayList call BIS_fnc_selectRandom;
	[NewGroup, GetPos(_RandomPlayer), 100] call CBA_fnc_taskAttack;
};

Fnc_CreateExplosion = {
	_location = _this select 0;
	_type = _this select 1;	
	
	if (_type == "VSMALL") then {
		_bomb = createVehicle ["M_PG_AT", _location, [], 0, "CAN_COLLIDE"];
	};
	if (_type == "SMALL") then {
		_bomb = createVehicle ["R_80mm_HE", _location, [], 0, "CAN_COLLIDE"];
	};
	if (_type == "MEDIUM") then {
		_bomb = createVehicle ["Bo_Mk82", _location, [], 0, "CAN_COLLIDE"];
	};
	if (_type == "BIG") then {
		_bomb = createVehicle ["Bo_GBU12_LGB", _location, [], 0, "CAN_COLLIDE"];
	};
};

Fnc_Paradrop = {
	_vehicle = _this select 0;
	_marker = _this select 1; _markerPOS = getMarkerPos _marker;
	_direction = _this select 2;
	_altitude = _this select 3;
	_distance = _this select 4;
	_CrewCount = [_vehicle, true] call BIS_fnc_crewCount;

	//[ X, Y, Z]
	if (_direction == "N") then {
		_newpos = [_markerPOS select 0, (_markerPOS select 1) + 4000, (_markerPOS select 2) + _altitude]; VehicleLocation = _newpos;
	};
	if (_direction == "NE") then {
		_newpos = [(_markerPOS select 0) + 4000, (_markerPOS select 1) + 4000, (_markerPOS select 2) + _altitude]; VehicleLocation = _newpos;
	};
	if (_direction == "E") then {
		_newpos = [(_markerPOS select 0) + 4000, _markerPOS select 1, (_markerPOS select 2) + _altitude]; VehicleLocation = _newpos;
	};
	if (_direction == "SE") then {
		_newpos = [(_markerPOS select 0) + 4000, (_markerPOS select 1) - 4000, (_markerPOS select 2) + _altitude]; VehicleLocation = _newpos;
	};
	if (_direction == "S") then {
		_newpos = [_markerPOS select 0, (_markerPOS select 1) - 4000, (_markerPOS select 2) + _altitude]; VehicleLocation = _newpos;
	};
	if (_direction == "SW") then {
		_newpos = [(_markerPOS select 0) + 4000, _markerPOS select 1, (_markerPOS select 2) + _altitude]; VehicleLocation = _newpos;
	};
	if (_direction == "W") then {
		_newpos = [(_markerPOS select 0) - 4000, _markerPOS select 1, (_markerPOS select 2) + _altitude]; VehicleLocation = _newpos;
	};
	if (_direction == "NW") then {
		_newpos = [(_markerPOS select 0) - 4000, (_markerPOS select 1) + 4000, (_markerPOS select 2) + _altitude]; VehicleLocation = _newpos;
	};

	_vehicle = createVehicle [_vehicle, VehicleLocation, [], 0, "FLY"]; _vehlocation = GetPos _vehicle; _vehicle flyInHeight _altitude;

	_group = CreateGroup EnemySide;
	for "_i" from 1 to _CrewCount do {
		_unit = EnemyUnits call BIS_fnc_selectRandom;
		_soldier = _group createUnit [_unit,_vehlocation,[],0,"private"];
		_soldier moveInAny _vehicle;
		//[_soldier, "SOL"] call Fnc_StoreUnit;
	};
	NewGroup = _group;
	[_group, _markerPOS, 0, "MOVE", "WEDGE", "YELLOW", "AWARE", "FULL"] call Fnc_wayPoint;
	[_group, _markerPOS, 1, "SAD", "WEDGE", "YELLOW", "AWARE", "FULL"] call Fnc_wayPoint;

	_distancecheck = _vehicle distance getMarkerPos _marker;
	while {_distancecheck > _distance} do {
		_distancecheck = _vehicle distance getMarkerPos _marker;
		if(_distancecheck < _distance) exitWith { [_vehicle] spawn Fnc_ParadropInitiate; };
		sleep 5;
	};
};

Fnc_ParadropInitiate = {
	_vehicle = _this select 0; //_driver = assignedDriver _vehicle; 	[_driver] join grpNull;
	_list = assignedCargo _vehicle;
	{
		_unit = _x;
		_airframe = vehicle _unit;
		_airframe land "NONE";
		_height = ((GetPosASL _unit) select 2); _height = round _height;
		_unit disableCollisionWith _airframe;
		_unit action ["EJECT", _airframe];
		moveOut _unit;
		removeBackPack _unit;
		_direction = getDir _airframe;
		_pos = GetPos _airframe;
		_newpos = [_pos select 0, _pos select 1, (_pos select 2) - 2]; _paradrop = _newpos;
		_unit setposATL (_paradrop);
		sleep 1.5;
		_unit AddBackPack "B_Parachute";
	} forEach _list;
};

Fnc_LightsOut = {
	_marker = _this select 0;
	_types = ["Land_PortableLight_double_F","Land_PortableLight_single_F","Land_FloodLight_F","Land_NavigLight","Land_NavigLight_3_F","Land_Flush_Light_yellow_F","Land_Flush_Light_red_F","Land_Flush_Light_green_F","Land_runway_edgelight","Land_runway_edgelight_blue_F","Land_Runway_PAPI","Land_Runway_PAPI_2","Land_Runway_PAPI_3","Land_Runway_PAPI_4","Lamps_Base_F","PowerLines_base_F","Land_PowerPoleWooden_F","Land_LampHarbour_F","Land_LampShabby_F","Land_PowerPoleWooden_L_F","Land_PowerPoleWooden_small_F","Land_LampDecor_F","Land_LampHalogen_F","Land_LampSolar_F","Land_LampStreet_small_F","Land_LampStreet_F","Land_LampAirport_F","Land_PowerPoleWooden_L_F","Land_fs_roof_F","Land_fs_sign_F"];

	for [{_i=0},{_i < (count _types)},{_i=_i+1}] do {
		_lamps = getMarkerPos _marker nearObjects [_types select _i, 2000];
		sleep 0.5;
		{
			_x setDamage 0.97;
			(_x) switchLight "off";
			_x setLightBrightness 0;
			_x setLightAmbient [0.0, 0.0, 0.0];
			_x setLightColor [0.0, 0.0, 0.0];
		} forEach _lamps;
	};
};

Fnc_CreateIED = {
	// [[14456.1,17609.8,0.00136185], "WEST"] spawn Fnc_CreateIED;
	_location = _this select 0;
	_side = _this select 1;
	_ieds = ["RoadCone_F","Land_Pallets_F","Land_WheelCart_F","Land_Tyre_F","Land_ButaneCanister_F","Land_Bucket_F","Land_Pillow_F"];
	_ieds_attachto = ["IEDLandBig_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanSmall_Remote_Ammo"];

	_ied = _ieds call BIS_fnc_selectRandom; // Select a random IED
	_ied2 = _ieds_attachto call BIS_fnc_selectRandom; // Select a random IED
	_bomb1 = createVehicle [_ied, _location, [], 0, "CAN_COLLIDE"]; // Create Intractable Object
	_bomb2 = createVehicle [_ied2, _location, [], 0, "CAN_COLLIDE"]; // Create IED
	[[_bomb1,'Disarm Bomb','[player] call Fnc_Disarm'], "Fnc_AddAction" , true, false] spawn BIS_fnc_MP;

	[[_bomb1],"Fnc_AddIEDEH",true,false] spawn BIS_fnc_MP;
	[[_bomb2],"Fnc_AddIEDEH",true,false] spawn BIS_fnc_MP;

	_IEDTrigger = createTrigger["EmptyDetector",_location]; _IEDTrigger setTriggerArea[3,3,0,false];
	_IEDTrigger setTriggerActivation[_side,"PRESENT",false];
	_IEDTrigger setTriggerStatements ["((thislist select 0) selectionPosition 'launcher' select 2) > 1.2;", "[thisTrigger] spawn Fnc_IEDExplode;", ""];
	_IEDTrigger AttachTo [_bomb1,[0,0,0]];
};

Fnc_AddIEDEH = {
	_object = _this select 0;
	_object addEventHandler ["HitPart", {_this call Fnc_IED_EH;}];
};

Fnc_IEDExplode = {
	_object = _this select 0; //hint format["%1", _object];
	_objectPos = GetPos _object;

	_object removeAllEventHandlers "HitPart";

	_list = GetPos _object nearObjects 2;
	{
		DeleteVehicle _x;
	} forEach _list;

	_bomb = createVehicle ["M_Mo_120mm_AT_LG", _objectPos, [], 0, "CAN_COLLIDE"];
	[[_objectPos],"SHOCK_WAVE",true,false] spawn BIS_fnc_MP;
	[[_objectPos],"IED_ROCKS",true,false] spawn BIS_fnc_MP;
	[[_objectPos],"IED_SMOKE_LARGE",true,false] spawn BIS_fnc_MP;
	_crater = createVehicle ["CraterLong_small", _objectPos, [], 0, "CAN_COLLIDE"];
	_newpos = [_objectPos select 0, _objectPos select 1, (_objectPos select 2) - 0.8];
	_crater setPos _newpos;
};

Fnc_Disarm = {
	_object = _this select 0;
	_tools = "ACE_DefusalKit" in (items player);

	if !(_tools) exitWith { hint "You need a Defusal Kit"; }:

	hint "Defusing...";
	[[[player], {(_this select 0) playmovenow "AinvPknlMstpSnonWrflDr_medic4";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
	disableUserInput true;
	sleep 4.545;
	[[[player], {(_this select 0) playmove "AinvPknlMstpSnonWrflDr_medic3";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
	sleep 6.545;
	disableUserInput false;

	_object removeAllEventHandlers "HitPart"; _object removeAction 0;
	[-2, {_this removeAllEventHandlers "HitPart"; }, _object] call CBA_fnc_globalExecute;
	[-2, {_this removeAction 0;}, _object] call CBA_fnc_globalExecute;

	hint "Defused!!!";
	_iedpos = (GetPos _object);
	_list = GetPos _object nearObjects 5;
	{
		DeleteVehicle _x;
	} forEach _list;
};

Fnc_AddAction = {
	_object = _this select 0;
	_text = _this select 1;
	_execute = _this select 2;
	_object addAction [_text, _execute, trigger1, 0, true, true, "", "(_this distance (_target)) < 3 "];
};

Fnc_IED_EH = {
	_hitEvent = _this select 0;
	_ied = _hitEvent select 0;
	_projectile = _hitEvent select 6 select 4;

	_explosiveValue = getNumber(configfile >> "CfgAmmo" >> format["%1", _projectile] >> "explosive");
	if(_explosiveValue == 0) then {
		if ((random 10) <= 1) then { [_ied] spawn Fnc_IEDExplode; };
	} else {
		[_ied] spawn Fnc_IEDExplode;
	};
};

SHOCK_WAVE = {
	_loc = _this select 0;
	_aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];

	_smoke1 = "#particlesource" createVehicleLocal _aslLoc;
	_smoke1 setposasl _aslLoc;
	_smoke1 setParticleCircle [0, [0, 0, 0]];
	_smoke1 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[0, 0, 0, 1], [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke1 setDropInterval .0004;

	_smoke2 = "#particlesource" createVehicleLocal _aslLoc;
	_smoke2 setposasl _aslLoc;
	_smoke2 setParticleCircle [0, [0, 0, 0]];
	_smoke2 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[.78, .76, .71, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke2 setDropInterval .0004;

	_smoke3 = "#particlesource" createVehicleLocal _aslLoc;
	_smoke3 setposasl _aslLoc;
	_smoke3 setParticleCircle [0, [0, 0, 0]];
	_smoke3 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[.55, .47, .37, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke3 setDropInterval .0004;

	_smoke4 = "#particlesource" createVehicleLocal _aslLoc;
	_smoke4 setposasl _aslLoc;
	_smoke4 setParticleCircle [0, [0, 0, 0]];
	_smoke4 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[.1, .1, .1, 1], [.2, .2, .2, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke4 setDropInterval .0004;

	_smokes = [_smoke1, _smoke2, _smoke3, _smoke4];


	sleep .07;
	{
		DeleteVehicle _x;
	} foreach _smokes;
};

IED_ROCKS = {
	_loc = _this select 0;
	_aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
	_col = [0,0,0];
	_c1 = _col select 0;
	_c2 = _col select 1;
	_c3 = _col select 2;

	_rocks1 = "#particlesource" createVehicleLocal _aslLoc;
	_rocks1 setposasl _aslLoc;
	_rocks1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.45, .45], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc,0,false,0.3];
	_rocks1 setParticleRandom [0, [1, 1, 0], [20, 20, 15], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
	_rocks1 setDropInterval 0.01;
	_rocks1 setParticleCircle [0, [0, 0, 0]];

	_rocks2 = "#particlesource" createVehicleLocal _aslLoc;
	_rocks2 setposasl _aslLoc;
	_rocks2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.27, .27], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc,0,false,0.3];
	_rocks2 setParticleRandom [0, [1, 1, 0], [25, 25, 15], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
	_rocks2 setDropInterval 0.01;
	_rocks2 setParticleCircle [0, [0, 0, 0]];

	_rocks3 = "#particlesource" createVehicleLocal _aslLoc;
	_rocks3 setposasl _aslLoc;
	_rocks3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.09, .09], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc,0,false,0.3];
	_rocks3 setParticleRandom [0, [1, 1, 0], [30, 30, 15], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
	_rocks3 setDropInterval 0.01;
	_rocks3 setParticleCircle [0, [0, 0, 0]];


	_rocks = [_rocks1,_rocks2, _rocks3];
	sleep .125;
	{
		DeleteVehicle _x;
	} foreach _rocks;
};

IED_SCREEN_EFFECTS = {
	_iedPos = _this select 0;
	sleep 0.25;
	if(alive player) then {
		_distance = (GetPos player) distance _iedPOS;
		if(_distance < 75) then {
			_volume = linearConversion [0,60,75-_distance, 0.1, 1, true];
			playSound3d["A3\Missions_F_EPA\data\sounds\combat_deafness.wss", player, false, GetPos player, _volume];
		};
		if(_distance < 40) then {
			[] spawn {
				private ["_blur"];
				_blur = ppEffectCreate ["DynamicBlur", 474];
				_blur ppEffectEnable true;
				_blur ppEffectAdjust [0];
				_blur ppEffectCommit 0;

				waitUntil {ppEffectCommitted _blur};

				_blur ppEffectAdjust [10];
				_blur ppEffectCommit 0;

				_blur ppEffectAdjust [0];
				_blur ppEffectCommit 5;

				waitUntil {ppEffectCommitted _blur};

				_blur ppEffectEnable false;
				ppEffectDestroy _blur;
			};
		};
	};
};

IED_SMOKE_LARGE = {
	_loc = _this select 0;
	_aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];

	0 = [_loc,_aslLoc] spawn {
		_loc = _this select 0;
		_aslLoc = _this select 1;
		_numPlumes = 15+floor random 20;
		for "_i" from 0 to _numPlumes -1 do{
			_r = floor random 3;
			switch(_r) do
			{
				case 0:
				{
					[_loc, _aslLoc, 500, 200] spawn {call SAND_TRAIL_SMOKE;};
				};
				case 1:
				{
					[_loc, _aslLoc, 500, 200] spawn {call GRAY_TRAIL_SMOKE;};
				};
				case 2:
				{
					[_loc, _aslLoc, 500, 200] spawn {call BROWN_TRAIL_SMOKE;};
				};
			};
		};
	};

	0 = _aslLoc spawn {

		_aslLoc = _this;

		_smoke1 = "#particlesource" createVehicleLocal _aslLoc;
		_smoke1 setposasl _aslLoc;
		_smoke1 setParticleCircle [0, [0, 0, 0]];
		_smoke1 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8+random 5, 8+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[0, 0, 0, 1], [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke1 setDropInterval .005;

		_smoke2 = "#particlesource" createVehicleLocal _aslLoc;
		_smoke2 setposasl _aslLoc;
		_smoke2 setParticleCircle [0, [0, 0, 0]];
		_smoke2 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8+random 5, 8+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.78, .76, .71, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke2 setDropInterval .005;

		_smoke3 = "#particlesource" createVehicleLocal _aslLoc;
		_smoke3 setposasl _aslLoc;
		_smoke3 setParticleCircle [0, [0, 0, 0]];
		_smoke3 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8+random 5, 8+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.55, .47, .37, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke3 setDropInterval .005;

		_smoke4 = "#particlesource" createVehicleLocal _aslLoc;
		_smoke4 setposasl _aslLoc;
		_smoke4 setParticleCircle [0, [0, 0, 0]];
		_smoke4 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8+random 5, 8+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.1, .1, .1, 1], [.2, .2, .2, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke4 setDropInterval .005;

		_smokes = [_smoke1,_smoke2, _smoke3,_smoke4];

		sleep .5;

		_smoke1 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke1 setDropInterval .005;

		_smoke2 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke2 setDropInterval .005;

		_smoke3 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke3 setDropInterval .005;

		_smoke4 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke4 setDropInterval .005;

		sleep 1;

		_smoke1 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke1 setDropInterval .005;

		_smoke2 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke2 setDropInterval .005;

		_smoke3 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke3 setDropInterval .005;

		_smoke4 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke4 setDropInterval .005;

		sleep 1;

		_smoke1 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke1 setDropInterval .01;

		_smoke2 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke2 setDropInterval .01;

		_smoke3 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke3 setDropInterval .01;

		_smoke4 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke4 setDropInterval .01;

		sleep 1;

		_smoke1 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke1 setDropInterval .01;

		_smoke2 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke2 setDropInterval .01;

		_smoke3 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke3 setDropInterval .01;

		_smoke4 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke4 setDropInterval .01;

		sleep 2;
		{
			DeleteVehicle _x;
		} foreach _smokes;

	};
};

SAND_TRAIL_SMOKE = {
	_loc = _this select 0;
	_aslLoc = _this select 1;
	_horizontal = _this select 2;
	_upwards = _this select 3;

	_size = 1 + random 3;

	_thingToFling = "Land_Bucket_F" createVehicleLocal [0,0,0];
	_thingToFling hideObject true;
	_thingToFling setPos _loc;
	_smoke = "#particlesource" createVehicleLocal _aslLoc;
	_smoke setposasl _aslLoc;
	_smoke setParticleCircle [0, [0, 0, 0]];
	_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[.55, .47, .37, .75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];
	_smoke setDropInterval 0.005;

	_thingToFling setVelocity [(random _horizontal)-(_horizontal/2), (random _horizontal)-(_horizontal/2), 5+(random _upwards)];
	_thingToFling allowDamage false;
	_sleepTime = (random .5);
	_currentTime = 0;

	while { _currentTime < _sleepTime and _size > 0} do {
		//_thingToFling hideObject true;
		_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[.55, .47, .37, .75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];

		_sleep = random .05;
		_size = _size - (6*_sleep);
		_currentTime = _currentTime + _sleep;
		sleep _sleep;
	};

	_thingToFling setpos [0,0,0];
	DeleteVehicle _smoke;
	DeleteVehicle _thingToFling;
};

GRAY_TRAIL_SMOKE = {
	_loc = _this select 0;
	_aslLoc = _this select 1;
	_horizontal = _this select 2;
	_upwards = _this select 3;

	_size = 1 + random 3;

	_thingToFling = "Land_Bucket_F" createVehicleLocal [0,0,0];
	_thingToFling hideObject true;
	_thingToFling setPos _loc;
	_smoke = "#particlesource" createVehicleLocal _aslLoc;
	_smoke setposasl _aslLoc;
	_smoke setParticleCircle [0, [0, 0, 0]];
	_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[.1, .1, .1, .75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];
	_smoke setDropInterval 0.005;

	_thingToFling setVelocity [(random _horizontal)-(_horizontal/2), (random _horizontal)-(_horizontal/2), 5+(random _upwards)];
	_thingToFling allowDamage false;
	_sleepTime = (random .5);
	_currentTime = 0;

	while { _currentTime < _sleepTime and _size > 0} do {
		//_thingToFling hideObject true;
		_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[.1, .1, .1, .75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];

		_sleep = random .05;
		_size = _size - (6*_sleep);
		_currentTime = _currentTime + _sleep;
		sleep _sleep;
	};

	_thingToFling setpos [0,0,0];
	DeleteVehicle _smoke;
	DeleteVehicle _thingToFling;
};

BROWN_TRAIL_SMOKE = {
	_loc = _this select 0;
	_aslLoc = _this select 1;
	_horizontal = _this select 2;
	_upwards = _this select 3;

	_size = 1 + random 3;

	_thingToFling = "Land_Bucket_F" createVehicleLocal [0,0,0];
	_thingToFling hideObject true;
	_thingToFling setPos _loc;
	_smoke = "#particlesource" createVehicleLocal _aslLoc;
	_smoke setposasl _aslLoc;
	_smoke setParticleCircle [0, [0, 0, 0]];
	_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0.55, 0.41, 0.25, 1], [0.55, 0.41, 0.25, 0]], [0.08], 1, 0, "", "", _thingToFling];
	_smoke setDropInterval 0.005;

	_thingToFling setVelocity [(random _horizontal)-(_horizontal/2), (random _horizontal)-(_horizontal/2), 5+(random _upwards)];
	_thingToFling allowDamage false;
	_sleepTime = (random .5);
	_currentTime = 0;

	while { _currentTime < _sleepTime and _size > 0} do {
		//_thingToFling hideObject true;
		_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0.55, 0.41, 0.25, 1], [0.55, 0.41, 0.25, 0]], [0.08], 1, 0, "", "", _thingToFling];

		_sleep = random .05;
		_size = _size - (6*_sleep);
		_currentTime = _currentTime + _sleep;
		sleep _sleep;
	};

	_thingToFling setpos [0,0,0];
	DeleteVehicle _smoke;
	DeleteVehicle _thingToFling;
};

CreateFragmentation = {
	_pos = _this select 0;
	_numberOfFragments = _this select 1;
	for "_i" from 0 to _numberOfFragments - 1 do{
		_pos set[2,.1 + random 2];
		_bullet = "B_408_Ball" createVehicle _pos;
		_angle = random 360;
		_speed = 450 + random 100;
		_bullet setVelocity [_speed*cos(_angle), _speed*sin(_angle), -1*(random 4)];
	};

CreateRandomName = {
	_letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	_name = "";
	_numberOfLettersToUse = 10;

	for "_i" from 0 to _numberOfLettersToUse-1 do
	{
		_name = _name + (_letters select floor random 26);
	};
	_name;
};
