//	#include "NEKY_SupplySettings.sqf"
//	
//	This is where you set all the settings for the supply drop


// Name of units allowed to call in supply drops \\
_Callers = ["w1a1", "w1b1", "w1c1", "w1d1","w1e1", "e1a1", "e1b1", "e1c1", "e2a1", "e2b1", "e2c1", "i1a1", "i1b1", "i1c1", "i2a1", "i2b1", "i2c1"];


// Available Radio Commands \\
_Channels = 
[
	["Alpha", "Small Box", blufor, "", "drop", ["ingress","_pos","egress"], [""], [""], {[(_This select 0),["small_box","west"],[true]] call GOL_Fnc_GearHandler;}, true], 
	["Bravo", "Big Box", blufor, "", "drop", ["ingress","_pos","egress"], [""], [""], {[(_This select 0),["big_box","west"],[true]] call GOL_Fnc_GearHandler;}, true],
	["Charlie", "Medical Box", blufor, "", "drop", ["ingress","_pos","egress"], [""], [""], {[(_This select 0),["med_box","west"],[true]] call GOL_Fnc_GearHandler;}, true],
	["Delta", "Small Box", blufor, "", "unload", ["ingress","_pos","egress"], [""], [""], {[(_This select 0),["small_box","west"],[true]] call GOL_Fnc_GearHandler;}, true], 
	["Echo", "Big Box", blufor, "", "unload", ["ingress","_pos","egress"], [""], [""], {[(_This select 0),["big_box","west"],[true]] call GOL_Fnc_GearHandler;}, true], 
	["Foxtrot", "Medical Box", blufor, "", "unload", ["ingress","_pos","egress"], [""], [""], {[(_This select 0),["med_box","west"],[true]] call GOL_Fnc_GearHandler;}, true]
];

// Channel description \\
/////////////////////////
// Param 1: String, Radio channel, select what radio channel it will be. Alpha, Bravo, Charlie, Delta, Echo, Foxtrot, Golf, Hotel, India and Juliet available.
// Param 2: String, Description for the supplies that will be seen in the map screen (Supports --> Supply Drop).
// Param 3: Side, The side of the helicopter crew. (west/blufor, east/opfor, independent).
// Param 4: String, Heli classname. "" will create a Ghost Hawk/Taru/Hellcat.
// Param 5: String, Set whether it will paradrop ("drop") or land and unload ("unload") the supply crate.
// Param 6: Array of strings, ["","",""]. "Spawn","Target","Despawn" markers. typing "_pos" instead of a marker name in "Target" will make it so you can select the target position yourself.
// Param 8: Array of strings, [""]. Ingress waypoints. Waypoints between spawn marker and Target marker/Position. Make sure to keep them atleast 1km apart for good results. leave it as [""] for no waypoints.
// Param 9: Array of strings, Same as above but between Target marker/Position and despawn marker.
// Param 10: Code or String, Content for the box that is delivered.
// 	Option 1: "Scripts\NEKY_Supply\NEKY_SupplyBox.sqf". Script Path for customized content. NEKY_SupplyBox.sqf is a template.
//  Option 2: {clearItemCargoGlobal (_this select 0)}. Code to run for the box. You can put customized content code here or call a function.
//   Note: if manually making code, define the box as (_this select 0). This, will not work.
// Param 11: Boolean, Whether the heli can take damage and be destroyed or not. True = can take damage, false = cannot take damage.
/////////////////////////
//
// ["Channel", "Diary Description", side, "heli classname", "type", ["spawn marker",("target marker" or "_pos"), "despawn marker"], ["ingress waypoints"], ["egress waypoints"], (("box content script path" or {code}) box is identified as (_This select 0)) (can take damage, true or false)]
// example: ["Alpha", "Small Box", blufor, "", "drop", ["spawn","_pos","despawn"], [""], [""], {[(_this select 0),["small_box","west"],[true]] call GOL_Fnc_GearHandler;}, true]
//
/////////////////////////