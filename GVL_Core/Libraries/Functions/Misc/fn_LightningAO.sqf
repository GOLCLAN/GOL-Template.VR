//	["respawn_guerrila",10,50] call GVL_Fnc_randomLightning;

_this spawn {

	if !(isServer) exitWith {false};

	_target = [_this, 0] call BIS_fnc_param;
	_rounds = [_this, 1] call BIS_fnc_param;
	_radius = [_this, 2, 200, [0]] call BIS_fnc_param;
	_targetAO = [_target] call GVL_Fnc_GetPos;

	_LogicCenter = createCenter sideLogic;
	_moduleGroup = createGroup _LogicCenter;
	_logic = _moduleGroup createUnit["Logic",_targetAO,[],0,"NONE"];

	sleep 2;

	while {lightnings > 0.1} do {
		_posX = (_targetAO select 0) + (_radius - (random (2*_radius)));
		_posY = (_targetAO select 1) + (_radius - (random (2*_radius)));
		_strikePos = [_posX, _posY, 0];

		sleep (floor(random 30) + 30);

		_logic setPosATL _strikePos;
		[_logic,nil,true] call BIS_fnc_moduleLightning;
	};
	deleteVehicle _logic;
};
