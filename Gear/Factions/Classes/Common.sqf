// ===========================

// Adds NVG's when its getting dark or 3 hours until darkness
if(daytime > 17 || (daytime > 0 && daytime < 6)) Then {
	_nightTime = true;
} else {
	_nightTime = false;
};

// ===========================

// Item
_map = "ItemMap";
_compass = "ItemCompass";
_watch = "ItemWatch";
_gps = "ItemGPS";
_DAGR = "ACE_DAGR";
_bino = "ACE_Vector";
_rangefinder = "ACE_Vector";
_laser = "Laserdesignator";
_laserb = "Laserbatteries";
_nvg = "NVGoggles_Opfor";
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

// ACE
_mapTools = "ACE_MapTools";
_kestrel = "ACE_ItemKestrel";
_IRStrobe = "ACE_IR_Strobe_Item";
_barrel = "ACE_SpareBarrel";
_earplugs = "ACE_EarBuds";
_clacker = "ACE_M26_Clacker";
_defusalKit = "ACE_DefusalKit";
_cables = "ACE_CableTie";
_bandage = "ACE_fieldDressing";
_bandagePacking = "ACE_packingBandage";
_bandageElastic = "ACE_elasticBandage";
_morph = "ACE_morphine";
_epi = "ACE_epinephrine";
_blood = "ACE_bloodIV";
_rangecard = "ACE_RangeCard";
_rangecard88 = "ACE_RangeTable_82mm";
_sprayG = "ACE_SpraypaintGreen";
_sprayR = "ACE_SpraypaintRed";
_sprayB = "ACE_SpraypaintBlue";
_sprayBl = "ACE_SpraypaintBlack";

// ===========================

// EQUIPMENT
_grenade = "HandGrenade";
_grenademini = "MiniGrenade";
_flashBang = "ACE_M84";
_smokegrenadeW = "SmokeShell";
_smokegrenadeG = "SmokeShellGreen";
_smokegrenadeR = "SmokeShellRed";
_smokegrenadeY = "SmokeShellYellow";
_smokegrenadeP = "SmokeShellPurple";
_chemG =  "Chemlight_green";
_chemR = "Chemlight_red";
_chemY =  "Chemlight_yellow";
_chemB = "Chemlight_blue";
_handFlareG = "ACE_HandFlare_Green";
_handFlareR = "ACE_HandFlare_Red";
_handFlareW = "ACE_HandFlare_White";
_handFlareY = "ACE_HandFlare_Yellow";

// GRENADE LAUNCHER ITEMS
_glHE = "1Rnd_HE_Grenade_shell";
_glHER = "1Rnd_HE_Grenade_shell";

_glsmokeW = "1Rnd_Smoke_Grenade_shell";
_glsmokeG = "1Rnd_SmokeGreen_Grenade_shell";
_glsmokeR = "1Rnd_SmokeRed_Grenade_shell";
_glsmokeY = "1Rnd_SmokeYellow_Grenade_shell";
_glsmokeP = "1Rnd_SmokePurple_Grenade_shell";
_glsmokeB = "1Rnd_SmokeBlue_Grenade_shell";
_glsmokeO = "1Rnd_SmokeOrange_Grenade_shell";

_glsmokeWR = "1Rnd_Smoke_Grenade_shell";
_glsmokeGR = "1Rnd_SmokeGreen_Grenade_shell";
_glsmokeRR = "1Rnd_SmokeRed_Grenade_shell";	

_glflareW = "UGL_FlareWhite_F";
_glflareG = "UGL_FlareGreen_F";
_glflareR = "UGL_FlareRed_F";
_glflareY = "UGL_FlareYellow_F";
_glflareIR = "UGL_FlareCIR_F";

// ===========================
/*
ACE_fieldDressing
ACE_packingBandage
ACE_elasticBandage
ACE_tourniquet
ACE_morphine
ACE_epinephrine

ACE_atropine
ACE_quikclot
ACE_personalAidKit
ACE_surgicalKit
ACE_bodyBag

ACE_plasmaIV
ACE_bloodIV
ACE_bloodIV_500
ACE_bloodIV_250
ACE_salineIV
*/