/*

	PMC_SelectStartPosit
	for blufor and opfor

Syntax:
_location = [blufor] call "PMC\PMC_SelectStartPosit.sqf";
or
_location = [opfor] call "PMC\PMC_SelectStartPosit.sqf";

Returns:
[position array]

Required:
PMC_BLUFOR_starts
and
PMC_OPFOR_starts
arrays filled with at least 1 entry.

*/

PMC_SelectStartPosit =
{
	private
	[
		"_OurSide",
		"_ran",
		"_respawnpoint",
		"_tlogic"
	];

	_OurSide = _this select 0;

	// select one starting point
	if (_OurSide == "BLUFOR") then
	{
		_ran = (floor random (count PMC_BLUFOR_starts));
		_tlogic = (PMC_BLUFOR_starts select _ran);
	};

	if (_OurSide == "OPFOR") then
	{
		_ran = (floor random (count PMC_OPFOR_starts));
		_tlogic = (PMC_OPFOR_starts select _ran);
	};

	_respawnpoint = [(getPosASL _tlogic select 0) - 50 + random 100, (getPosASL _tlogic select 1) - 50 + random 100, 0];

//hintc format["At PMC_SelectStartPosit.sqf\n\n_OurSide: %1\n_ran: %2\n_tlogic: %3\n_respawnpoint: %4", _OurSide, _ran, _tlogic, _respawnpoint];

	// location, returned from this function
	_respawnpoint
};
