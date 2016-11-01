
PMC_Create_CUP_US_Army_Rifle_Squad =
{
	private
	[
		"_grp",
		"_respawnpoint"
	];

	_respawnpoint = _this select 0;

	_grp = createGroup west;
	waitUntil {!(isNull _grp)};

	"CUP_B_US_Soldier_SL" createUnit [_respawnpoint, _grp, "", 0.55, "LIEUTENANT"];
	"CUP_B_US_Soldier_TL" createUnit [_respawnpoint, _grp, "", 0.5, "SERGEANT"];
	"CUP_B_US_Soldier_GL" createUnit [_respawnpoint, _grp, "", 0.5, "SERGEANT"];
	"CUP_B_US_Soldier_AR" createUnit [_respawnpoint, _grp, "", 0.44, "CORPORAL"];
	"CUP_B_US_Soldier_AT" createUnit [_respawnpoint, _grp, "", 0.44, "CORPORAL"];
	"CUP_B_US_Soldier_TL" createUnit [_respawnpoint, _grp, "", 0.44, "CORPORAL"];
	"CUP_B_US_Soldier_GL" createUnit [_respawnpoint, _grp, "", 0.4, "CORPORAL"];
	"CUP_B_US_Soldier_AR" createUnit [_respawnpoint, _grp, "", 0.4, "CORPORAL"];
	"CUP_B_US_Soldier_AAR" createUnit [_respawnpoint, _grp, "", 0.4, "CORPORAL"];

	_grp
};
