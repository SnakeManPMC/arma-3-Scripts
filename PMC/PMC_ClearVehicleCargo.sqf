/*

	Clears vehicle cargo space, ammo box, car, truck etc

Syntax:
[vehicle] execVM "PMC\PMC_ClearVehicleCargo.sqf";

Example:
[pmc_ammobox_hideout_1] execVM "PMC\PMC_ClearVehicleCargo.sqf";


Requires:
-

Returns:
-

*/

private _v = _this select 0;

clearBackpackCargo _v;
clearItemCargo _v;
clearMagazineCargo _v;
clearWeaponCargo _v;

diag_log format["PMC_ClearVehicleCargo, _v: %1", _v];
