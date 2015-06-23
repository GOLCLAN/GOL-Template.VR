//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Creator    //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private ["_markers","_com","_scr","_side"];
scalar = "any";
DAC_Init_Camps = 0;

waituntil{time > 0.3};

if(HeadlessController) then {
	if(local player) then {
		DAC_Code = 1
	} else {
		DAC_Code = 0
	};
} else {
	if(isnull player) then {
		DAC_Code = 3
	} else {
		DAC_Code = 2
	};
};

_side = 2;
if ([Independent, East] call BIS_fnc_areFriendly) then {
	_side = 0;
};
if ([Independent, West] call BIS_fnc_areFriendly) then {
	_side = 1;
};
_markers = 1;
_com = [1,2,3,0];
if (isMultiplayer) then {
	_markers = 0;
	_com = [0,0,0,0];
};

//===============|
// DAC_Settings	 |
//===============|=============================================================================================|

	if(isNil "DAC_STRPlayers")		then {		DAC_STRPlayers = ["s1","s2","s3","s4","s5",
		"wpl","wfac","wecho1","wecho2","wecho3","wecho4","wecho5","wecho6",
		"w1a1","w1a2","w1a3","w1a4","w1a5","w1a6","w1b1","w1b2","w1b3","w1b4","w1b5","w1b6","w1c1","w1c2","w1c3","w1c4","w1c5",
		"w2a1","w2a2","w2a3","w2a4","w2a5","w2a6","w2b1","w2b2","w2b3","w2b4","w2b5","w2b6","w2c1","w2c2","w2c3","w2c4","w2c5",
		"epl","efac","eecho1","eecho2","eecho3","eecho4","eecho5","eecho6",
		"e1a1","e1a2","e1a3","e1a4","e1a5","e1a6","e1b1","e1b2","e1b3","e1b4","e1b5","e1b6","e1c1","e1c2","e1c3","e1c4","e1c5",
		"e2a1","e2a2","e2a3","e2a4","e2a5","e2a6","e2b1","e2b2","e2b3","e2b4","e2b5","e2b6","e2c1","e2c2","e2c3","e2c4","e2c5",
		"ipl","ifac","iecho1","iecho2","iecho3","iecho4","iecho5","iecho6",
		"i1a1","i1a2","i1a3","i1a4","i1a5","i1a6","i1b1","i1b2","i1b3","i1b4","i1b5","i1b6","i1c1","i1c2","i1c3","i1c4","i1c5",
		"i2a1","i2a2","i2a3","i2a4","i2a5","i2a6","i2b1","i2b2","i2b3","i2b4","i2b5","i2b6","i2c1","i2c2","i2c3","i2c4","i2c5"];};
	if(isNil "DAC_AI_Count_Level")	then {		DAC_AI_Count_Level  = [[2,4],[3,6],[4,8],[6,12],[1,2]]				};
	if(isNil "DAC_Dyn_Weather") 	then {		DAC_Dyn_Weather		= [0,0,0,[0, 0, 0],0]							};
	if(isNil "DAC_Reduce_Value") 	then {		DAC_Reduce_Value	= [800,850,0.5]									};
	if(isNil "DAC_AI_Spawn") 		then {		DAC_AI_Spawn		= [[10,5,5],[10,5,15],0,120,250,0]				};
	if(isNil "DAC_Delete_Value") 	then {		DAC_Delete_Value	= [[300,150],[600,150],6000]					};
	if(isNil "DAC_Del_PlayerBody") 	then {		DAC_Del_PlayerBody	= [0,0]											};
	if(isNil "DAC_Com_Values") 		then {		DAC_Com_Values		= _com											};
	if(isNil "DAC_AI_AddOn") 		then {		DAC_AI_AddOn		= 1												};
	if(isNil "DAC_AI_Level") 		then {		DAC_AI_Level		= 3												};
	if(isNil "DAC_Res_Side") 		then {		DAC_Res_Side		= _side											};
	if(isNil "DAC_Marker") 			then {		DAC_Marker			= _markers										};
	if(isNil "DAC_WP_Speed") 		then {		DAC_WP_Speed		= 0.01											};
	if(isNil "DAC_Join_Action")		then {		DAC_Join_Action		= false											};
	if(isNil "DAC_Fast_Init") 		then {		DAC_Fast_Init		= false											};
	if(isNil "DAC_Player_Marker")	then {		DAC_Player_Marker	= false											};
	if(isNil "DAC_Direct_Start")	then {		DAC_Direct_Start	= false											};
	if(isNil "DAC_Activate_Sound")	then {		DAC_Activate_Sound	= false											};
	if(isNil "DAC_Auto_UnitCount")	then {		DAC_Auto_UnitCount	= [8,10]										};
	if(isNil "DAC_Player_Support")	then {		DAC_Player_Support	= [10,[4,2000,3,1000]]							};
	if(isNil "DAC_SaveDistance")	then {		DAC_SaveDistance	= [500,["DAC_Save_Pos"]]						};
	if(isNil "DAC_Radio_Max")		then {		DAC_Radio_Max		= DAC_AI_Level									};
	if(isNil "DAC_Radio_Settings")	then {		DAC_Radio_Settings = [1000,[0,0],5,2,objNull];						};

	DAC_SP_Soldiers     =   ["B_soldier_AR_F","B_G_soldier_AR_F","O_soldier_AR_F","O_soldierU_AR_F","O_G_soldier_AR_F","I_soldier_AR_F","I_G_soldier_AR_F","GOL_AR_INS","GOL_AR_TALI","rhs_msv_machinegunner"];
	DAC_GunNotAllowed	= 	[];
	DAC_VehNotAllowed	= 	[];
	DAC_Locked_Veh		=	[mhq];	// MHQ is off limits for ai
	DAC_BadBuildings 	= 	[];
	DAC_Data_Array 		= 	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,[]];
	DAC_Marker_Val		= 	[];
	DAC_Zones			=	[];

	DAC_SayArrayE  	= 	[];
	DAC_SayArrayW  	= 	[];
	DAC_SayArrayD  	= 	[];
	DAC_RadioArrayE	= 	[];
	DAC_RadioArrayW	= 	[];
	//=============================================================================================================|

	_scr = [] spawn (compile preprocessFile "\DAC_Source\Scripts\DAC_Start_Creator.sqf");
	waituntil {scriptdone _scr};
	sleep 0.1;
	waituntil {(DAC_Basic_Value > 0)};
