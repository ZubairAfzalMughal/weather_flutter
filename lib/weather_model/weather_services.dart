import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_flutter/weather_model/weathermodel.dart';

class WeatherServices {
 

  Future<Welcome> getWeather(String name) async {
    String url = 'https://api.openweathermap.org/data/2.5/weather?q=$name&appid=92480f0363f258feaabdf1c42e38da4b';
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse=jsonDecode(response.body);
        return Welcome.fromJson(jsonResponse);
      } else {
        print("error");
      }
    }
}



