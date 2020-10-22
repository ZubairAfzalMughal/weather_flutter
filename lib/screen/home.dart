import 'package:flutter/material.dart';
import 'package:weather_flutter/weather_model/fakeServices.dart';
import 'package:weather_flutter/weather_model/fakemodel.dart';
import 'package:weather_flutter/weather_model/weather_services.dart';
import 'package:weather_flutter/weather_model/weathermodel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Choice _choice = Choice.home;
  Future<Welcome> welcome;
  Future<Fake> _fakeModel;
  String city = 'London';
  TextEditingController _controller=TextEditingController();
  @override
  void initState() {
    super.initState();
    welcome = WeatherServices().getWeather(city);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              onSubmitted: (query){
                WeatherServices().getWeather(query).then((value) {
                  setState(() {
                    welcome=value as Future<Welcome>;
                  });
                });
                },
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 20.0),
                  hintText: 'Search',
                  suffix: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      WeatherServices().getWeather(_controller.text);
                    },
                  ),),
            ),
          ),
          Center(
            child: FutureBuilder<Welcome>(
              future: welcome,
              builder: (BuildContext context, AsyncSnapshot<Welcome> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        toKelvin(snapshot.data.main.temp).toString(),
                        style: TextStyle(fontSize: 30.0),
                      ),
                      (Text(
                        snapshot.data.weather[0].description,
                        style: TextStyle(fontSize: 20.0),
                      )),
                      Text(
                        city,
                        style: TextStyle(fontSize: 20.0),
                      )
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return CircularProgressIndicator();
                } else {
                  return Text(
                    "No data",
                    style: TextStyle(fontSize: 20.0),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int toKelvin(double k) {
    double result = k - 273.0;
    return result.toInt();
  }
}

enum Choice { home, search }
