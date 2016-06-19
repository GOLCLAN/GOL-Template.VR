//	[_Box] execVM "Scripts\NEKY_supply\NEKY_SupplyBox.sqf";
//	
//	Template
//	
//	This is a template for a customized supply box.

if !(isServer) exitWith {False};

Private "_Box";

_Box = [_This, 0, ObjNull, [ObjNull]] call BIS_fnc_Param;

// Clear Box
ClearItemCargoGlobal _Box;
ClearWeaponCargoGlobal _Box;
ClearBackPackCargoGlobal _Box;
ClearMagazineCargoGLobal _Box;
sleep 0.5;

// Add Items
_Box addWeaponCargoGlobal ["launch_B_Titan_F",1];
_Box addMagazinecargoglobal ["Titan_AA",4];
_Box addWeaponCargoGlobal ["launch_B_Titan_short_F",1];
_Box addMagazinecargoglobal ["Titan_AT",4];
_Box AddBackPackCargoGlobal ["B_HMG_01_support_high_F",1]; _Box AddBackPackCargoGlobal ["B_HMG_01_high_weapon_F",1]; // HMG Raised
_Box addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 20];
_Box addMagazineCargoglobal ["30Rnd_65x39_caseless_mag_Tracer", 20];
_Box addMagazineCargoGlobal ["NLAW_F", 2];
_Box addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer", 8];
_Box addMagazineCargoGlobal ["130Rnd_338_Mag", 6];
_Box addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 10];
_Box addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell", 10];
_Box addMagazineCargoGlobal ["HandGrenade", 10];
_Box addMagazineCargoGlobal ["MiniGrenade", 10];
_Box addMagazineCargoGlobal ["SmokeShell", 10];
_Box addMagazineCargoGlobal ["SmokeShellGreen", 10];