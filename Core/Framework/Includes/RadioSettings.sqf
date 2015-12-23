// *
// *	This script handles the frequency for the 152 and backpack radio
// *
// ====================================================================================

	if ((isClass(configFile>>"CfgPatches">>"task_force_radio")) && (isClass(configFile>>"CfgPatches">>"task_force_radio_items"))) then {

		#include "\task_force_radio\functions\common.sqf"
		// ===============================================

		MakePublic(TF_give_personal_radio_to_regular_soldier, false);
		MakePublic(TF_give_microdagr_to_soldier, false);
		MakePublic(TF_no_auto_long_range_radio, true);
		MakePublic(TF_same_sw_frequencies_for_side, true);
		MakePublic(TF_same_lr_frequencies_for_side, true);
		MakePublic(TF_same_dd_frequencies_for_side, true);
		MakePublic(tf_west_radio_code, "_golclan");
		MakePublic(tf_east_radio_code, "_golclan");
		MakePublic(tf_guer_radio_code, "_golclan");
		MakePublic(TF_terrain_interception_coefficient, 9.0);

		// ===============================================
		MakePublic(tf_defaultWestAirborneRadio, "tf_anarc164");
		MakePublic(tf_defaultWestBackpack, "tf_rt1523g");
		MakePublic(tf_defaultWestPersonalRadio, "tf_anprc152");
		MakePublic(tf_defaultWestRiflemanRadio, "tf_pnr1000a");
		MakePublic(tf_defaultEastAirborneRadio, "tf_anarc164");
		MakePublic(tf_defaultEastBackpack, "tf_rt1523g");
		MakePublic(tf_defaultEastPersonalRadio, "tf_anprc152");
		MakePublic(tf_defaultEastRiflemanRadio, "tf_pnr1000a");
		MakePublic(tf_defaultGuerAirborneRadio, "tf_anarc164");
		MakePublic(tf_defaultGuerBackpack, "tf_rt1523g");
		MakePublic(tf_defaultGuerPersonalRadio, "tf_anprc152");
		MakePublic(tf_defaultGuerRiflemanRadio, "tf_pnr1000a");

		// ===============================================
		if (hasInterface) then {
			#define	TFAR_setFreq	[0 ,7, ["10","20","30","40","50.1","50.2","50.3","50.5"], 0, nil, -1, 0]
			#define	isLeader	(leader player == player)

			player setVariable ["tf_receivingDistanceMultiplicator", 1.2];
			player setVariable ["tf_sendingDistanceMultiplicator", 0.7];

			(group player) setVariable ["tf_sw_frequency", TFAR_setFreq, isLeader];
			(group player) setVariable ["tf_lr_frequency", TFAR_setFreq, isLeader];
			(group player) setVariable ["tf_dd_frequency", TFAR_setFreq, isLeader];
		};

		_DebugName = "GOL_Radios";
		scriptName _DebugName;
		["RADIOS INITIALIZED SUCCESSFULLY",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
		// ===============================================
	};
