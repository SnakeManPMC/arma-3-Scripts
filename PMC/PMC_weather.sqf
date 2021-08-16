
// random weather

private _Overcast_Random_Amount = _this select 0;

private _ran = (random _Overcast_Random_Amount);
// apparently rain doesnt work if overcast value is above 1 :)
if (_ran > 1) then { _ran = 1; };
0 setOvercast _ran;
forceWeatherChange;

[_ran] spawn
{
	sleep 7;
	player sideChat format["Initial weather: %1", _this select 0];
	hint format["Initial weather: %1", _this select 0];
};

// this is run on server only
[_Overcast_Random_Amount] spawn
{
	private
	[
		"_duration",
		"_ForeCast",
		"_minimum_change_time",
		"_Overcast_Random_Amount",
		"_PMC_WeatherChangeTime",
		"_PMC_do_overcast"
	];

	_Overcast_Random_Amount = _this select 0;

	call compile preProcessFileLineNumbers "PMC\PMC_weather_to_string.sqf";

	while {true} do
	{
		_duration = random (60 * 10);
		_minimum_change_time = 5400;

		_PMC_do_overcast = random _Overcast_Random_Amount;

		_ForeCast = [_PMC_do_overcast] call PMC_weather_to_string;

		PMC_Weather_forecast = format
		[
			"PMC_Weather: report: %1 change time %2 min, duration %3 min. setOvercast: %4",
			_ForeCast,
			(floor (_minimum_change_time / 60)),
			(floor (_duration / 60)),
			_PMC_do_overcast
		];
		_minimum_change_time setOvercast _PMC_do_overcast;
		simulWeatherSync;

		diag_log format["%1", PMC_Weather_forecast];
		sleep (_minimum_change_time + _duration);
	};
};
