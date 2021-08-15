
// sets mission time from the description.ext server parameters

private _tod = ["PMC_Time_of_Day"] call BIS_fnc_getParamValue;
if (_tod == -1) then
{
	skipTime (round random 24);
}
else
{
	skiptime ((_tod - daytime + 24) % 24);
};
