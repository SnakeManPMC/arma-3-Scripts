/*
	Create guard waypoints

Syntax:
[group, targetpoint, waypoint_radius] execVM "PMC\PMC_Guard_Inf_Waypoints.sqf";

Requires:
PMC\PMC_killed.sqf

Returns:
-

*/

PMC_Guard_Inf_Waypoints =
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

	_grp setbehaviour "AWARE";
	_grp setcombatmode "RED";
	_grp setspeedmode "FULL";
	_grp setformation "WEDGE";

	_grp addWaypoint [_targetpoint, _waypointRanPosit];
	[_grp, 1] setWaypointBehaviour "AWARE";
	[_grp, 1] setWaypointCombatMode "RED";
	[_grp, 1] setWaypointSpeed "FULL";
	[_grp, 1] setWaypointFormation "WEDGE";
	[_grp, 1] setWaypointType "GUARD";
	[_grp, 1] setWaypointCompletionRadius 50;
};
