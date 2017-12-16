/*
	Creates crew for given vehicle.

Syntax:
[vehicle, group] execVM "PMC\PMC_create_crew.sqf";

Requires:
-

Returns:
-
*/

private
[
	"_crewType",
	"_grp",
	"_vcl"
];

_vcl = _this select 0;
_grp = _this select 1;

_crewType = getText (configFile >> "CfgVehicles" >> (typeOf _vcl) >> "Crew");

// check if have turrets, then creates gunners for them.
for "_i" from 0 to ((count (configFile >> "CfgVehicles" >> (typeOf _vcl) >> "Turrets")) - 1) do
{
	_crewType createUnit [getPosASL leader _grp, _grp, "", 1, "CORPORAL"];
	(units _grp select (_i + 1)) moveinTurret [_vcl, [_i]];
};
