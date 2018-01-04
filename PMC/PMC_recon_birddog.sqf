/*

	Recon Birddog

Syntax:
[startposition] execVM "PMC\PMC_recon_birddog.sqf";

Requires:
PMC\PMC_killed.sqf
PMC_targets[]

Returns:
-

*/

private["_respawnpoint", "_PMC_MakeBirddog","_targetNum", "_ran", "_tlogic", "_targetpoint", "_vcl"];

_respawnpoint = _this select 0;

_PMC_MakeBirddog =
{
private["_respawnpoint", "_myVec", "_vcl", "_grp", "_wp"];
	_respawnpoint = _this select 0;
	_myVec = "VTE_birddog";
	_vcl = _myVec createVehicle _respawnpoint;
	_grp = createGroup west;
	waitUntil {!(isNull _grp)};

	"VTE_acpilot" createUnit [_respawnpoint, _grp, "", 1, "SERGEANT"];
	(units _grp select 0) moveInDriver _vcl;

	{
		_x addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];
	} foreach units _grp;
	_vcl addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];

	_grp setbehaviour "SAFE";
	_grp setcombatmode "RED";
	_grp setspeedmode "LIMITED";
	_grp setformation "WEDGE";

	// fly in height thing between 100m to 300m.
	_vcl flyInHeight (100 + random 200);

	_wp = 1;

	_grp addWaypoint [_targetpoint, 500];
	[_grp, _wp] setWaypointBehaviour "SAFE";
	[_grp, _wp] setWaypointCombatMode "RED";
	[_grp, _wp] setWaypointSpeed "LIMITED";
	[_grp, _wp] setWaypointFormation "WEDGE";
	[_grp, _wp] setWaypointType "GUARD";
	
	// return the vehicle
	_vcl
};

_targetNum = count PMC_targets;
// manually selected from our airbase taxiway. perhaps use gamelogic here?

// never ending loop to create units
while {true} do
{
	_ran = (floor random _targetNum);
	_tlogic = (PMC_targets select _ran);
	_targetpoint = getPosASL _tlogic;

	_vcl = [_respawnpoint] call _PMC_MakeBirddog;

	// lets put up a variable showing helo amounts created
	PMC_birddog_cv = PMC_birddog_cv + 1;
	publicVariable "PMC_birddog_cv";
	// do not attempt to create helos more than once a minute
	sleep 60;

	// wait until the plane cannot either; Move or its simply dead.
	waitUntil
	{
		// very relaxed script, lets give it 1min room to breathe
		sleep 60;
		(!alive _vcl || !canMove _vcl);
	};
};
