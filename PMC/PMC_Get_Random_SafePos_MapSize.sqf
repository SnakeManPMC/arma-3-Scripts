/*

	PMC Get Random SafePos MapSize

Syntax:
[MapSize] call compile preprocessFileLineNumbers "PMC\PMC_Get_Random_SafePos_MapSize.sqf";

Example:
_pos = [_mapSize] call compile preprocessFileLineNumbers "PMC\PMC_Get_Random_SafePos_MapSize.sqf";

Requires:
Map size in meters as parameter

Returns:
position

*/

private["_newPos", "_pos", "_mapSize"];

// get mapsize as parameter
_mapSize = _this select 0;

// choose random location
_newPos = [(random _mapSize),(random _mapSize),0];
_pos = [_newPos, 0, 100, 10, 0, 20, 0] call BIS_fnc_findSafePos;

_pos
