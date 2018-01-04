/*

	PMC VTE Gook Convoy script, modified from PMC Real War into VTE gook use.

Syntax:
[] execVM "PMC\PMC_VTE_gook_convoy.sqf";

Requires:
PMC_targets[] array
PMC\PMC_killed.sqf

Returns:
-

*/

private ["_grp","_PMC_CreateVTEConvoyVehicles","_respawnpoint","_PMC_SelectStartPosit"];

_PMC_CreateVTEConvoyVehicles =
{
        private ["_grp","_ran","_tlogic","_PMC_convoyVTEOPFORtargets","_targetpoint","_ptNum","_wp","_vcl","_respawnpoint","_crewClass"];
        
        _respawnpoint = _this select 0;
        
        _vcl = objNull;
	_grp = objNull;
	_grp = createGroup east;
	waitUntil {!(isNull _grp)};

	// first vehicle t55
	_vcl = "vte_t55" createVehicle _respawnpoint;
	_vcl addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];
        
        _crewClass = getText (configFile >> "CfgVehicles" >> (typeOf _vcl) >> "Crew");
	
	_crewClass createUnit [_respawnpoint, _grp, "", (random 1), "LIEUTENANT"];
	_crewClass createUnit [_respawnpoint, _grp, "", (random 1), "SERGEANT"];
	_crewClass createUnit [_respawnpoint, _grp, "", (random 1), "SERGEANT"];
	(units _grp select 0) moveInCommander _vcl;
	(units _grp select 1) moveInGunner _vcl;
	(units _grp select 2) moveInDriver _vcl;

	// second vehicle pt76
	_vcl = "vte_pt76" createVehicle [(_respawnpoint select 0),(_respawnpoint select 1)-40];
	_vcl addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];

        _crewClass = getText (configFile >> "CfgVehicles" >> (typeOf _vcl) >> "Crew");
        
	_crewClass createUnit [_respawnpoint, _grp, "", (random 1), "SERGEANT"];
	_crewClass createUnit [_respawnpoint, _grp, "", (random 1), "CORPORAL"];
	_crewClass createUnit [_respawnpoint, _grp, "", (random 1), "CORPORAL"];
	(units _grp select 3) moveInCommander _vcl;
	(units _grp select 4) moveInGunner _vcl;
	(units _grp select 5) moveInDriver _vcl;

	// third vehicle uaz mg
	_vcl = "VTE_nvauazmg" createVehicle [(_respawnpoint select 0),(_respawnpoint select 1)-80];
	_vcl addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];

        _crewClass = getText (configFile >> "CfgVehicles" >> (typeOf _vcl) >> "Crew");

        _crewClass createUnit [_respawnpoint, _grp, "", (random 1), "CORPORAL"];
	_crewClass createUnit [_respawnpoint, _grp, "", (random 1), "CORPORAL"];
	(units _grp select 6) moveInDriver _vcl;
	(units _grp select 7) moveInGunner _vcl;

	// fourth vehicle ural
	_vcl = "VTE_nvatruck" createVehicle [(_respawnpoint select 0),(_respawnpoint select 1)-120];
	_vcl addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];

	"vte_nvasoldier" createUnit [_respawnpoint, _grp, "", (random 1), "PRIVATE"];
	(units _grp select 8) moveInDriver _vcl;

	// these to function somehow nicely, please :(
	{
		_x addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];
	} forEach units _grp;

	// do these need to be set, before waypoint 0 hmm?
	_grp setFormation "COLUMN";
	_grp setCombatMode "YELLOW";
	_grp setSpeedMode "NORMAL";
	_grp setBehaviour "SAFE";

	// selecting the waypoint locations
	_ptNum = count PMC_targets;
	_PMC_convoyVTEOPFORtargets = [];
	_PMC_convoyVTEOPFORtargets = PMC_targets;

	// do the random patrolling waypoints
	_wp = 0;
	while {count _PMC_convoyVTEOPFORtargets > 0} do
	{
		// choose random target.
		_ran = (floor random _ptNum);
		_tlogic = (_PMC_convoyVTEOPFORtargets select _ran);
		// remove it from the temp array so it wont be chosen again.
		_PMC_convoyVTEOPFORtargets = _PMC_convoyVTEOPFORtargets - [_tlogic];
		// get its coordinates.
		_targetpoint = getPosASL _tlogic;
		_ptNum = _ptNum - 1;
		_wp = _wp + 1;

		// add waypoint to this target.
		_grp addWaypoint [_targetpoint, 0];
		[_grp, _wp] setWaypointBehaviour "SAFE";
		[_grp, _wp] setWaypointCombatMode "GREEN";
		[_grp, _wp] setWaypointSpeed "NORMAL";
		[_grp, _wp] setWaypointFormation "COLUMN";
		[_grp, _wp] setWaypointType "MOVE";
//		[_grp, _wp] setWaypointTimeout [min, mid, max];
		[_grp, _wp] setWaypointTimeout [60*2, 0, 60*20];
	};

	// add one last for cycle, so if he survives, he does it all over again.
	_wp = _wp + 1;
	_grp addWaypoint [_respawnpoint, 0];
	[_grp, _wp] setWaypointBehaviour "SAFE";
	[_grp, _wp] setWaypointCombatMode "GREEN";
	[_grp, _wp] setWaypointSpeed "NORMAL";
	[_grp, _wp] setWaypointFormation "COLUMN";
	[_grp, _wp] setWaypointType "CYCLE";

	// return the group name
	_grp
};

// selects random starting location
_PMC_SelectStartPosit =
{
	// select one starting point
	private ["_ran","_tlogic","_respawnpoint"];
	_ran = (floor random (count PMC_OPFOR_starts));
	_tlogic = (PMC_OPFOR_starts select _ran);
	_respawnpoint = getPosASL _tlogic;

	// location, returned from this function
	_respawnpoint
};

/*

	main code

*/

while {true} do
{
	// choose one of the random starting locations
	_respawnpoint = [] call _PMC_SelectStartPosit;

	_grp = [_respawnpoint] call _PMC_CreateVTEConvoyVehicles;

	sleep 10;
	// we wait until the convoy group is completely dead.
	waitUntil
	{
		sleep 60;
		((count units _grp) == 0);
	};
	// then we delete its group.
	waitUntil
	{
		deleteGroup _grp;
		(isNull _grp);
	};
	// and then we start the whole damn loop all over again :)
};
