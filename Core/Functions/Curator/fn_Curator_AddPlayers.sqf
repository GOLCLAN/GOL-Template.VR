/*	================================================================
	AUTHOR: GuzzenVonLidl

	Description:
		Adds all players every active Curator(Zeus module) in the mission

	Usage:
		[] call GOL_Fnc_Curator_AddPlayers;

	Parameters:

	Returning Value:
		None

// ================================================================ */

	if (!isServer && isMultiplayer) exitWith {false};

	{
		_curator = _x;
		_curatorObjects = curatorEditableObjects _curator;
		{
			if (!(_x in _curatorObjects) && !(_x isKindOf "HeadlessClient_F")) then {
				if !(_x in (curatorEditableObjects _curator)) then {
					_curator addCuratorEditableObjects [[_x],true];
				};
			};
		} foreach (call GOL_Fnc_Players);
	} foreach (allCurators);
