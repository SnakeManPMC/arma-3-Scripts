/*

	PMC Get Map Size

Syntax:
[] execVM "PMC\PMC_Get_Map_Size.sqf";

Example:
_mapSize = call compile preprocessFileLineNumbers "PMC\PMC_Get_Map_Size.sqf";

Requires:
-

Returns:
map size number in meters, for example 40960 for 40km terrain and 8192 for stratis, etc.

*/

private["_mapSize"];

_mapSize = getnumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");

_mapSize
