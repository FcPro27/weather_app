import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/utils/weather.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late int tempreature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      tempreature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
      city = weatherData.city;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image:backgroundImage,
          fit: BoxFit.cover,
          ),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 60,),
          Container(
            child: weatherDisplayIcon,
          ),
           const SizedBox(height: 15,),
            Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("$tempreature°",
              style: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 80,
                color: Colors.white
              ),),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(city,
              style: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 50,
                color: Colors.white
              ),),
            ),
          )
          
          
        ],
      )
    );
  }
}