
PMC_Create_Russian_MSV_Squad_Flora =
{
	private
	[
		"_grp",
		"_respawnpoint"
	];

	_respawnpoint = _this select 0;

	_grp = createGroup east;
	waitUntil {!(isNull _grp)};

	"CUP_O_RU_Soldier_SL" createUnit [_respawnpoint, _grp, "", 0.55, "LIEUTENANT"];
	"CUP_O_RU_Soldier_MG" createUnit [_respawnpoint, _grp, "", 0.5, "SERGEANT"];
	"CUP_O_RU_Soldier_AT" createUnit [_respawnpoint, _grp, "", 0.5, "SERGEANT"];
	"CUP_O_RU_Soldier_LAT" createUnit [_respawnpoint, _grp, "", 0.44, "CORPORAL"];
	"CUP_O_RU_Soldier_GL" createUnit [_respawnpoint, _grp, "", 0.44, "CORPORAL"];
	"CUP_O_RU_Soldier_Marksman" createUnit [_respawnpoint, _grp, "", 0.44, "CORPORAL"];
	"CUP_O_RU_Soldier_MG" createUnit [_respawnpoint, _grp, "", 0.44, "CORPORAL"];
	"CUP_O_RU_Soldier_AT" createUnit [_respawnpoint, _grp, "", 0.44, "CORPORAL"];
	"CUP_O_RU_Soldier_AR" createUnit [_respawnpoint, _grp, "", 0.4, "CORPORAL"];
	"CUP_O_RU_Soldier_LAT" createUnit [_respawnpoint, _grp, "", 0.4, "CORPORAL"];
	"CUP_O_RU_Soldier_GL" createUnit [_respawnpoint, _grp, "", 0.4, "CORPORAL"];
	"CUP_O_RU_Soldier" createUnit [_respawnpoint, _grp, "", 0.4, "CORPORAL"];

	_grp
};
