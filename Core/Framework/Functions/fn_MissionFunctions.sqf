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
			GoLUnitCount = GoLUnitCount + 4; sleep 2;
			["DeathSquad", _marker, _groupsize] call Fnc_SpawnGroup;
			[NewGroup, _marker, _radius, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", "", [3,6,9]] call CBA_fnc_taskPatrol;
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
	_group = CreateGroup EnemySide; 
	
	for "_i" from 1 to _number do {
		_unit = EnemyUnits call BIS_fnc_selectRandom;
		_soldier = _group createUnit [_unit,(GetMarkerPos _marker),[],0,"private"];
	};
	NewGroup = _group;
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
		
		if (isNil ("CivilianArrayList")) then { 
			CivilianArrayList = [_soldier];
		} else { 
			CivilianArrayList = CivilianArrayList + [_soldier];
		};
		
		Obj1 = ObjectMarkerList call BIS_fnc_selectRandom; Loc1 = getPosASL Obj1;
		Obj2 = ObjectMarkerList call BIS_fnc_selectRandom; Loc2 = getPosASL Obj2;
		
		_speed = _speeds call BIS_fnc_selectRandom;
		
		["CiVGroup", Loc1, 1, "MOVE", "COLUMN", "BLUE", "CARELESS", _speed] call Fnc_wayPoint;
		["CiVGroup", Loc2, 2, "MOVE", "COLUMN", "BLUE", "CARELESS", _speed] call Fnc_wayPoint;
		["CiVGroup", Loc1, 3, "CYCLE", "COLUMN", "BLUE", "CARELESS", _speed] call Fnc_wayPoint;
	};
	{
	if (side _x == Civilian) then {
		_x disableAI "FSM";
		_x setOwner 0; //_clientID = owner _x; hint format["%1", _x];
		//_x addRating -10000;
		//hint format["%1", _x];
		};
	} ForEach AllUnits;
		ObjectMarkerList = nil;
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
	sleep 2;
	_group = CreateGroup EnemySide; 
	for "_i" from 1 to _number do {
		_unit = EnemyUnits call BIS_fnc_selectRandom;
		_soldier = _group createUnit [_unit,_location, [], 0, "FORM"];
		_soldier moveInAny _vehicle;
	};
	NewGroup = _group;
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
};

Fnc_SpawnSniper = {
	_unit = EnemySnipers call BIS_fnc_selectRandom;
	_marker = _this select 0;
	_spawn = (GetMarkerPos _marker);
	_position = _this select 1;
	_stance = _this select 2;
	_group = "StaticUnit";
	_group = CreateGroup EnemySide;
	_soldier = _unit createUnit [_spawn,_group,"this setDir _direction;this setposATL _position;this setUnitPos _stance;this forceSpeed 0;[this] call Fnc_RandomDirection;",0.5];
	StaticGroup = _group;
};

Fnc_SpawnAntiAir = {
	_unit = EnemyAntiAir call BIS_fnc_selectRandom;
	_marker = _this select 0;
	_spawn = (GetMarkerPos _marker);
	_position = _this select 1;
	_stance = _this select 2;
	_group = "StaticUnit";
	_group = CreateGroup EnemySide;
	_soldier = _unit createUnit [_spawn,_group,"this setDir _direction;this setposATL _position;this setUnitPos _stance;this forceSpeed 0;[this] call Fnc_RandomDirection;",0.5];
	StaticGroup = _group;
};

