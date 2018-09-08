// PMC_Create_CUP_NAPA_Sniper_Team.sqf

PMC_Create_CUP_NAPA_Sniper_Team =
{
	private
	[
		"_grp",
		"_pos"
	];

	_pos = _this select 0;

	_grp = createGroup east;
	waitUntil {!(isNull _grp)};

	"CUP_I_GUE_Sniper" createUnit [_pos, _grp, "", 1, "LIEUTENANT"];
	"CUP_I_GUE_Soldier_Scout" createUnit [_pos, _grp, "", 0.33, "SERGEANT"];

	_grp
};
