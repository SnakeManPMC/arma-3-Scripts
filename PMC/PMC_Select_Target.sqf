/*
	Select target from PMC_targets array

Syntax:
call compile preProcessFileLineNumbers "PMC\PMC_Select_Target.sqf";
_location = call PMC_Select_Target;

Requires:
[position array]

Returns:
location as game logic name

*/

PMC_Select_Target =
{
	private
	[
		"_c",
		"_ran",
		"_tlogic"
	];
	_c = (count PMC_targets) - 1;
	_ran = random _c;
	_tlogic = (PMC_targets select _ran);
	
	if (PMC_debug) then
	{
		diag_log format["PMC_Select_Target: _ran: %1, _tlogic: %2", _ran, _tlogic];
	};
	
	_tlogic
};
