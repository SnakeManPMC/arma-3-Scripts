/*
	Patrol infantry waypoints

Syntax:
[group, targetpoint, waypointradius] execVM "PMC\PMC_Patrol_Inf_Waypoints.sqf";

Requires:
PMC\PMC_killed.sqf

Returns:
-

*/

PMC_Patrol_Inf_Waypoints =
{
	private
	[
		"_grp",
		"_targetpoint",
		"_waypointRanPosit"
	];
	_grp = _this select 0;
	_targetpoint = _this select 1;
	_waypointRanPosit = _this select 2;

	{
		_x addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];
	} foreach units _grp;

	_grp setbehaviour "SAFE";
	_grp setcombatmode "RED";
	_grp setspeedmode "LIMITED";
	_grp setformation "WEDGE";

	// waypoints, we add couple to make patrol area
	// first
	_grp addWaypoint [_targetpoint, _waypointRanPosit*2];
	[_grp, 1] setWaypointBehaviour "SAFE";
	[_grp, 1] setWaypointCombatMode "RED";
	[_grp, 1] setWaypointSpeed "LIMITED";
	[_grp, 1] setWaypointFormation "WEDGE";
	[_grp, 1] setWaypointType "MOVE";
	[_grp, 1] setWaypointTimeout [60*2, 60*10, 60*20]; // min, mid, max
	[_grp, 1] setWaypointCompletionRadius 50;

	// second
	_grp addWaypoint [_targetpoint, _waypointRanPosit*2];
	[_grp, 2] setWaypointType "MOVE";
	[_grp, 2] setWaypointTimeout [60*2, 60*10, 60*20];
	[_grp, 2] setWaypointCompletionRadius 50;

	// cycle
	_grp addWaypoint [_targetpoint, 0];
	[_grp, 3] setWaypointType "CYCLE";
	[_grp, 3] setWaypointTimeout [60*2, 60*10, 60*20];
	[_grp, 3] setWaypointCompletionRadius 50;
};
