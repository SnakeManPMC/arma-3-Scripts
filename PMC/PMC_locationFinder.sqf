/*

	PMC_locationFinder.sqf

	Scans cfgWorlds -> Names and outputs all CityCenter locations into array

Syntax:
PMC_CityCenters = call compile preprocessFileLineNumbers "PMC\PMC_locationFinder.sqf";

Example:
_loc = call compile preprocessFileLineNumbers "PMC\PMC_locationFinder.sqf";
player setPos (_loc select (random count _loc));

Requires:
-

Returns:
array of CityCenter locations

*/
private ["_locations","_logics","_current","_position"];

_locations = configfile >> "cfgworlds" >> worldname >> "names";
_logics = [];

for "_i" from 0 to (count _locations - 1) do
{
	_current = _locations select _i;
	_position = getarray(_current >> "position");
//	_type = gettext(_current >> "type");
//	_typeLogic = gettext (configFile >> "cfgLocationTypes" >> _type >> "logicClass");

//	if (_typeLogic == "LocationLogicCityCenter") then
//	{
		_logics = _logics + [_position];
//	};

/*
	diag_log format
	[
		"_current: %1, _position: %2, _type: %3, _typeLogic: %4",
		_current,
		_position,
		_type,
		_typeLogic
	];
*/
};

/*
diag_log "all done, now _logics ...";
diag_log _logics;
*/

// return the array of CityCenters
_logics
