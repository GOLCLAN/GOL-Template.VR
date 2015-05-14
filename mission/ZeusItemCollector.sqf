//this addAction ["<t color='#FF0000'>Zeus Item Collector</t>", "mission\ZeusItemCollector.sqf"];
//execVM "mission\ZeusItemCollector.sqf";

_ObjectMarkerList = getPos player nearObjects 50;
ZeusList = []; ZeusClassList = [];
_Pheight = getTerrainHeightASL (position player);
_Pheight = round _Pheight;

	{	
	_typeX = typeOf _x;
	_Objheight = getTerrainHeightASL (position _x);
	_Objheight = round _Objheight;
	GoLFilteredList = 0;
	
	_inignore = (str _typeX) in ['"HouseFly"','"ButterFly_random"','"HoneyBee"','"Mosquito"','"#mark"','"FxWindPollen1"','"FireFly"'];
	if (_inignore) then { GoLFilteredList = 1; } else { GoLFilteredList = 0; };
	
	if (isNil ("ZeusList")) then {
		if (player != _x && _Objheight == _Pheight && GoLFilteredList != 1) then { 
			 ZeusClassList = [_typeX]; ZeusList = [_x];	
		};	
	} else { 
		if (player != _x && _Objheight == _Pheight && GoLFilteredList != 1) then { 
			ZeusClassList = ZeusClassList + [_typeX];	ZeusList = ZeusList + [_x];
		};
	};
} forEach _ObjectMarkerList;

FullObjListing = []; _count = 0;

{
	_veh = ZeusClassList select _count;
	_count = _count + 1;
	_direction = getDir _x;
	_location = getPos _x;
	_strArr = format ["_vehicle = createVehicle ['%1', %3, [], 0, 'CAN_COLLIDE']; _vehicle setDir %2;", _veh, _direction, _location];
	if (isNil ("FullObjListing")) then { 
		FullObjListing = _strArr;
	} else { 
		FullObjListing = FullObjListing + [_strArr];
		copyToClipboard (str FullObjListing);
		hint format["%1 items Stored \n In your Clipboard", _count];
	};
} forEach ZeusList;