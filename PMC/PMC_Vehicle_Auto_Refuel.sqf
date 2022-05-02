/*

	Name PMC_Vehicle_Auto_Refuel

Syntax:
[vehicle] execVM "PMC\PMC_Vehicle_Auto_Refuel.sqf";

Example:
[_vcl] execVM "PMC\PMC_Vehicle_Auto_Refuel.sqf";

Requires:
-

Returns:
-

*/

private _vehicle = _this select 0;

diag_log format["PMC_Vehicle_Auto_Refuel; started for %1", _vehicle];

while {alive _vehicle || canMove _vehicle} do
{
	if (fuel _vehicle < 0.25) then
	{
		_vehicle setFuel 1;
		diag_log format["PMC_Vehicle_Auto_Refuel; just refueled %1", _vehicle];
	};

	// very gracious sleep, fuel runs out slowly so no point checking every few seconds
	sleep (5 * 60);
};

diag_log format["PMC_Vehicle_Auto_Refuel; exited for %1 (vehicle is dead or cannot move)", _vehicle];
