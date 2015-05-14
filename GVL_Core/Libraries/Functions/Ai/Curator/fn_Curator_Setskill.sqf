// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		Dynamicly adjusts the skill level of every ai placed down by a curator
// *		The ai gets a skill level of a random value between 0.2 and 0.4
// *
// *	Usage:
// *		[] call GVL_Fnc_Curator_Setskill;
// *
// *	Parameters:
// *
// *	Returning Value:
// *		None
// *
// ================================================================

	if (!isServer && isMultiplayer) exitWith {false};
	if (isNil "GVL_CuratorUnitSkillList") then {	GVL_CuratorUnitSkillList = []; };
	{
		{
			if !(_x in GVL_CuratorUnitSkillList) then {
				_x setSkill ([0.2,0.3,0.4] call BIS_fnc_selectRandom);
				GVL_CuratorUnitSkillList pushBack _x;
			};
		} foreach (curatorEditableObjects _x);
	} foreach (allCurators);
