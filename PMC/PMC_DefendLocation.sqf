/*

	PMC_DefendLocation

Syntax:
[location, group, patrol range] execVM "PMC\PMC_DefendLocation.sqf";

Example:
[(getPosATL pmc_1), group this, 100] execVM "PMC\PMC_DefendLocation.sqf"

Requires:
-

Returns:
-

*/

private _pos = _this select 0;
private _grp = _this select 1;
private _wpRange = _this select 2;

//player sidechat format["_pos: %1, _leader: %2, _wpRange: %3", _pos, _grp, _wpRange];

private _tMin = (60 * 0.5); // 30 sec
private _tMid = (60 * 1); // 1 minute
private _tMax = (60 * 2); // 2 minutes

// starting behavior, if you dont set setFormation, it wont use the setWaypointFormation either, it just defaults to column. NOTE: safe mode always defaults to column...
_grp setBehaviour "COMBAT";
_grp setCombatMode "RED";
_grp setSpeedMode "FULL";
// set this different than on first waypoint, otherwise first waypoint will be ignored and formation set to COLUMN
_grp setFormation "LINE";

// 1st
_grp addWaypoint [_pos, _wpRange];
[_grp, 1] setWaypointBehaviour "SAFE";
[_grp, 1] setWaypointCombatMode "RED";
[_grp, 1] setWaypointSpeed "FULL";
[_grp, 1] setWaypointFormation "WEDGE";
[_grp, 1] setWaypointType "MOVE";
[_grp, 1] setWaypointTimeout [_tMin, _tMid, _tMax];
[_grp, 1] setWaypointCompletionRadius 50;

// 2nd
_grp addWaypoint [_pos, _wpRange];
[_grp, 2] setWaypointFormation "VEE";
[_grp, 2] setWaypointTimeout [_tMin, _tMid, _tMax];
[_grp, 2] setWaypointCompletionRadius 50;

// 3rd
_grp addWaypoint [_pos, _wpRange];
[_grp, 3] setWaypointFormation "LINE";
[_grp, 3] setWaypointTimeout [_tMin, _tMid, _tMax];
[_grp, 3] setWaypointCompletionRadius 50;

// 4th
_grp addWaypoint [_pos, _wpRange];
[_grp, 3] setWaypointFormation "DIAMOND";
[_grp, 3] setWaypointTimeout [_tMin, _tMid, _tMax];
[_grp, 3] setWaypointCompletionRadius 50;

// cycle
_grp addWaypoint [_pos, 0];
[_grp, 4] setWaypointFormation "FILE";
[_grp, 4] setWaypointType "CYCLE";
[_grp, 4] setWaypointTimeout [_tMin, _tMid, _tMax];
[_grp, 4] setWaypointCompletionRadius 50;

// sends guy number 5 (zero to four) to a wild goose chase randomly, a nice oddity for enemies approaching this position
while {(count units _grp > 4)} do
{
	private _patrolGuy = (units _grp select 4);
	_patrolGuy commandMove [(_pos select 0) - random 500 + random 1000, (_pos select 1) - random 500 + random 1000, 0];
	waitUntil
	{
		sleep 10;
		//_patrolGuy sideChat format["unitReady: %1, distance to leader %2", unitready _patrolGuy, _patrolGuy distance (leader _grp)];
		unitReady _patrolGuy;
	};
};

/*
groupName addWaypoint [center, radius, index, name]
[_grp, 2] setWaypointBehaviour "AWARE";

"BLUE" (Never fire)
"GREEN" (Hold fire - defend only)
"WHITE" (Hold fire, engage at will)
"YELLOW" (Fire at will)
"RED" (Fire at will, engage at will)
[_grp, 2] setWaypointCombatMode "RED";
[_grp, 2] setWaypointCompletionRadius 30;

"COLUMN"
"STAG COLUMN"
"WEDGE"
"ECH LEFT"
"ECH RIGHT"
"VEE"
"LINE"
"FILE"
"DIAMOND"
[_grp, 2] setWaypointFormation "LINE";

Moves the waypoint to a random position in a circle with the given center and radius.
waypoint setWaypointPosition [center, radius]
[_grp, 2] setWaypointPosition [position player, 0];

"LIMITED"
"NORMAL"
"FULL"
[_grp, 2] setWaypointSpeed "FULL";

waypoint setWaypointStatements [condition, statement]
[_grp, 2] setWaypointStatements ["true", "diag_log ['GroupLeader: ', this]; diag_log ['Units: ', thislist]"];

waypoint setWaypointTimeout [min, mid, max]
[_grp, 2] setWaypointTimeout [5, 10, 6];

"MOVE"
"DESTROY"
"GETIN"
"SAD"
"JOIN"
"LEADER"
"GETOUT"
"CYCLE"
"LOAD"
"UNLOAD"
"TR UNLOAD"
"HOLD"
"SENTRY"
"GUARD" (for use with GUARDED BY trigger or createGuardedPoint)
"TALK"
"SCRIPTED"
"SUPPORT"
"GETIN NEAREST"
"DISMISS"
"LOITER" (new in Arma 3)
"AND" (only for game logics)
"OR" (only for game logics)
[_grp, 2] setWaypointType "HOLD";

[_grp, 2] setWaypointLoiterRadius 200;

waypoint setWaypointLoiterType type
[_grp, 2] setWaypointLoiterType "CIRCLE";
[_grp, 2] setWaypointLoiterType "CIRCLE_L";

Good old PMC way since arma2 times
_grp setbehaviour "COMBAT";
_grp setcombatmode "RED";
_grp setspeedmode "FULL";
_grp setformation "WEDGE";

_grp addWaypoint [_targetpoint, 500];
[_grp, 1] setWaypointBehaviour "COMBAT";
[_grp, 1] setWaypointCombatMode "RED";
[_grp, 1] setWaypointSpeed "FULL";
[_grp, 1] setWaypointFormation "WEDGE";
[_grp, 1] setWaypointType "GUARD";
[_grp, 1] setWaypointCompletionRadius 500;

And patrol infantry:
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
*/
