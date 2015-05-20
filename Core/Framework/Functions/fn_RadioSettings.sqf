// *
// *	This script handles the frequency for the 152 and backpack radio
// *
// ====================================================================================

	if ((isClass(configFile>>"CfgPatches">>"task_force_radio")) && (isClass(configFile>>"CfgPatches">>"task_force_radio_items"))) then {

		#include "\task_force_radio\functions\common.sqf";

		// ===============================================

		tf_west_radio_code = "_golclan";
		tf_east_radio_code = "_golclan";
		tf_guer_radio_code = "_golclan";
		TF_give_personal_radio_to_regular_soldier = false;
		TF_give_microdagr_to_soldier = false;
		tf_no_auto_long_range_radio = true;
		tf_same_sw_frequencies_for_side = true;
		tf_same_lr_frequencies_for_side = true;
		tf_same_dd_frequencies_for_side = true;

		// ===============================================

		tf_freq_west	= [0 ,5, ["10","20","30","40","50.1","50.2","50.3","50.5"],0, nil, -1, 0];
		tf_freq_west_lr = [4 ,5, ["10","20","30","40","50.1","50.2","50.3","50.4","50.5"],0, nil, -1, 0];
		tf_freq_east	= [0 ,5, ["10","20","30","40","50.1","50.2","50.3","50.5"],0, nil, -1, 0];
		tf_freq_east_lr = [4 ,5, ["10","20","30","40","50.1","50.2","50.3","50.4","50.5"],0, nil, -1, 0];
		tf_freq_guer	= [0 ,5, ["10","20","30","40","50.1","50.2","50.3","50.5"],0, nil, -1, 0];
		tf_freq_guer_lr = [4 ,5, ["10","20","30","40","50.1","50.2","50.3","50.4","50.5"],0, nil, -1, 0];

		// ===============================================

		tf_defaultWestAirborneRadio = "tf_anarc164";
		tf_defaultWestBackpack = "tf_rt1523g";
		tf_defaultWestPersonalRadio = "tf_anprc152";
		tf_defaultWestRiflemanRadio = "tf_pnr1000a";

		tf_defaultEastAirborneRadio = "tf_anarc164";
		tf_defaultEastBackpack = "tf_rt1523g";
		tf_defaultEastPersonalRadio = "tf_anprc152";
		tf_defaultEastRiflemanRadio = "tf_pnr1000a";

		tf_defaultGuerAirborneRadio = "tf_anarc164";
		tf_defaultGuerBackpack = "tf_rt1523g";
		tf_defaultGuerPersonalRadio = "tf_anprc152";
		tf_defaultGuerRiflemanRadio = "tf_pnr1000a";

		// ===============================================

		_DebugName = "GOL_Radios";
		scriptName _DebugName;
		["RADIOS INITIALIZED SUCCESSFULLY",[_DebugName,__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;

		// ===============================================
	};
