/*

	PMC Get Terrain Size

Syntax:
[] execVM "PMC\PMC_Get_worldSize.sqf";

Example:
_worldSize = call compile preprocessFileLineNumbers "PMC\PMC_Get_worldSize.sqf";

Requires:
-

Returns:
terrain size number in meters, for example 40960 for 40km terrain and 8192 for stratis, etc.

*/

private["_worldSize"];

_worldSize = getnumber (configfile >> "CfgWorlds" >> worldName >> "worldSize");

_worldSize
