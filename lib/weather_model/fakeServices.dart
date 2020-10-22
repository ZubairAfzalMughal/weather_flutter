import 'dart:convert';

import 'package:weather_flutter/weather_model/fakemodel.dart';
import 'package:http/http.dart' as http;
class FakeService{

  Future<Fake> getComment()async{
    final response=await http.get('https://jsonplaceholder.typicode.com/comments/1');
    if(response.statusCode==200){
      final jsonResponse=jsonDecode(response.body);
      return Fake.fromJson(jsonResponse);
    }else{
      print("error");
    }
  }
}