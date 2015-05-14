// ===========================

	_platoon = ["pl","fac","ftl","p"];
	_squad = ["ftl","r","g","ag","ar","lr"];
	_binoArray = ["pl","fac","ftl","ag"];
	_pistolArray = ["pl","fac","ftl","r","g","ag","ar","lr","p"];
//	_ctabArray = ["pl","fac","p"];
	_rifleArray = ["pl","fac","r","ag"];
	_rifleGLArray = ["ftl","g"];

	// Adds NVG's when its getting dark or 3 hours until darkness
	if(daytime > 17 || (daytime > 0 && daytime < 6)) Then {
		_nightTime = true;
	} else {
		_nightTime = false;
	};

	switch (_typeofUnit) do {
	    case "pl":	{	_Color = "GREEN";	};
	    case "fac": {	_Color = "YELLOW";	};
	    case "ftl": {	_Color = "GREEN";	};
	    case "r":	{	_Color = "RED";		};
	    case "g":	{	_Color = "RED";		};
	    case "ag":	{	_Color = "BLUE";	};
	    case "ar":	{	_Color = "BLUE";	};
	    case "lr":	{	_Color = "BLUE";	};
	    case "p":	{	_Color = "YELLOW";	};
	    default		{	_Color = "WHITE";	};
	};

// ===========================

	// Item
	_map = "ItemMap";
	_compass = "ItemCompass";
	_watch = "ItemWatch";
	_gps = "ItemGPS";
	_bino = "AGM_Vector";
	_rangefinder = "AGM_Vector";
	_laser = "LaserDesignator";
	_nvg = "AGM_NVG_Gen4";
	_toolkit = "ToolKit";

	_FAKBig = "MediKit";
	_FAKSmall = "FirstAidKit";

	_demoCharge = "DemoCharge_Remote_Mag";
	_satchelCharge = "SatchelCharge_Remote_Mag";

// ===========================

	// TFR Radios
	_radio152 = "tf_anprc152";	// MidRange
	_radio1000a = "tf_pnr1000a";	// ShortRange

	// Commander Tablet
	_cTab = "ItemcTab";
	_Android = "ItemAndroid";
	_microDAGR = "ItemMicroDAGR";
	_HelmetCam = "ItemcTabHCam";

	// AGM
	_mapTools = "AGM_MapTools";
	_kestrel = "AGM_ItemKestrel";
	_IRStrobe = "AGM_IR_Strobe_Item";
	_barrel = "AGM_SpareBarrel";
	_earplugs = "AGM_EarBuds";
	_clacker = "AGM_Clacker";
	_defusalKit = "AGM_DefusalKit";
	_cables = "AGM_CableTie";

	_bandage = "AGM_Bandage";
	_morph = "AGM_Morphine";
	_epi = "AGM_Epipen";
	_blood = "AGM_Bloodbag";

// ===========================

	// EQUIPMENT
	_grenade = "HandGrenade";
	_grenademini = "MiniGrenade";
	_flashBang = "AGM_M84";
	_smokegrenadeW = "SmokeShell";
	_smokegrenadeG = "SmokeShellGreen";
	_smokegrenadeR = "SmokeShellRed";
	_smokegrenadeY = "SmokeShellYellow";
	_smokegrenadeP = "SmokeShellPurple";
	_chemG =  "Chemlight_green";
	_chemR = "Chemlight_red";
	_chemY =  "Chemlight_yellow";
	_chemB = "Chemlight_blue";
	_handFlareG = "AGM_HandFlare_Green";
	_handFlareR = "AGM_HandFlare_Red";
	_handFlareW = "AGM_HandFlare_White";
	_handFlareY = "AGM_HandFlare_Yellow";

	// GRENADE LAUNCHER ITEMS
	_glHE = "1Rnd_HE_Grenade_shell";

	_glsmokeW = "1Rnd_Smoke_Grenade_shell";
	_glsmokeG = "1Rnd_SmokeGreen_Grenade_shell";
	_glsmokeR = "1Rnd_SmokeRed_Grenade_shell";
	_glsmokeY = "1Rnd_SmokeYellow_Grenade_shell";
	_glsmokeP = "1Rnd_SmokePurple_Grenade_shell";
	_glsmokeB = "1Rnd_SmokeBlue_Grenade_shell";
	_glsmokeO = "1Rnd_SmokeOrange_Grenade_shell";

	_glflareW = "UGL_FlareWhite_F";
	_glflareG = "UGL_FlareGreen_F";
	_glflareR = "UGL_FlareRed_F";
	_glflareY = "UGL_FlareYellow_F";
	_glflareIR = "UGL_FlareCIR_F";

// ===========================
