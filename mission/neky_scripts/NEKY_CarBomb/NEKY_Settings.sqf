//	Settings for NEKY_CarBomb.sqf
//	
//	Made by NeKo-ArroW
//	Version 1.0

// General Settings
_ChanceOfPlanting = 1;											// The chance a bomb will be placed on the vehicle. 0 = 0%, 1 = 100%.																				Number
_BumpSensitivity = 0.6;											// How likely it is that the bomb will go off when bumping in to the vehicle. 0 = 0% (off), 1 = 100%.												Number
_RigPositions = [false,false,true];								// Set off explosive if entering [Driver seat, Gunner seat, turning the ignition]. [True/False,True/False,True/False].								Array of Booleans
_ChanceOfRigged = 1;											// The chance that Driver and Gunner seat is rigged to set off the explosive when entered. 0 = 0%, 1 = 100%.										Number
_Remote = [True];												// If there will be AI that remotely set off the charge if a player is close to the rigged vehicle.	[True/False]									Array with Boolean
_RemoteRange = 50;												// The range (Meters) the AI needs to be within to be able to set off the explosive. 																Number
_RemoteControllers = 1;											// How many AI units are able to set off the bomb remotely.																							Number
_ControllerSide = OPFOR;										// Side of the AI units that can set off the bomb remotely.	BLUFOR/WEST, OPFOR/EAST, INDEPENDENT													Side
_ProximityM = 5;												// How close(Meters) a footmobile needs to be for a remote detonation to be set off.																Number
_ProximityV = 10;												// How close(Meters) a vehicle needs to be for a remote detonation to be set off.																	Number

_FrequencyF = 5;												// How often the script should scan for players when further than 300m away from the vehicle.														Number
_FrequencyC = 0.5;												// How often the script should scan for players when closer than 300m to the vehicle.																Number

// Explosion
_Small = "APERSMine";											// The class name of a small explosion. Can be Projectile or Mine.																					String
_Medium = "R_TBG32V_F";											// The class name of a medium explosion. Can be a Projectile or Mine.																				String
_Large = "ATMine";												// The class name of a large explosion. Can be a Projectile or Mine.																				String

_BombHealth = 0.7;												// How much health the bomb should have. Limits: 0.1 - 0.8, higher number = more health, lower number = less health.								Number
_RandomBomb = ["small","medium","medium","medium","medium","large"]; // Randomly selected explosive size.																											Array of Strings
_Visual = ["DemoCharge_Remote_Ammo"];							// How the charge looks like. Can be several different objects, will be randomly selected.															Array of Strings