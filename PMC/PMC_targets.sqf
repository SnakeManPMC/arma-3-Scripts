/*
	gamelogics: pmc_1 -> how many you got
*/

private ["_a","_p"];

// choose new digit for the gamelogic "pmc_*"
_a = 1;
_p = missionNamespace getVariable [format ["pmc_%1",_a], objNull];
PMC_targets = [];

// loop until we have no gamelogics left, it then should return 0.
while {!isNull _p && ((getPosASL _p) select 0) != 0} do
{
	// just make array out of the gamelogics
	PMC_targets = PMC_targets + [_p];
	
	// add one digit to our gamelogic name.
	_a = _a + 1;
	_p = missionNamespace getVariable [format ["pmc_%1",_a], objNull];
};


/*
	gamelogics: pmc_opfor_start_1 -> how many you got
*/

// choose new digit for the gamelogic "PMC_opfor_start_*"
_a = 1;
_p = missionNamespace getVariable [format["PMC_opfor_start_%1",_a], objNull];
PMC_opfor_starts = [];

// loop until we have no gamelogics left, it then should return 0.
while {!isNull _p && ((getPosASL _p) select 0) != 0} do
{
	// just make array out of the gamelogics
	PMC_opfor_starts = PMC_opfor_starts + [_p];
	
	// add one digit to our gamelogic name.
	_a = _a + 1;
	_p = missionNamespace getVariable [format ["PMC_opfor_start_%1",_a], objNull];
};


/*
	gamelogics: pmc_blufor_start_1 -> how many you got
*/

// choose new digit for the gamelogic "PMC_blufor_start_*"
_a = 1;
_p = missionNamespace getVariable [format["PMC_blufor_start_%1",_a], objNull];
PMC_blufor_starts = [];

// loop until we have no gamelogics left, it then should return 0.
while {!isNull _p && ((getPosASL _p) select 0) != 0} do
{
	// just make array out of the gamelogics
	PMC_blufor_starts = PMC_blufor_starts + [_p];
	
	// add one digit to our gamelogic name.
	_a = _a + 1;
	_p = missionNamespace getVariable [format ["PMC_blufor_start_%1", _a], objNull];
};
