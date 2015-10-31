//	null = [this] spawn GOL_Fnc_ServiceStation_OTM;
//
//	Add the command above to an object you want to be a moveable service station.
//
//	Made by NeKo-ArroW with help from GuzzenVonLidl
//	Thanks to Raptor for helping me out testing this on dedicated server
//	{ if ((_x isKindOf "Air" || _x isKindOf "LandVehicle") and (isTouchingGround _x)) then {true};} count thisList == 1;

Private ["_this","_Object","_x","_Params","_Trg","_xRadius","_yRadius","_Condition","_Activated"];

////////////////////
//	Variables you //
//   can modify	  //
////////////////////

_xRadius = 12;
_yRadius = 12;

////////////////////////////
// Don't Touch code below //
////////////////////////////

_Object = _this select 0;

_Object addAction ["<t color='#00FF00'>Activate Service Station</t>",{
	_Params = [_This, 3] call BIS_fnc_Param;
	_Object = [_Params, 0] call BIS_fnc_ParamIn;
	_xRadius = [_Params, 1] call BIS_fnc_ParamIn;
	_yRadius = [_Params, 2] call BIS_fnc_ParamIn;
	_Activated = True;

	Hint "Service Station Activated. (Remember to only have ONE vehicle close to this object!)";
	[[[_Object,_xRadius,_yRadius,_Activated], {
		Private "_Trg";
		_Object = (_This select 0);
		_xRadius = (_This select 1);
		_yRadius = (_This select 2);
		_Activated = (_This select 3);

		removeAllActions (_This select 0);
		_Trg = CreateTrigger ["EmptyDetector",(getpos _Object)];
		_Trg setTriggerArea [_xRadius,_yRadius,0,false];
		_Trg SetTriggerActivation ["ANY","PRESENT",true];
		_Trg setTriggerTimeOut [4,4,4,true];
		sleep 0.5;
		_Condition = "{ (_x isKindOf 'Air' || _x isKindOf 'LandVehicle') && (isTouchingGround _x) } count thisList == 1;";
		_Trg setTriggerStatements [_Condition,"[ThisList, ThisTrigger] spawn GOL_Fnc_ServiceStation",""];
		sleep 1;

			_Object addAction ["<t color='#FF0000'>Deactivate Service Station</t>",{
				_Params = [_This, 3] call BIS_fnc_Param;
				_Object = [_Params, 0] call BIS_fnc_ParamIn;
				_Trg = [_Params, 1] call BIS_fnc_ParamIn;

				Hint "Service Station Deactivated.";
				[[[_Object],{removeAllActions (_This select 0)}], "BIS_Fnc_Spawn", True, False, False] Call BIS_fnc_MP;
				_Trg setTriggerArea [0,0,0,false];
				[[[_Object],{[(_This select 0)] spawn GOL_Fnc_ServiceStation_OTM;}], "BIS_Fnc_Spawn", True, False, False] Call BIS_fnc_MP;
				sleep 5;
				deleteVehicle _Trg;
			},[_Object,_Trg],4,false,true];

			// If object is moved
			While {sleep 10; _Activated} do {
				if ((!((velocity _Object select 0) == 0) or !((velocity _Object select 1) == 0) or !((velocity _Object select 2) == 0) or !(Alive _Object)) and _Activated) then {
					_Activated = False;
					removeAllActions _Object;
					_Trg setTriggerArea [0,0,0,false];
					[_Object] spawn GOL_Fnc_ServiceStation_OTM;
					sleep 5;
					deleteVehicle _Trg;
				};
			};
	}], "BIS_Fnc_Spawn", True, false, False] call BIS_fnc_MP;
},[_Object,_xRadius,_yRadius],4,false,true];
