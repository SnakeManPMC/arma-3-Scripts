
// PMC_Get_Skill_Level.sqf

// parameter 0 through 5
private _pmc_skill = _this select 0;

private _finalSkill = 0.2;

//values[] = {0, 1, 2, 3, 4, 5};
//texts[] = {"Dumb 0.1", "Beginner 0.2", "Normal 0.33", "Good 0.5", "Elite 0.85", "SUPER SNIPER 1"};

// 0 dumb 0.1
if (_pmc_skill == 0) then
{
	_finalSkill = 0.1;
};

// 1 beginner 0.2
if (_pmc_skill == 1) then
{
	_finalSkill = 0.2;
};

// 2 normal 0.33
if (_pmc_skill == 2) then
{
	_finalSkill = 0.33;
};

// 3 good 0.5
if (_pmc_skill == 3) then
{
	_finalSkill = 0.5;
};

// 4 elite 0.85
if (_pmc_skill == 4) then
{
	_finalSkill = 0.85;
};

// 5 super sniper 1
if (_pmc_skill == 5) then
{
	_finalSkill = 1;
};

_finalSkill
