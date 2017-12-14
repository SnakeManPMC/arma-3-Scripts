/*

	Killed body / corpses array which get filled from PMC_killed.sqf
	Run this on server

Syntax:
[number_of_corpses] execVM "PMC\PMC_corpses.sqf";

Requires:
PMC\PMC_killed.sqf

Returns:
-

*/

private
[
	"_first",
	"_MaxCorpses"
];

_MaxCorpses = _this select 0;

while {true} do
{
	// wait until our corpses list gets higher than specified number
	waitUntil
	{
		// give it time to relax, no need to be CPU intese.
		sleep 2;
		(count PMC_corpses > _MaxCorpses);
	};

	// then delete the oldest corpse and start again.
	_first = PMC_corpses select 0;
	if (PMC_debug) then
	{
		player sideChat format["Deleted corpse: %1. MaxCorpses: %2. Actual Count: %3",_first,_MaxCorpses,(count PMC_corpses)];
	};
	deleteVehicle _first;
	PMC_corpses set [0,"DELETEME"];
	PMC_corpses = PMC_corpses - ["DELETEME"];
};
