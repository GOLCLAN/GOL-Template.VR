
	#define ANY sideLogic

	private ["_marker","_markerName","_radius","_newMarker"];
	_marker = _this select 0;
	_markerName = _this select 1;
	_radius = ["MissionStart", "Radius"] call GVL_Fnc_GetConfig;

	_newMarker = createMarkerLocal [_markerName, markerPos _marker];
	_newMarker setMarkerShapeLocal "ELLIPSE";
	_newMarker setMarkerBrushLocal "Border";
	_newMarker setMarkerSizeLocal [_radius, _radius];
	AO_Markers set [count AO_Markers, _newMarker];
