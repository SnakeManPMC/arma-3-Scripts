/*

	(Helicopter) Infantry Transport Airborne RUSSIAN

Syntax:
[group, startPos, targetPos] execVM "PMC\PMC_Infantry_Transport_Airborne.sqf";

Requires:
PMC\PMC_groupRecycle.sqf	- for group removal.
PMC\PMC_killed.sqf		- for dead body removal.
PMC\PMC_Create_Crew.sqf		- for creating the crew

*/

private
[
	"_grp",
	"_HeloGrp",
	"_rtb",
	"_landingzone",
	"_vcl",
	"_tmp"
];

_grp = _this select 0;
_rtb = getPosASL (_this select 1);
_landingzone = getPosASL (_this select 2);

// starting location randomizer
_rtb = [((_rtb select 0) + random 200),((_rtb select 1) + random 200),200];

// we increment our count for transports active.
PMC_InfTransport = PMC_InfTransport + 1;
publicVariable "PMC_InfTransport";

_vcl = objNull;
_HeloGrp = objNull;
_HeloGrp = createGroup east;
waitUntil {!(isNull _HeloGrp)};

// create ArmA 2 Mi17 and basic RU pilot
_vcl = createVehicle ["CUP_O_Mi8_RU", _rtb, [], 0, "FLY"];
"CUP_O_RU_Pilot" createUnit [_rtb, _HeloGrp, "", 1, "SERGEANT"];

// fly higher because in chernarus its coming very close to crashing into trees and objects.
_vcl flyInHeight 75;

diag_log format ["Infantry_Transport_Airborne RU start with vehicle: %1, _grp: %2", _vcl, _HeloGrp];
(units _HeloGrp select 0) moveInDriver _vcl;
// create crew
[_vcl, _HeloGrp] execVM "PMC\PMC_Create_Crew.sqf";
{
	_x addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];
} forEach units _HeloGrp;
_vcl addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];

[_HeloGrp] execVM "PMC\PMC_groupRecycle.sqf";

// load our guys
{
	_x assignAsCargo _vcl;
	_x moveInCargo _vcl;
} forEach units _grp;

_HeloGrp setBehaviour "AWARE";
_HeloGrp setCombatMode "YELLOW";
_HeloGrp setSpeedMode "FULL";
_HeloGrp setFormation "WEDGE";

// order him to move into LZ
_vcl move _landingzone;

// some radio traffic, lifting off into the mission.
leader _HeloGrp sideChat format["This is %1, cargo group %2 onboard, we are lifting off now. Over.", leader _HeloGrp, _grp];

// small wait
sleep 5;

// plotwaypoints stuff
_tmp = [_vcl, _landingzone] execVM "PMC\PMC_plotWaypoints_Holding_Hands.sqf";
waitUntil { (scriptDone _tmp); };

// lets wait until he is ready or within 300m of the LZ, or helo cant move.
waitUntil
{
	sleep 2;
	( ( (unitReady _vcl) || (_vcl distance _landingzone) < 200) || !(canMove _vcl) );
};

diag_log format ["Infantry Transport Airborne RU %1, approach check. unitReady: %2, LZ dist: %3, canMove %4", _HeloGrp, unitReady _vcl, (_vcl distance _landingzone), canMove _vcl];

// death check, if helo or crew is dead, just exit this script.
if (!alive _vcl || !alive leader _HeloGrp) exitWith
{
	// we decrease our count for transports active.
	PMC_InfTransport = PMC_InfTransport - 1;
	publicVariable "PMC_InfTransport";
	diag_log format ["Infantry Transport Airborne RU %1 has exited with catastrophic failure. alive _vcl: %2, alive leader _HeloGrp: %3, posit: %4", _HeloGrp, alive _vcl, alive leader _HeloGrp, getPosASL _vcl];
};

// helo vehicle and the group leader is alive, put some radio traffic.
if ((alive leader _HeloGrp) && (canMove _vcl)) then
{
	leader _HeloGrp sideChat format["%1 reporting. Setting her down now, disembarking cargo. Over.", leader _HeloGrp];
};

// dumb the cargo out
{
	unassignVehicle _x;
} forEach units _grp;

// little breathing room for landing...
sleep 5;

// order him to move back into HQ
_vcl move _rtb;

// small wait
sleep 3;

// lets wait until his within 100m of HQ, or helo is dead.
waitUntil
{
	sleep 2;
	( ( (unitReady _vcl) || (_vcl distance _rtb) < 200) || !(canMove _vcl) );
};

diag_log format ["Infantry Transport Airborne RU %1, RTB check. unitReady: %2, rtb dist: %3, canMove %4, _rtb: %5", _HeloGrp, unitReady _vcl, (_vcl distance _rtb), canMove _vcl, _rtb];

// if she arrived, if shes ok, then just delete her and her crew.
if ( (alive _vcl && alive leader _HeloGrp && (_vcl distance _rtb) < 500) ) then
{
	diag_log format ["Infantry Transport Airborne RU (%1) %2 has exited with (ALL OK) alive _vcl: %3, alive leader _HeloGrp: %4. POSIT: %5, _rtb: %6, Distance: %7", PMC_InfTransport, _HeloGrp, alive _vcl, alive leader _HeloGrp, getPosASL _vcl, _rtb, (_vcl distance _rtb)];
	{
		deleteVehicle _x;
	} forEach units _HeloGrp;
	deleteVehicle _vcl;
}
else
{
	diag_log format ["Infantry Transport Airborne RU (%1) %2 has exited with (NOT OK) alive _vcl: %3, alive leader _HeloGrp: %4. POSIT: %5, _rtb: %6, Distance: %7", PMC_InfTransport, _HeloGrp, alive _vcl, alive leader _HeloGrp, getPosASL _vcl, _rtb, (_vcl distance _rtb)];
};

// we decrease our count for transports active.
PMC_InfTransport = PMC_InfTransport - 1;
publicVariable "PMC_InfTransport";

// add counter with one
PMC_InfTransportUsed = PMC_InfTransportUsed + 1;
publicVariable "PMC_InfTransportUsed";
