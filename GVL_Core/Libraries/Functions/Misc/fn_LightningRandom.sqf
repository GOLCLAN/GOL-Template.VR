//	[200] call GVL_Fnc_randomLightning;

	private ["_radius","_players","_LogicCenter","_moduleGroup","_logic","_targetAO","_posX","_posY","_strikePos"];

	if !(isServer) exitWith {false};

	_radius = [_this, 0, 200, [0]] call BIS_fnc_param;
	_players = [];
	if (isNil "GVL_Lightning_Active") then {
		GVL_Lightning_Active = false;
	};
	publicVariable "GVL_Lightning_Active";

	_LogicCenter = createCenter sideLogic;
	_moduleGroup = createGroup _LogicCenter;
	_logic = _moduleGroup createUnit["Logic",[0,0,0],[],0,"NONE"];
	_getPlayers = {
		{
			if !(vehicle _x != _x) then {
				_players pushback _x;
			};
		} forEach (call CBA_Fnc_Players);
	};

	sleep 2;

//	_sleep = (floor(random 120) + 5);
	_sleep = (floor(random 5) + 5);
	if (lightnings > 0) then {
		_sleep = (30/lightnings);
	};

//	while {lightnings > 0.1} do {
	while {GVL_Lightning_Active} do {
		[] call _getPlayers;
		_targetAO = [(_players call bis_fnc_selectRandom)] call GVL_Fnc_GetPos;
		_posX = (_targetAO select 0) + (_radius - (random (2*_radius)));
		_posY = (_targetAO select 1) + (_radius - (random (2*_radius)));
		_strikePos = [_posX, _posY, 0];

		sleep _sleep;
//		sleep (floor(random 3) + 1);

		_logic setPosATL _strikePos;
		[_logic,nil,true] call BIS_fnc_moduleLightning;
	};
	deleteVehicle _logic;
