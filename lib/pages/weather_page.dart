import 'package:flutter/material.dart';
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
  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
