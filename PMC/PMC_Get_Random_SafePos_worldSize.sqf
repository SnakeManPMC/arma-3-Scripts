/*

	PMC Get Random SafePos Terrain Size

Syntax:
[TerrainSize] call compile preprocessFileLineNumbers "PMC\PMC_Get_Random_SafePos_worldSize.sqf";

Example:
_pos = [_worldSize] call compile preprocessFileLineNumbers "PMC\PMC_Get_Random_SafePos_worldSize.sqf";

Requires:
Terrain size in meters as parameter

Returns:
position

*/

private["_newPos", "_pos", "_worldSize"];

// get worldsize as parameter
_worldSize = _this select 0;

// choose random location
_newPos = [(random _worldSize),(random _worldSize),0];
_pos = [_newPos, 0, 100, 10, 0, 20, 0] call BIS_fnc_findSafePos;

_pos
