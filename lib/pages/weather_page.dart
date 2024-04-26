import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService("23578e5c20121b9e78e83088f7975456");
  Weather? _weather;

  // fetch weather
  _fetchWeather() async{
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    //try to get the weather for this city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch(e){
      print(e);
    }
  }
  // weather animation
  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/lotties/sunny.json';

    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/lotties/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/lotties/rain.json';
      case 'thunderstorm':
        return 'assets/lotties/thunder.json';
      case 'clear':
        return 'assets/lotties/sunnyjson';
        default:
          return 'assets/lotties/sunny.json';
    }
  }
  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city.."),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
