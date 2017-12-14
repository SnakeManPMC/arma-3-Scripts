/*
	Random US aircraft patrol over the area.
	New one will be created when old is killed/out of ammo or sorts...

	if you want to externally shut down this script, do:
	PMC_Aircraft_VTE_BLUFOR_running = false;
	publicVariable "PMC_Aircraft_VTE_BLUFOR_running";

Syntax:
[_respawnpoint] execVM "PMC\PMC_Aircraft_VTE_BLUFOR.sqf";

Requires:
PMC\PMC_Create_Crew.sqf"
PMC\PMC_groupRecycle.sqf
PMC\PMC_killed.sqf

Returns:
-
*/

private ["_PMC_Aircraft_VTE_BLUFOR","_targetpoint","_vcl","_respawnpoint"];

_PMC_Aircraft_VTE_BLUFOR =
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
		"VTE_A4",
		"VTE_A4_B",
		"VTE_A4_Napalm",
		"VTE_A4_R",
		"VTE_ac130",
		"VTE_b52",
		"VTE_birddog",
		"VTE_C130",
		"VTE_f105",
		"VTE_f105_r",
		"VTE_F4_GREY_AA",
		"VTE_F4_GREY_AG",
		"VTE_F4_TAN_AA",
		"VTE_F4_TAN_AG",
		"VTE_F5GREY",
		"VTE_F5SEA",
		"VTE_Intruder",
		"VTE_Intruder_mk82",
		"VTE_IntruderFire",
		"VTE_MC130",
		"vte_ov1c",
		"vte_ov1a",
		"vte_ov1b",
		"vte_ov1d",
		"vte_ov10",
		"vte_ov10a",
		"vte_ov10c",
		"vte_ov10d",
		"VTE_RaiderCAS",
		"VTE_RaiderSAR",
		"VTE_RaiderSEA"
	];

	_targetpoint = _this select 0;

	// change this to floor and see if it works ok?
	_myVec = (_helos select floor random (count _helos));
//	_vcl = _myVec createVehicle (getPosASL pmc_blufor_start_1);
	_vcl = createVehicle [_myVec, (getPosASL pmc_homebase), [], 0, "FLY"];
	_grp = objNull;
	_grp = createGroup west;
	waitUntil {!(isNull _grp)};

	"vte_acpilot" createUnit [(getPosASL pmc_homebase), _grp, "", 1, "SERGEANT"];
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
PMC_Aircraft_VTE_BLUFOR_running = true;
publicVariable "PMC_Aircraft_VTE_BLUFOR_running";

// initialize him?
PMC_Aircraft_VTE_BLUFOR = 0;

_respawnpoint = _this select 0;

// never ending loop to create units
while {PMC_Aircraft_VTE_BLUFOR_running} do
{
	// select target
	_targetpoint = PMC_loc select (floor random (count PMC_loc));
	// jiggle the fucker as it was array of cooridinates
	pmc_temp_logic setPos _targetpoint;
	pmc_homebase setPos _respawnpoint;

	_vcl = [_targetpoint] call _PMC_Aircraft_VTE_BLUFOR;

	// lets put up a variable showing helo amounts created
	PMC_Aircraft_VTE_BLUFOR = PMC_Aircraft_VTE_BLUFOR + 1;
	publicVariable "PMC_Aircraft_VTE_BLUFOR";

	PMC_blufor = PMC_blufor + 1;
	publicVariable "PMC_blufor";

	PMC_grp_blufor = PMC_grp_blufor + 1;
	publicVariable "PMC_grp_blufor";

diag_log format["PMC_Aircraft_VTE_BLUFOR: _vcl: %1, PMC_blufor: %2, PMC_grp_blufor: %3", typeOf _vcl, PMC_blufor, PMC_grp_blufor];

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

// debug to show this script is running
PMC_Aircraft_VTE_BLUFOR_running = false;
publicVariable "PMC_Aircraft_VTE_BLUFOR_running";
diag_log format["PMC_Aircraft_VTE_BLUFOR.sqf EXITED! _vcl: %1, PMC_blufor: %2, PMC_grp_blufor: %3", typeOf _vcl, PMC_blufor, PMC_grp_blufor];
