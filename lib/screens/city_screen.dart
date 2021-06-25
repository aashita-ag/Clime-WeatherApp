import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.clear,
                    color: Color(0xFF578E87),
                    size: 30,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10,top: 20,bottom: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          filled: true,
                          fillColor: Colors.white,
                          icon: Icon(
                            Icons.location_on,
                            color: Color(0xFF578E87),
                            size: 35,
                          ),
                          hintText: 'Enter City Name',
                          hintStyle: TextStyle(
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          cityName = value;
                        },
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, cityName);
                    },
                    child: Icon(Icons.arrow_forward,
                    size: 30,
                    color: Color(0xFF578E87),),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
