import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clime/services/location.dart';
import 'package:clime/services/networking.dart';

const apiKey = 'd1fd97fec12c284009e1875c20f1c417';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    print(weatherData['name']);
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  AssetImage getBackground(int condition) {
    DateTime curTime = DateTime.now();
    if (curTime.hour>=6&&curTime.hour<18) {
      if (condition < 300) {
        return AssetImage('images/stormd.png');
      } else if (condition < 400) {
        return AssetImage('images/drizd.png');
      } else if (condition < 600) {
        return AssetImage('images/raind.png');
      } else if (condition < 700) {
        return AssetImage('images/snowd.png');
      } else if (condition < 800) {
        return AssetImage('images/hazyd.png');
      } else if (condition == 800) {
        return AssetImage('images/cleard.png');
      } else {
        return AssetImage('images/cloudd.png');
      }
    } else {
      if (condition < 300) {
        return AssetImage('images/stormn.png');
      } else if (condition < 400) {
        return AssetImage('images/drizn.png');
      } else if (condition < 600) {
        return AssetImage('images/rainn.png');
      } else if (condition < 700) {
        return AssetImage('images/snown.png');
      } else if (condition < 800) {
        return AssetImage('images/hazyn.png');
      } else if (condition == 800) {
        return AssetImage('images/clearn.png');
      } else {
        return AssetImage('images/cloudn.png');
      }
    }
  }
}
