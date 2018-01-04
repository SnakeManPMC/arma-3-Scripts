/*
	Vietnam: The Experience !

	Random US helicopter patrol over the area.
	New one will be created when old is killed/out of ammo or sorts...

	if you want to extrenally shut down this script, do:
	PMC_helo_VTE_blufor_running = false;
	publicVariable "PMC_helo_VTE_blufor_running";

Syntax:
[_respawnpoint] execVM "PMC\PMC_Helo_VTE_BLUFOR.sqf";

Requires:
PMC_loc array of location coordinates
PMC\PMC_Create_Crew.sqf"
PMC\PMC_groupRecycle.sqf
PMC\PMC_killed.sqf

Returns:
-
*/

private ["_PMC_MakeHelo_VTE_BLUFOR","_targetpoint","_vcl","_respawnpoint"];

_PMC_MakeHelo_VTE_BLUFOR =
{
	private
	[
		"_grp",
		"_helos",
		"_myVec",
		"_targetpoint",
		"_tmp",
		"_vcl"
	];

	_helos =
	[
		"VTE_ach47a",
		"VTE_ah1g",
		"VTE_ah1j",
		"VTE_ch34_mg",
		"VTE_ch46e_mg",
		"VTE_ch47ca",
		"VTE_ch53_mg",
		"VTE_oh6a",
		"VTE_oh6arg",
		"VTE_s56_mg",
		"VTE_uh1",
		"VTE_uh1a",
		"VTE_uh1gs",
		"VTE_uh1guns"
	];

	_targetpoint = _this select 0;

	// change this to floor and see if it works ok?
	_myVec = (_helos select floor random (count _helos));
	_vcl = createVehicle [_myVec, (getPosASL pmc_homebase), [], 0, "FLY"];
	_grp = objNull;
	_grp = createGroup west;
	waitUntil {!(isNull _grp)};

	"VTE_acpilot" createUnit [(getPosASL pmc_homebase), _grp, "", 1, "SERGEANT"];
	(units _grp select 0) moveInDriver _vcl;

	// create helo crew
	_tmp = [_vcl, _grp] execVM "PMC\PMC_Create_Crew.sqf";

	// wait until crew has been created, then proceed to add killed EH.
	waitUntil
	{
		scriptDone _tmp;
	};

	// recycle the group
	[_grp] execVM "PMC\PMC_groupRecycle.sqf";

	// these to function somehow nicely, please :(
	{
		_x addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];
	} foreach units _grp;
	_vcl addEventHandler ["killed", {handle = _this execVM "PMC\PMC_killed.sqf"}];

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

	// return the vehicle name
	_vcl
};

// set this to false to stop the script
PMC_helo_VTE_blufor_running = true;
publicVariable "PMC_helo_VTE_blufor_running";

// counter for how many helos created
PMC_helo_blufor = 0;

_respawnpoint = _this select 0;

// never ending loop to create units
while {PMC_helo_VTE_blufor_running} do
{
	// select target
	_targetpoint = PMC_loc select (random (count PMC_loc));
	// jiggle the fucker as it was array of cooridinates
	pmc_temp_logic setPos _targetpoint;
	pmc_homebase setPos _respawnpoint;

	_vcl = [_targetpoint] call _PMC_MakeHelo_VTE_BLUFOR;

	// lets put up a variable showing helo amounts created
	PMC_helo_blufor = PMC_helo_blufor + 1;
	publicVariable "PMC_helo_blufor";

	PMC_blufor = PMC_blufor + 1;
	publicVariable "PMC_blufor";

	PMC_grp_blufor = PMC_grp_blufor + 1;
	publicVariable "PMC_grp_blufor";

diag_log format["PMC_Helo_VTE_BLUFOR: _vcl: %1, PMC_blufor: %2, PMC_grp_blufor: %3", typeOf _vcl, PMC_blufor, PMC_grp_blufor];

	// do not attempt to create helos more than once a minute
	sleep 60;

	// wait until the helo cannot either; Move or Fire, or its simply dead.
	waitUntil
	{
		// very relaxed script, lets give it 1min room to breathe
		sleep 60;
		// hes dead
		// he cant move
		// he cant fire (but what if he has no weapons like MH6?)
		(!alive _vcl || !canMove _vcl || !canFire _vcl);
	};
};

diag_log format["PMC_Helo_VTE_BLUFOR.sqf EXITED! _vcl: %1, PMC_blufor: %2, PMC_grp_blufor: %3", typeOf _vcl, PMC_blufor, PMC_grp_blufor];
