import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:weather_app/utils/location.dart';


const Api_key="e645b40a46aff43923e4fb24318235e2";

class WeatherDisplayData {

 Icon weatherIcon;
 AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon , required this.weatherImage});
  
}

class WeatherData {
 WeatherData({required this.locationData});

 late LocationHelper locationData;
 late double currentTemperature;
 late int currentCondition;
 late String city;

 Future<void> getCurrentTemperature() async {
  Response response = await get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${Api_key}&units=metric"));
   
   if (response.statusCode == 200) {
     String data = response.body;
     var currentWeather = jsonDecode(data);

     try{
      currentTemperature = currentWeather["main"]["temp"];
      currentCondition = currentWeather["weather"][0]["id"];
      city = currentWeather["name"];
     }
     catch (e) {
       print(e);
     }
   }
   else{
    print("Api'den deger gelmiyor");
   }
 }

 WeatherDisplayData getWeatherDisplayData(){

  if (currentCondition < 600) {
    return WeatherDisplayData(
      weatherIcon: const Icon(
        FontAwesomeIcons.cloud,
        size: 80,
        color: Colors.white,
      ),
      weatherImage: const AssetImage('assets/bulutlu.jpeg')
      );
      
  }
  else{
    var now =  DateTime.now();
    if (now.hour >= 19) {
      return WeatherDisplayData(
      weatherIcon: const Icon(
        FontAwesomeIcons.moon,
        size: 80,
        color: Colors.white,
      ),
      weatherImage: const AssetImage('assets/gece.jpeg')
      );
      
    }
    else{
      return WeatherDisplayData(
      weatherIcon: const Icon(
        FontAwesomeIcons.sun,
        size: 80,
        color: Colors.white,
      ),
      weatherImage: const AssetImage('assets/gündüz.jpeg')
      );
    }
  }
 }

}