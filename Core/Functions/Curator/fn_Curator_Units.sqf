/*	================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		Dynamicly adds every unit & vehicle on the map to all curators

	Usage:
		[] call GOL_Fnc_Curator_Units;

	Parameters:

	Returning Value:
		None

// ================================================================ */

	if (!isServer && isMultiplayer) exitWith {false};
	{
		_curator = _x;
		_curatorObjects = curatorEditableObjects _curator;
		{
			if (!(isPlayer _x) && !(_x isKindOf "HeadlessClient_F") && !(_x in allMapMarkers) && !(_x in switchableUnits)) then {
				if (!(_x in (curatorEditableObjects _curator)) && (_x isKindOf "AllVehicles")) then {
					_curator addCuratorEditableObjects [[_x],true];
				};
			};
		} foreach (allUnits + vehicles);
	} foreach (allCurators);