Fnc_RandomDirection = {
	_unit = _this select 0;
	ObjectMarkerList = getPos _unit nearObjects 50;
	Obj1 = ObjectMarkerList call BIS_fnc_selectRandom; Loc1 = getPosASL Obj1;
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
	if (_colour == "0") then { for "_i" from 0 to 4 do {NewVehicle setObjectTextureGlobal [_i, "mission\textures\british_green.jpg"];}; };
	if (_colour == "1") then { for "_i" from 0 to 4 do {NewVehicle setObjectTextureGlobal [_i, "mission\textures\russian_green.jpg"];}; };
	if (_colour == "2") then { for "_i" from 0 to 4 do {NewVehicle setObjectTextureGlobal [_i, "mission\textures\american_gold.jpg"];}; };
	if (_colour == "3") then { for "_i" from 0 to 4 do {NewVehicle setObjectTextureGlobal [_i, "mission\textures\german_grey.jpg"];}; };
	if (_colour == "4") then { NewVehicle setObjectTextureGlobal [0, "\A3\Air_F_EPB\Heli_Light_03\data\Heli_Light_03_base_CO.paa"]; };
	if (_colour == "5") then { NewVehicle setObjectTextureGlobal [0, "A3\Air_F\Heli_Light_02\Data\Heli_Light_02_ext_CO.paa"]; };
	if (_colour == "russian_ammo") then { NewVehicle setObjectTextureGlobal [0, "mission\textures\russian_green.jpg"]; NewVehicle setObjectTextureGlobal [1, "gol\russian_ammo.jpg"]; };
	if (_colour == "russian_fuel") then { NewVehicle setObjectTextureGlobal [0, "mission\textures\russian_green.jpg"]; NewVehicle setObjectTextureGlobal [1, "gol\russian_fuel.jpg"]; };
	if (_colour == "russian_mend") then { NewVehicle setObjectTextureGlobal [0, "mission\textures\russian_green.jpg"]; NewVehicle setObjectTextureGlobal [1, "gol\russian_mend.jpg"]; };
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
	_position = getPos _vehicle;
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
	_vehicle = _this select 0;
	_smoke = "test_EmptyObjectForSmoke" createVehicle position _vehicle; _smoke SetPos (GetPos _vehicle);
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
	_bomb = createVehicle ["Bo_GBU12_LGB", _location, [], 0, "CAN_COLLIDE"];
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
	
	_vehicle = createVehicle [_vehicle, VehicleLocation, [], 0, "FLY"]; _vehlocation = getPos _vehicle; _vehicle flyInHeight _altitude;

	_group = CreateGroup EnemySide; 
	for "_i" from 1 to _CrewCount do {
		_unit = EnemyUnits call BIS_fnc_selectRandom;
		_soldier = _group createUnit [_unit,_vehlocation,[],0,"private"];
		_soldier moveInAny _vehicle;
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
		_height = ((getPosASL _unit) select 2); _height = round _height;
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

Fnc_ServiceArea = {
	if (GoLServiceEnabled) then { 
		{
			if (side _x == west) then {
				ServiceSide = "WEST";
				GoLServicePod = "Land_Pod_Heli_Transport_04_box_F";
				GoLRearmPodColour = "russian_ammo";
				GoLRefuelPodColour = "russian_fuel";
				GoLRepairPodColour = "russian_mend";
			};
			
			if (side _x == east) then {
				ServiceSide = "EAST";
				GoLServicePod = "Land_Pod_Heli_Transport_04_box_F";
				GoLRearmPodColour = "russian_ammo";
				GoLRefuelPodColour = "russian_fuel";
				GoLRepairPodColour = "russian_mend";
			};
			
			if (side _x == resistance) then {
				ServiceSide = "GUER";
				GoLServicePod = "Land_Pod_Heli_Transport_04_box_F";
				GoLPodColour = "1";
			};
		} forEach playableUnits;
		
		if (isNil ("ServiceSide")) then {
			switch (playerSide) do { 
				case west: { 
					ServiceSide = "WEST";
					GoLServicePod = "Land_Pod_Heli_Transport_04_box_F";
					GoLRearmPodColour = "russian_ammo";
					GoLRefuelPodColour = "russian_fuel";
					GoLRepairPodColour = "russian_mend";
				};
				case east: { 
					ServiceSide = "EAST";
					GoLServicePod = "Land_Pod_Heli_Transport_04_box_F";
					GoLRearmPodColour = "russian_ammo";
					GoLRefuelPodColour = "russian_fuel";
					GoLRepairPodColour = "russian_mend";
				}; 
				case resistance: { 
					ServiceSide = "GUER";
					GoLServicePod = "Land_Pod_Heli_Transport_04_box_F";
					GoLRearmPodColour = "russian_ammo";
					GoLRefuelPodColour = "russian_fuel";
					GoLRepairPodColour = "russian_mend";
				}; 
			};
		};	
		
		// Refuel
		_marker = getMarkerPos "service_refuel";
		_mDir = markerDir "service_refuel";
		
		_trgRefuel = createTrigger["EmptyDetector",_marker]; _trgRefuel setTriggerArea[20,20,_mDir,false];
		_trgRefuel setTriggerActivation[ServiceSide,"PRESENT",true];
		_trgRefuel setTriggerStatements ["this and ((getpos (thisList select 0)) select 2 < 1) and (time % 5 > 4);", "null = [ (thisList select 0), 'refuel', '0'] spawn Fnc_ServiceGlobalExecute;", ""];
		_trgRefuel AttachTo [_marker,[0,0,0]];
		
		_newpos = [(_marker select 0) - 6.5, (_marker select 1) - 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle [GoLServicePod, _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle setFuel 0; NewVehicle = _vehicle; _vehicle SetDir (_mDir) - 60; [GoLRefuelPodColour] call Fnc_SetColor; clearWeaponCargoGlobal _vehicle;ClearMagazineCargoGlobal _vehicle;ClearItemCargoGlobal _vehicle;clearBackpackCargoGlobal _vehicle;
				
		_trgRefuel = createTrigger["EmptyDetector",_marker]; _trgRefuel setTriggerArea[20,20,_mDir,false];
		_trgRefuel setTriggerActivation[ServiceSide,"PRESENT",true];
		_trgRefuel setTriggerStatements ["this and ((getpos (thisList select 0)) select 2 < 1) and (time % 5 > 4);", "null = [ (thisList select 0), 'refuel', '1'] spawn Fnc_ServiceGlobalExecute;", ""];
		_trgRefuel AttachTo [_vehicle,[0,0,0]]; [_vehicle, "RefuelPod"] call Fnc_setName;
		
		_newpos = [_marker select 0, (_marker select 1) + 15, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_HelipadCircle_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir _mDir;
		
		_newpos = [_marker select 0, (_marker select 1) - 15, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_HelipadCircle_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir _mDir;
		
		_newpos = [_marker select 0, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['WaterPump_01_forest_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 270;
		
		_newpos = [(_marker select 0) + 3, (_marker select 1) - 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) - 10;
		
		_newpos = [(_marker select 0) - 1.5, (_marker select 1) - 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) - 30;
		
		_newpos = [(_marker select 0) + 3, (_marker select 1) + 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 150;
		
		_newpos = [(_marker select 0) - 1.5, (_marker select 1) + 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 120;
		
		_newpos = [(_marker select 0) - 0.5, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_MetalBarrel_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 180;
		
		_newpos = [(_marker select 0) + 0.5, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_MetalBarrel_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 180;
		
		_newpos = [(_marker select 0) + 1.5, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_MetalBarrel_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 270;
		
		_newpos = [(_marker select 0) + 4.5, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_WaterTank_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 330;
		
		_newpos = [(_marker select 0) - 3.3, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_WaterTank_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 30;
		
		_newpos = [(_marker select 0) + 3.4, (_marker select 1) + 2, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['CargoNet_01_barrels_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 330;
		
		_newpos = [(_marker select 0) - 2.2, (_marker select 1) + 2, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['CargoNet_01_barrels_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 30;
		
		// Rearm
		_marker = getMarkerPos "service_rearm";
		_mDir = markerDir "service_rearm";
		
		_trgRearm = createTrigger["EmptyDetector",_marker]; _trgRearm setTriggerArea[20,20,_mDir,false];
		_trgRearm setTriggerActivation[ServiceSide,"PRESENT",true];
		_trgRearm setTriggerStatements ["this and ((getpos (thisList select 0)) select 2 < 1);", "null = [ (thisList select 0), 'rearm', '0'] spawn Fnc_ServiceGlobalExecute;", ""];
		_trgRearm AttachTo [_marker,[0,0,0]];
		
		_newpos = [(_marker select 0) - 6.5, (_marker select 1) - 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle [GoLServicePod, _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle setVehicleAmmoDef 0; _vehicle setVehicleAmmo 0; NewVehicle = _vehicle; _vehicle SetDir (_mDir) - 60; [GoLRearmPodColour] call Fnc_SetColor; clearWeaponCargoGlobal _vehicle;ClearMagazineCargoGlobal _vehicle;ClearItemCargoGlobal _vehicle;clearBackpackCargoGlobal _vehicle;
		
		_trgRearm = createTrigger["EmptyDetector",_marker]; _trgRearm setTriggerArea[20,20,_mDir,false];
		_trgRearm setTriggerActivation[ServiceSide,"PRESENT",true];
		_trgRearm setTriggerStatements ["this and ((getpos (thisList select 0)) select 2 < 1);", "null = [ (thisList select 0), 'rearm', '1'] spawn Fnc_ServiceGlobalExecute;", ""];
		_trgRearm AttachTo [_vehicle,[0,0,0]]; [_vehicle, "RearmPod"] call Fnc_setName;
		
		_newpos = [_marker select 0, (_marker select 1) + 15, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_HelipadCircle_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir _mDir;
		
		_newpos = [_marker select 0, (_marker select 1) - 15, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_HelipadCircle_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir _mDir;
		
		_newpos = [(_marker select 0) + 3, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 180;
		
		_newpos = [(_marker select 0) - 1.5, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 180;
		
		_newpos = [(_marker select 0) - 3, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) - 50;
		
		_newpos = [(_marker select 0) + 1.5, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) - 50;
		
		_newpos = [(_marker select 0) - 0.5, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PaperBox_open_full_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 35;
		
		_newpos = [(_marker select 0) - 3, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PaperBox_open_empty_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 55;
		
		_newpos = [(_marker select 0) + 2.5, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PaperBox_closed_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 180;
		
		_newpos = [(_marker select 0) + 4.5, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PaperBox_closed_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 155;
		
		_newpos = [(_marker select 0) - 0.5, (_marker select 1) - 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PaperBox_open_full_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 35;
		
		_newpos = [(_marker select 0) - 3, (_marker select 1) - 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PaperBox_open_empty_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 55;
		
		_newpos = [(_marker select 0) + 2.5, (_marker select 1) - 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PaperBox_closed_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 180;
		
		_newpos = [(_marker select 0) + 4.5, (_marker select 1) - 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PaperBox_closed_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 155;
		
		_newpos = [(_marker select 0) + 5.5, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PalletTrolley_01_khaki_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 155;
		
		_newpos = [(_marker select 0) - 4.5, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PalletTrolley_01_khaki_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 55;
		
		// Repair
		_marker = getMarkerPos "service_repair";
		_mDir = markerDir "service_repair";
		
		_trgRepair = createTrigger["EmptyDetector",_marker]; _trgRepair setTriggerArea[20,20,_mDir,false];
		_trgRepair setTriggerActivation[ServiceSide,"PRESENT",true];
		_trgRepair setTriggerStatements ["this and ((getpos (thisList select 0)) select 2 < 1) and (time % 5 > 4);", "null = [ (thisList select 0), 'repair', '0'] spawn Fnc_ServiceGlobalExecute;", ""];
		_trgRepair AttachTo [_marker,[0,0,0]];
		
		_newpos = [(_marker select 0) - 7.5, (_marker select 1) - 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle [GoLServicePod, _objectpos, [], 0, 'CAN_COLLIDE']; NewVehicle = _vehicle; _vehicle SetDir (_mDir) - 60; [GoLRepairPodColour] call Fnc_SetColor; clearWeaponCargoGlobal _vehicle;ClearMagazineCargoGlobal _vehicle;ClearItemCargoGlobal _vehicle;clearBackpackCargoGlobal _vehicle;
		
		_trgRepair = createTrigger["EmptyDetector",_marker]; _trgRepair setTriggerArea[20,20,_mDir,false];
		_trgRepair setTriggerActivation[ServiceSide,"PRESENT",true];
		_trgRepair setTriggerStatements ["this and ((getpos (thisList select 0)) select 2 < 1) and (time % 5 > 4);", "null = [ (thisList select 0), 'repair', '1'] spawn Fnc_ServiceGlobalExecute;", ""];
		_trgRepair AttachTo [_vehicle,[0,0,0]]; [_vehicle, "RepairPod"] call Fnc_setName;
		
		_newpos = [_marker select 0, (_marker select 1) + 15, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_HelipadCircle_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir _mDir;
		
		_newpos = [_marker select 0, (_marker select 1) - 15, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_HelipadCircle_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir _mDir;
		
		_newpos = [(_marker select 0) + 3, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 180;
		
		_newpos = [(_marker select 0) - 1.5, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 180;
		
		_newpos = [(_marker select 0) - 3, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) - 50;
		
		_newpos = [(_marker select 0) + 1.5, _marker select 1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_PortableLight_double_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) - 50;
		
		_newpos = [(_marker select 0) + 4.5, (_marker select 1) - 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_CargoBox_V1_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 155;

		_newpos = [(_marker select 0) + 3, (_marker select 1) - 3, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_ToolTrolley_02_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 250;
		
		_newpos = [(_marker select 0) + 1, (_marker select 1) - 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_Workbench_01_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) - 30;
		
		_newpos = [(_marker select 0) - 1, (_marker select 1) - 1.9, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_GasTank_02_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) - 30;
		
		_newpos = [(_marker select 0) - 1.7, (_marker select 1) - 1.9, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_GasTank_02_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir _mDir;
		
		_newpos = [(_marker select 0) - 1.3, (_marker select 1) - 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_GasTank_02_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) - 160;
		
		_newpos = [(_marker select 0) - 4.5, (_marker select 1) - 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_CargoBox_V1_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 250;
		
		_newpos = [(_marker select 0) - 2.65, (_marker select 1) - 2.1, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_MetalCase_01_large_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 25;
		
		_newpos = [(_marker select 0) + 4.5, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_CargoBox_V1_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 155;
		
		_newpos = [(_marker select 0) + 1.5, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_CargoBox_V1_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 50;
		
		_newpos = [(_marker select 0) - 1, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_CargoBox_V1_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir 100;

		_newpos = [(_marker select 0) - 4.5, (_marker select 1) + 2.5, _marker select 2]; _objectpos = _newpos;
		_vehicle = createVehicle ['Land_CargoBox_V1_F', _objectpos, [], 0, 'CAN_COLLIDE']; _vehicle SetDir (_mDir) + 250;

	};
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

sleep 2;