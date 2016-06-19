//	Manually gathered AttachTo XYZ cordinates for demo charges.
//	
//	_VehiclePos = [[[AttachTo X, AttachTo Y, AttachTo Z], bearing, [SetVectorUp X, SetVectorUp Y, SetVectorUp Z]]];
/////////////////////////////////////////////////////
//	
//	1. [AttachTo X, AttachTo Y, AttachTo Z].
//		a. Use the AttachTo command to bring the charge to your preferred position ( https://community.bistudio.com/wiki/attachTo ).
//		b. You can use BoundingBox to make it a bit easier to find the borders of the vehicle. ( https://community.bistudio.com/wiki/boundingBox ).
//	2. Bearing/distance.
//		a. The bearing the bearing will turn towards. 0-360.
//		b. If the bearing is irrelevant you can use (Random 360) and it will be randomly selected.
//	3.[SetVectorUp X, SetVectorUp Y, SetVectorUp Z].
//		a. Use this to tilt the charge to your liking. ( https://community.bistudio.com/wiki/setVectorUp ).
//
////////////
//	How To
////////////
//	
//	1. Place a demo charge in your editor and name it BOMB.
//	2. Place the vehicle you want to add to this list in your editor and name it CAR.
//	3. Hit Preview.
//	4. Bring up the debug console and underneath it you will see the 4 Watch tabs, enter: BoundingBox BOMB
//	5. Now, in the debug console type: BOMB attachTo [CAR,[(fill in 3 elements here)]]; BOMB SetDir (enter bearing here); BOMB SetVectorUp [(fill in 3 elements here)];
//		a. BoundingBox BOMB will give you two arrays that gives you the corner positions of the vehicle.
//	 	b. SetVectorUp [0,0,-1] Will turn an object up-side-down.
//	6. Once you've managed to put your BOMB where you want it, create a value down below, for example: _MyCustomVehicle1 = [];
//	7. Now copy the AttachTo position array in to your value, for example: _MyCustomVehicle1 = [[0.5,1.22,-1]];
//	8. Now place a comma in there and enter the bearing you want it to face, for example: _MyCustomVehicle1 = [[0.5,1.22,-1],45];
//	9. Now place another comma and copy your SetVectorUp array, for example: _MyCustomVehicle1 = [[0.5,1.22,-1],45,[0,0,-1]];
//	10. Repeat step 5-9 until you have as many position you feel is neccessary, remember to place a comma between each section. When done, move to step 11.
//	11. In one of the Watch taps, enter: TypeOf CAR
//	12. Copy the string returned by the code and enter NEKY_CarBomb.sqf. 
//	13. Navigate to about line 39, you should see a Switch (_TypeVehicle) case... code.
//	14. Enter a new case with your string, for example: case "My_TypeOf_CAR_String": {_Pos = (_MyCustomVehicle1 call BIS_FNC_SelectRandom)};
//	15. Done!
//	
////////////////////////
//	Made by NeKo-ArroW
////////////////////////

_OffroadPos = [[[-0.51,-2,-1],90,[0,0,-1]],[[0.4,-2,-1],90,[0,0,-1]],[[0,-1.5,-1],180,[0,0,-1]],[[0,0.5,-1.05],(random 360),[0,0,-1]],[[0.2,1.4,-1],90,[10,0,-1]],[[-0.3,1.4,-1],90,[-5,0,-1]]];
_OffroadArmedPos = [[[-0.51,-2,-1.55],90,[0,0,-1]],[[0.4,-2,-1.55],90,[0,0,-1]],[[0,-1.5,-1.55],180,[0,0,-1]],[[0,0.5,-1.6],(random 360),[0,0,-1]],[[0.2,1.4,-1.5],90,[10,0,-1]],[[-0.3,1.4,-1.5],90,[-5,0,-1]]];
_HatchbackPos = [[[-0.2,-2,-1.07],(random 360),[0,0,-1]],[[0.2,-1,-1.1],(random 360),[0,0,-1]],[[-0.6,-0.5,-1.08],(random 360),[0,0,-1]],[[-0.55,1.1,-1.08],180,[0,5,-1]],[[0.15,1.8,-0.975],180,[0,0,-1]]];
_HatchbackSportPos = [[[0,1.4,-1.1],(random 360),[0,0,-1]],[[0.58,1.85,-0.955],40,[0,0,0]],[[0.2,0.5,-1.1],(random 360),[0,0,-1]],[[-0.4,-0.5,-1.08],(random 360),[0,0,-1]],[[0.37,-1.8,-1.08],0,[15,0,-1]]];
_SUVPos = [[[0.75,-1.8,-1.18],90,[-10,0,-1]],[[0.1,-1.8,-1.09],(random 360),[0,0,-1]],[[0.3,0,-1.01],(random 360),[0,0,-1]],[[-0.6,0,-1.025],(random 360),[0,0,-1]],[[0,2.2,-1.1],180,[0,0,-1]]];
_TruckPos = [[[0,1.35,-1.25],180,[0,10,-1]],[[0,1.35,-0.98],(random 360),[0,0,-1]],[[-0.65,-0.55,-0.65],(random 360),[0,0,-1]],[[-0.65,-2.55,-0.65],(random 360),[0,0,-1]],[[0.65,-3.05,-0.87],0,[0,20,-1]]];
_TruckFIAPos = [[[0,1.35,-1.25],0,[0,10,-1]],[[0,1.35,-0.98],(random 360),[0,0,-1]],[[-0.65,-0.55,-0.63],(random 360),[0,0,-1]],[[-0.65,-2.55,-0.63],(random 360),[0,0,-1]],[[0.65,-3.03,-0.89],0,[0,20,-1]]];