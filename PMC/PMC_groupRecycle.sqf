/*

	Recycle groups by deleting empty one.

Syntax:
[group] execVM "PMC\PMC_groupRecycle.sqf";

*/

private
[
	"_grp"
];

_grp = _this select 0;

PMC_grpNum = PMC_grpNum + 1;
publicVariable "PMC_grpNum";

waitUntil
{
	// give a good delay as this definitely is not time essential check
	sleep 60;
	(count units _grp == 0);
};

if (PMC_debug) then
{
	// some debug fun
	diag_log format["PMC_groupRecycle.sqf: _grp: %1, PMC_grpNum: %2", _grp, PMC_grpNum];
};

// delete our group
deleteGroup _grp;
PMC_grpNum = PMC_grpNum - 1;
publicVariable "PMC_grpNum";
