import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('affefd6abbdedba6187b0b6377e89f75');
  Weather? _weather;

  //fetch weather 
  _fetchWeather() async{
    //get the current city 
  String cityName = await _weatherService.getCurrentCity(); 

    //get weather for city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }

  }
  //weather animations
String getWeatherAnimation(String? mainCondition){
  if(mainCondition == null) return 'assets/sunny.json';

  switch(mainCondition.toLowerCase()){
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/cloudy.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/rainy.json';
    case 'thunderstorm':
      return 'assets/thunderstorm.json';
    case 'clear':
      return 'assets/sunny.json';
    default:
      return 'assets/sunny.json';

  }

}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name 
            Text(_weather?.cityName ?? "Loading city..."),

            //Animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //temperature
            Text('${_weather?.temperature}°C')
          ],
        ),
      ),
    );
  }
}