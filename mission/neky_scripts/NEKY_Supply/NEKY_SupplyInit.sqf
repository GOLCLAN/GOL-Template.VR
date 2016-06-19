//	[] execVM "Scripts\NEKY_Supply\NEKY_SupplyInit.sqf"; 
//	
//	1. Add:	 [] execVM "Scripts\NEKY_Supply\NEKY_SupplyInit.sqf";	 to your init.sqf
//	2. Open NEKY_SupplySettings.sqf and edit _Callers to those you want to be able to run the script.
//	3. While in NEKY_SupplySettings.sqf also edit the _Channels, see description for channels in there.
//	4. Remember to add names from _Callers to your units in-game that are supposed to have the actions.
//	5. Done.
//		
//	Made by NeKo-ArroW
//	
//	This is the init file for radio controlled supply drops. It uses SupplySettings for parameters.

Private ["_Array","_Index","_Callers","_Trg","_x","_i","_y","_Temp","_pos","_Click","_Channel","_Text"];

#include "NEKY_SupplySettings.sqf"

// Make array lower case \\
_Index = 0;
_Array = [];
for "_i" from 1 to (count _Callers) do
{
	_Array pushBack (toLower ([_Callers, _Index, "", [""]] call BIS_fnc_Param));
	_Index = _Index +1;
};
sleep 0.5;

// See if player is a supply caller \\
if !(toLower (format ["%1",Player]) in _Array) exitWith {FALSE};

// Creating Diary Record \\
Player createDiarySubject ["Supports","Supports"];
_Text = "Supply Drop Call Signs<br></br><br></br>";
_Index = 0;
for "_i" from 1 to (count _Channels) do
{
	_Temp = (toLower ((_Channels select _Index) select 4));
	if (_Temp == "drop") then {_Temp = "Paradrop"} else {_Temp = "Land and unload"};
	_Text = Format ["%1Radio: %2 -- %3 -- %4<br></br>",_Text,((_Channels select _Index) select 0), ((_Channels select _Index) select 1), _Temp];
	_Index = _Index +1;
};
Player CreateDiaryRecord ["Supports",["Supply Drop", _Text]];
{	_x deleteAt 1	} forEach _Channels;
sleep 1;

//	Turn STD markers in to XYZ \\
_Index = 0;
for "_i" from 1 to (count _Channels) do
{
	_Index2 = 0;
	_Channel = (_Channels select _Index);
	for "_y" from 1 to 3 do 
	{
		if (typeName ((_Channel select 4) select _Index2) == "STRING") then 
		{
			(_Channel select 4) set [_Index2, (toLower ((_Channel select 4) select _Index2))];
			if !(((_Channel select 4) select _Index2) == "_pos") then
			{
				_Temp = (getMarkerPos ((_Channel select 4) select _Index2));
				(_Channel select 4) set [_Index2, _Temp];		
			};
		};
		_Index2 = _Index2 +1;
	};
	_Index = _Index +1;
};
sleep 1;

//	Trigger Creator \\
_Index = 0;
For "_i" from 1 to (count _Channels) do 
{
	_Channel = (_Channels select _Index);
	_Click = False;
	_Trg = CreateTrigger ["EmptyDetector", [0,0,0], false];
	_Trg setTriggerActivation [(_Channel select 0), "PRESENT", True];
	_Channel deleteAt 0;
	if (typeName ((_Channel select 3) select 1) == "STRING") then
	{
		_Temp = (_Channel select 3) set [1, (toLower ((_Channel select 3) select 1))];
		if (((_Channel select 3) select 1) == "_pos") then {_Click = True};
	};
	
	if (_Click) then
	{
		if (typeName (_Channel select 6) == "String") then
		{
			_Temp = Format ["openMap true; 'Supports' call BIS_fnc_selectDiarySubject; [Player, systemChat 'Pilot: Awaiting Coordinates'] onMapSingleClick {[%1,'%2','%3',[%4,_pos,%5],%6,%7,'%8',%9] execVM 'Scripts\NEKY_Supply\NEKY_SupplyMapClick.sqf'};",(_Channel select 0), (_Channel select 1), (_Channel Select 2), (_Channel select 3 select 0), (_Channel select 3 select 2), (_Channel select 4), (_Channel select 5), (_Channel select 6), (_Channel select 7)];
		} else {
			_Temp = Format ["openMap true; 'Supports' call BIS_fnc_selectDiarySubject; [Player, systemChat 'Pilot: Awaiting Coordinates'] onMapSingleClick {[%1,'%2','%3',[%4,_pos,%5],%6,%7,%8,%9] execVM 'Scripts\NEKY_Supply\NEKY_SupplyMapClick.sqf'};",(_Channel select 0), (_Channel select 1), (_Channel Select 2), (_Channel select 3 select 0), (_Channel select 3 select 2), (_Channel select 4), (_Channel select 5), (_Channel select 6), (_Channel select 7)];
		};
	} else {
		if (typeName (_Channel select 6) == "String") then
		{
			_Temp = Format ["SystemChat 'Pilot: Supplies incoming'; [%1,'%2','%3',%4,%5,%6,'%7',%8] execVM 'Scripts\NEKY_Supply\NEKY_Supply.sqf';",(_Channel select 0), (_Channel select 1), (_Channel Select 2), (_Channel select 3), (_Channel select 4), (_Channel select 5), (_Channel select 6), (_Channel select 7)];
		} else {
			_Temp = Format ["SystemChat 'Pilot: Supplies incoming'; [%1,'%2','%3',%4,%5,%6,%7,%8] execVM 'Scripts\NEKY_Supply\NEKY_Supply.sqf';",(_Channel select 0), (_Channel select 1), (_Channel Select 2), (_Channel select 3), (_Channel select 4), (_Channel select 5), (_Channel select 6), (_Channel select 7)];
		};
	};
	_Trg setTriggerStatements ["this", _Temp, ""];
	_Index = _Index +1;
};