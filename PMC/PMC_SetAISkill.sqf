/*

	PMC_SetAISkill, lowers super human AI skills to much nicer level (or not)

	2019-12-14 Original script was made for PMC Delta Safari and today edited for PMC Insurgent Rage 1

Syntax:
[group, skill] execVM "PMC\PMC_SetAISkill.sqf";

Example:
call compile preProcessFileLineNumbers "PMC\PMC_SetAISkill.sqf";
[_grp, 0.25] call PMC_SetAISkill;

Requires:
-

Returns:
-

*/

PMC_SetAISkill =
{
	private ["_grp", "_skillValue", "_PMC_Process_Skills"];

	_grp = _this select 0;

	// max skill value we want to use
	_skillValue = _this select 1;

	diag_log format["PMC_SetAISkill; _grp: %1, _skillValue: %2", _grp, _skillValue];

	_PMC_Process_Skills =
	{
		private ["_guy","_skillValue"];

		_guy = _this select 0;
	        _skillValue = _this select 1;

		{
			_guy setSkill [_x, (random _skillValue)];
		} forEach
		[
			"aimingAccuracy",
			"aimingShake",
			"aimingSpeed",
			"endurance",
			"spotDistance",
			"spotTime",
			"courage",
			"reloadSpeed",
			"commanding",
			"general"
		];
	};


	// run it for the whole group
	{
		[_x, _skillValue] call _PMC_Process_Skills;
	} forEach units _grp;
};
