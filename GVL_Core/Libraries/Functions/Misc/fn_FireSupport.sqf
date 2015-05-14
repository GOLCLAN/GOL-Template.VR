//	[m1,"respawn_guerrila",10] call GVL_Fnc_FireSupport;

_this spawn {
	private ["_mortar","_rounds","_radius","_targetAO","_LogicCenter","_moduleGroup","_logic","_dir","_position","_diff","_altitude","_sleep","_weapon","_Mag","_getpos","_velocity","_strikePos","_posX","_posY","_posAmmo","_Ammo","_smoke","_smokePos","_shell"];

	if !(isServer) exitWith {false};

	_mortar = [_this, 0, "Error", [objNull]] call BIS_fnc_param;
	_target = [_this, 1] call BIS_fnc_param;
	_rounds = [_this, 2, 5, [0]] call BIS_fnc_param;
	_radius = [_this, 3, 200, [0]] call BIS_fnc_param;
	_targetAO = [_target] call GVL_Fnc_GetPos;
	_mortar setVehicleAmmo 0;
	_mortar addEventHandler ["Fired",{
		(_this select 6) setPosASL [0,0,0];
		deleteVehicle (_this select 6);
	}];
	_mortar setdir ([_mortar, _targetAO] call BIS_fnc_relativeDirTo);
	_mortar doWatch [(_targetAO select 0),(_targetAO select 1),1000];

	_LogicCenter = createCenter sideLogic;
	_moduleGroup = createGroup _LogicCenter;
	_logic = _moduleGroup createUnit["Logic",_targetAO,[],0,"NONE"];
	_logic setDir (getDir _mortar);
	_dir = direction _logic;
	_position = [_logic] call GVL_Fnc_GetPos;

	_diff = 500;
	_altitude = 1000;
	_sleep = 5.2;


	switch (true) do {
	    case (_mortar isKindOf "tank"): {
			_weapon = "mortar_155mm_AMOS";
			_Mag = "6Rnd_155mm_Mo_smoke";
			_mortar addMagazineTurret [_Mag,[0]];
	    };
	    case (_mortar isKindOf "StaticMortar"): {
			_weapon = "mortar_82mm";
			_Mag = "8Rnd_82mm_Mo_Flare_white";
			_mortar addMagazineTurret [_Mag,[0]];
		};
	};

	_getpos = {
		_velocity = [sin _dir * 68,cos _dir * 68, -100];
		_strikePos = [_posX, _posY, _altitude];
//		_strikePos = [(_targetAO select 0),(_targetAO select 1),1000];	// Center
		_posAmmo = [_strikePos, _diff, ([_mortar, _strikePos] call BIS_fnc_dirTo) + 180] call BIS_fnc_relPos;
	};

	sleep 5;

	for "_i" from 0 to _rounds step 1 do {
		if (!alive _mortar) exitWith {false};
		_posX = (_targetAO select 0) + (_radius - (random (2*_radius)));
		_posY = (_targetAO select 1) + (_radius - (random (2*_radius)));
		[] call _getpos;
		sleep (floor(random 2) + 1);

	    _Ammo = _mortar ammo _weapon;
	    _mortar fire _weapon;
		waitUntil {sleep 0.5; _Ammo > (_mortar ammo _weapon)};
	    if (_Ammo < 2) then { _mortar setAmmo [currentWeapon _mortar, 5]; };
	    sleep (floor(random 4) + 2);
	    _logic setPosATL [(_strikePos select 0), (_strikePos select 1),50];
	    _smoke = "SmokeShell" createVehicle _posAmmo;
		_smoke setvelocity _velocity;
	    sleep _sleep;
//	    [[_logic,"mortar1","say3D"],"bis_fnc_sayMessage"] call bis_fnc_mp;
		[[[_logic], {
			(_this select 0) say3D "mortar1";
		}], "bis_fnc_call", true] call BIS_fnc_MP;
	    sleep 2.1;
	    _smokePos = getPosATL _smoke;
	    _shell = "Sh_82mm_AMOS" createVehicle _smokePos;
	    _shell setVelocity [0,0,-5];
		[[[_smokePos,_radius], {
//			if (player distance (_this select 0) < (_this select 1)) then {
//				addCamShake [5, 1, 25];
//			};
			_dist = (player distance (_this select 0));
			_force 		= 4	-	(_dist / 400);
			_length 	= 2.5	-	(_dist / 480);
			_frequency	= 40	-	(_dist /  50);
			if (_force < 0) then {_force = 0};
			if (_length < 0) then {_length = 0};
			if (_frequency < 0) then {_frequency = 0};
			sleep (_dist/343);
			addCamShake [_force, _length, _frequency];
		}], "bis_fnc_call", true, false, false] call BIS_fnc_MP;
	    deleteVehicle _smoke;
	};
	deleteVehicle _logic;
};
