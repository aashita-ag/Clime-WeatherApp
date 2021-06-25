import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:clime/services/weather.dart';
import 'package:flutter/widgets.dart';
import 'city_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0,
      feelTemp = 0,
      tempMin = 0,
      tempMax = 0,
      pressure = 0,
      humidity = 0,
      visibility = 0;
  double windspeed = 0;
  String cityName = '', description = '';
  AssetImage background = AssetImage('images/location_background');

  TextStyle kInfoTextStyle = GoogleFonts.quicksand(
    textStyle: TextStyle(
      fontSize: 15,
        fontWeight: FontWeight.w400
    )
  );
  TextStyle kValueTextStyle = GoogleFonts.quicksand(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600
      )
  );

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        feelTemp = 0;
        cityName = 'Unable to fetch';
        background = AssetImage('images/demo.png');
      }
      temperature = (weatherData['main']['temp']).toInt();
      feelTemp = (weatherData['main']['feels_like']).toInt();
      cityName = weatherData['name'];
      description = weatherData['weather'][0]['main'];
      background = weather.getBackground(weatherData['weather'][0]['id']);
      tempMin = (weatherData['main']['temp_min']).toInt();
      tempMax = (weatherData['main']['temp_max']).toInt();
      pressure = weatherData['main']['pressure'];
      humidity = weatherData['main']['humidity'];
      visibility = weatherData['visibility'];
      windspeed = weatherData['wind']['speed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: background,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 15),
                        child: Text(
                          cityName,
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200.withOpacity(0.6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 40, top: 20, bottom: 20),
                                child: Text(
                                  'Wind Speed',
                                  style: kInfoTextStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 40, top: 20, bottom: 20),
                                child: Text(
                                  'Humidity',
                                  style: kInfoTextStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 40, top: 20, bottom: 20),
                                child: Text(
                                  'Pressure',
                                  style: kInfoTextStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 40, top: 20, bottom: 20),
                                child: Text(
                                  'Visibility',
                                  style: kInfoTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, bottom: 20),
                                child: Text(
                                  '$windspeed m/s',
                                  style: kValueTextStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, bottom: 20),
                                child: Text(
                                  '$humidity %',
                                  style: kValueTextStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, bottom: 20),
                                child: Text(
                                  '$pressure hPa',
                                  style: kValueTextStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, bottom: 20),
                                child: Text(
                                  '$visibility meters',
                                  style: kValueTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Text(
                    description,
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 5.0,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Material(
                    color: Colors.grey.shade200.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Feels like : $feelTemp°',
                        style: kValueTextStyle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 30),
                  child: Text(
                    '$temperature°',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 130,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 5.0,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
