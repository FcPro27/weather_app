import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/utils/location.dart';
import 'package:weather_app/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData =LocationHelper();
    await locationData.getCurrentLocation();
    if (locationData.latitude == 0.0 || locationData.longitude == 0.0) {
      print("Konum Bilgileri Gelmiyor");
      
    }else{
      print("latitude" + locationData.latitude.toString());
      print("longitude" + locationData.longitude.toString());

    }
    
  }
  void getWeatherData()async {
    await getLocationData();
    WeatherData weatherData =WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(weatherData: weatherData);
    },));
  }
  @override
  void initState() {
    super.initState();
    getWeatherData();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black,Color.fromARGB(255, 69, 69, 69)]
            )
        ),
        child: const Center(
          child: SpinKitPulsingGrid(
            color: Color.fromARGB(255, 255, 255, 255),
            size: 80,
            ),
        ),
      ),
    );
  }
}