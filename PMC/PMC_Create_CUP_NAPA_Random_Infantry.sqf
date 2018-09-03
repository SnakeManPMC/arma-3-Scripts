// PMC_Create_CUP_NAPA_Random_Infantry.sqf

PMC_Create_CUP_NAPA_Random_Infantry =
{
	// updated from CUP_Units v1.10.1
	// I think this is the warlord which we want to avoid: "CUP_I_GUE_Officer",
	private _list = ["CUP_I_GUE_Soldier_AKSU","CUP_I_GUE_Soldier_AKM","CUP_I_GUE_Soldier_AKS74","CUP_I_GUE_Soldier_GL","CUP_I_GUE_Soldier_AT","CUP_I_GUE_Soldier_AA","CUP_I_GUE_Soldier_AR","CUP_I_GUE_Soldier_MG","CUP_I_GUE_Saboteur","CUP_I_GUE_Medic","CUP_I_GUE_Crew","CUP_I_GUE_Engineer","CUP_I_GUE_Ammobearer","CUP_I_GUE_Soldier_AA2","CUP_I_GUE_Pilot","CUP_I_GUE_Sniper","CUP_I_GUE_Soldier_Scout","CUP_I_GUE_Commander","CUP_I_GUE_Local","CUP_I_GUE_Woodman","CUP_I_GUE_Gamekeeper","CUP_I_GUE_Forester","CUP_I_GUE_Farmer","CUP_I_GUE_Villager"];

	private
	[
		"_grp",
		"_pos"
	];

	_pos = _this select 0;

	_grp = createGroup east;
	waitUntil {!(isNull _grp)};

	(selectRandom _list) createUnit [_pos, _grp, "", 0.55, "LIEUTENANT"];
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.5, "SERGEANT"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.5, "SERGEANT"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.44, "CORPORAL"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.44, "CORPORAL"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.44, "CORPORAL"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.44, "CORPORAL"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.44, "CORPORAL"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.4, "CORPORAL"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.4, "CORPORAL"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.3, "PRIVATE"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.3, "PRIVATE"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.3, "PRIVATE"]; };
	if (random 1 > 0.85) then { (selectRandom _list) createUnit [_pos, _grp, "", 0.3, "PRIVATE"]; };

	_grp
};
