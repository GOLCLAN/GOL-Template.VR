// The purpose of this file is to spawn objects on the server rather than Headless! It also enables you to build bases which may be needed for campaigns.
// Please check the ZeusItemCollector.sqf this enables you to build bases using Zeus and then export the items to a list that you can then copy into this file.
// It's not finished yet in terms of its user friendliness but its not hard to work out & its much easier to build stuff in Zeus then it is in the editor.
if (!isServer) exitWith {};
[] call Fnc_ServiceArea;