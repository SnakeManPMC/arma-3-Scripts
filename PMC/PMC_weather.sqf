/*

	Dedicated server capable random weather script.

Syntax:
[] execVM "PMC\PMC_weather.sqf";
or
[OverCastRandomValue] execVM "PMC\PMC_weather.sqf";

Running without params uses default 1.1 overcast random value which is best suited to some vet
european / jungle environments, but if you want less rainy weather, use lower value by adding it as parameter

Requires:
PMC\PMC_weather_to_string.sqf

Returns:
-

*/
private ["_Overcast_Random_Amount"];

if ((count _this) > 0) then
{
	// grab the value from parameter
	_Overcast_Random_Amount = _this select 0;
}
else
{
	// user gave no parameter, so we set it to default 1.1 which is often times very rainy
	// this is how it used to be before adding this parameter option
	_Overcast_Random_Amount = 1.1;
};

// this must be if we run this on mission start, the very first time(?).
if (isNil "PMC_do_overcast") then
{
	// make our weather, the current mission editor chosen overCast.
	PMC_do_overcast = overCast;
}
else
{
	// if its already set, immediately change to this overcast.
	0 setOvercast PMC_do_overcast;
};

// eventhandler which executes on all clients every time its updated / broadcasted.
"PMC_do_overcast" addPublicVariableEventhandler
{
	// some nice weather info for our players.
	player sideChat PMC_Weather_forecast;
	// added hint
	hintSilent PMC_Weather_forecast;

	// change the weather.
	PMC_WeatherChangeTime setOvercast PMC_do_overcast;
//	player globalchat format["PMC_WeatherChangeTime: %1 setOvercast PMC_do_overcast: %2", PMC_WeatherChangeTime, PMC_do_overcast];

/*
this below doesn't work as there has to be some bug in the relations of
setOvercast <> setRain <> setFog. if you do setRain / setFog, setOvercast is cancelled
while rain and fog chances accordingly.
	// add artificial rain
	if (PMC_do_overcast > 0.7) then
	{
		diag_log format["true-PMC_weather.sqf:SleepPMC_WeatherChangeTime: %1, PMC_do_overcast: %2", PMC_WeatherChangeTime, PMC_do_overcast];
		// about half of the weather change time, put in heavy rain
		[] spawn
		{
			sleep 1;
			(PMC_WeatherChangeTime / 2) setRain 1;
		};

		// also fog :)
		[] spawn
		{
			sleep 1;
			(PMC_WeatherChangeTime / 2) setFog (PMC_do_overcast / 1.2);
		};
	}
	else
	{
		diag_log format["else-PMC_weather.sqf:SleepPMC_WeatherChangeTime: %1, PMC_do_overcast: %2", PMC_WeatherChangeTime, PMC_do_overcast];
		// about half of the weather change time, remove heavy rain
		// not sure if this is necessary, should setOvercast disable rain
		// automatically?
		[] spawn
		{
			sleep 1;
			(PMC_WeatherChangeTime / 2) setRain 0;
		};

		[] spawn
		{
			sleep 1;
			// idea is to leave lingering fog/mist after the moist rain...
			(PMC_WeatherChangeTime * 4) setFog 0;
		};
	};
*/
};

// if we are client, we exit.
if (!isServer) exitWith{};

// this is run on server only
[_Overcast_Random_Amount] spawn
{
	private
	[
		"_duration",
		"_ForeCast",
		"_minimum_change_time",
		"_Overcast_Random_Amount"
	];

	_Overcast_Random_Amount = _this select 0;

	// one second delay for unknown reasons? :)
	sleep 1;

/*
	// randomize duration
	_duration = random (60 * 60);

	// how long it takes for weather change to take effect
	_minimum_change_time = (60 * 1) + random (60 * 5);
	PMC_WeatherChangeTime = _minimum_change_time;
	publicVariable "PMC_WeatherChangeTime";

	// give our weather a random value
	PMC_do_overcast = random 1.1;
	publicVariable "PMC_do_overcast";

	// set the weather initially
	PMC_WeatherChangeTime setOvercast PMC_do_overcast;
*/

	// some string function to show nice forecast text.
	call compile preProcessFileLineNumbers "PMC\PMC_weather_to_string.sqf";

	// loop endlessly
	while {true} do
	{
		// randomize duration
		_duration = random (60 * 60 * 6); // (60 * 60). 6 hours?
		_minimum_change_time = (60 * 3) + random (60 * 10); // (60 * 1) + random (60 * 5)

		// choose new weather changing time
		PMC_WeatherChangeTime = _minimum_change_time;
		publicVariable "PMC_WeatherChangeTime";

		// set RANDOM overcast
		PMC_do_overcast = random _Overcast_Random_Amount;

		_ForeCast = [PMC_do_overcast] call PMC_weather_to_string;

		// forecast available to all clients
		PMC_Weather_forecast = format
		[
			"Weather report: %1, change time %2 min, duration %3 min.",
			_ForeCast,
			(floor (PMC_WeatherChangeTime / 60)),
			(floor (_duration / 60))
		];
		publicVariable "PMC_Weather_forecast";

		// broadcast it, when all clients will execute the eventhandler
		publicVariable "PMC_do_overcast";

		// and change the weather on server too.
		PMC_WeatherChangeTime setOvercast PMC_do_overcast;

////////////// cut
/*
		// add artificial rain
		if (PMC_do_overcast > 0.7) then
		{
			sleep 1;
			// about half of the weather change time, put in heavy rain
			(PMC_WeatherChangeTime / 2) setRain 1;
	
			// I remember there was bug that if set rain & fog close together
			// they do not work, so lets try one second pause.
			sleep 1;
	
			// also fog :)
			(PMC_WeatherChangeTime / 2) setFog (PMC_do_overcast / 1.2);
		}
		else
		{
			sleep 1;
			// about half of the weather change time, remove heavy rain
			// not sure if this is necessary, should setOvercast disable rain
			// automatically?
			(PMC_WeatherChangeTime / 2) setRain 0;
	
			// I remember there was bug that if set rain & fog close together
			// they do not work, so lets try one second pause.
			sleep 1;
	
			// idea is to leave lingering fog/mist after the moist rain...
			(PMC_WeatherChangeTime * 4) setFog 0;
		};
////////////// cut
*/
		// start with waiting until weather is "completed"
		// debug :)
		diag_log format
		[
			"PMC_weather.sqf Sleep PMC_WeatherChangeTime: %1 min, _duration: %2 min, PMC_do_overcast: %3, _ForeCast: %4",
			(PMC_WeatherChangeTime / 60),
			(_duration / 60),
			PMC_do_overcast,
			_ForeCast
		];
		sleep (PMC_WeatherChangeTime + _duration);
	};
};
