/*

Run this on both server AND client!

Syntax:
// set our weather using multiplayer parameter array
[] execVM "PMC\PMC_weather_with_mp_parameter.sqf";


Description of the array contents:

class Params
{
// (paramsarray select 0)
	class SomeThing	{};

// (paramsarray select 1)
// please note that "Random" requires PMC\PMC_weather.sqf
	class PMC_WeatherSetting
	{
		title = "Weather setting";
		values[] = {1, 2, 3, 4, 5, 6, 7};
		texts[] = {"Clear skies", "Overcast", "Cloudy", "Rain storm", "Rain storm with fog", "Random (Rainy - Jungles)", "Random (Dry - Deserts)"};
		default = 7;
	};
};

(paramsarray select 1)

1 "Clear skies"
2 "Overcast"
3 "Cloudy"
4 "Rain storm"
5 "Rain storm with fog"
6 "Random (Rainy - Jungles)" (requires PMC_weather.sqf)
7 "Random (Dry - Deserts)" (requires PMC_weather.sqf)

*/
switch (paramsarray select 1) do
{
	// clear skies
	case 1:
	{
		0 setOvercast 0;
		0 setRain 0;
	};
	
	// overcast
	case 2:
	{
		0 setOvercast 0.5;
		0 setRain 0;
	};
	
	// Cloudy
	case 3:
	{
		0 setOvercast 0.75;
		0 setRain 0;
	};
	
	// rain storm
	case 4:
	{
		0 setOvercast 1;
		0 setRain 1;
	};
	
	// rain storm with fog
	case 5:
	{
		0 setOvercast 1;
		0 setRain 1;
		0 setFog 0.5;
	};
	
	// random, no parameters; (rainy - jungles)
	case 6:
	{
		[] execVM "PMC\PMC_weather.sqf";
	};

	// random (dry - deserts)
	case 7:
	{
		[0.75] execVM "PMC\PMC_weather.sqf";
	};
};
