/*

	Called from PMC_weather.sqf

Syntax:
call compile preProcessFileLineNumbers = "PMC\PMC_weather_to_string.sqf";
_forecast = [overCast] call PMC_weather_to_string;

Requires:
PMC\PMC_weather.sqf

Returns:
_forest string containing text of the fore cast information.

*/

PMC_weather_to_string =
{
	private
	[
		"_overcast",
		"_mystring"
	];
	
	_overcast = _this select 0;
	_mystring = "Completely sunny and clear skies.";

	if (_overcast > 0.2) then
	{
		_mystring = "Bright and clear skies.";
	};

	if (_overcast > 0.3) then
	{
		_mystring = "Clear skies.";
	};

	if (_overcast > 0.5) then
	{
		_mystring = "Slight overcast skies.";
	};
	
	if (_overcast > 0.7) then
	{
		_mystring = "Cloudy skies with chance of rain.";
	};
	
	if (_overcast > 0.8) then
	{
		_mystring = "Cloudy skies with rain.";
	};
	
	if (_overcast > 0.9) then
	{
		_mystring = "Stormy skies with heavy of rain and low visibility.";
	};
	
	_mystring
};
