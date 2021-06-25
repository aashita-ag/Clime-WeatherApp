import 'package:flutter/material.dart';
import 'weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clime/services/weather.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(weatherData);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE2E4E7),
              Color(0xFF41B0C1),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/load.jpg'),
                radius: 150,
              ),
              SizedBox(
                height: 100,
              ),
              SpinKitFadingCircle(
                color: Color(0xFFE2E4E7),
                size: 50,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Fetching Location...',
                style: GoogleFonts.anticSlab(
                  textStyle: TextStyle(
                    color: Color(0xFF505149),
                    fontSize: 35,
                    fontWeight: FontWeight.w400
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
