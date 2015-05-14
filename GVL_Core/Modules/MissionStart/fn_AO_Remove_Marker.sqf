
	private["_marker"];
	_marker = _this select 0;

	{
		deleteMarkerLocal _x;
		AO_Markers = AO_Markers - [_x];
	} forEach _marker;
