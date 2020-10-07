import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simpleweatherapp/components/home_components.dart';
import 'package:simpleweatherapp/components/weather_detail_view.dart';
import 'package:simpleweatherapp/model/weather_model.dart';
import 'package:simpleweatherapp/services/weather.dart';
import 'package:simpleweatherapp/utils/size.dart';
import 'package:simpleweatherapp/utils/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({this.locationWeather});

  final locationWeather;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.white60, BlendMode.color),
                  image: AssetImage('assets/images/background.jpg'),
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              child: ContentsHomeScreen(locationWeather),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentsHomeScreen extends StatefulWidget {
  ContentsHomeScreen(this.locationWeather);

  final locationWeather;
  @override
  _ContentsHomeScreenState createState() => _ContentsHomeScreenState(locationWeather);
}

class _ContentsHomeScreenState extends State<ContentsHomeScreen>
   {
     _ContentsHomeScreenState(this.locationWeather);

     final locationWeather;
     int temp;
     String fullLocation;
     String status;
     String description;
     int pressure;
     int visibility;
     double windSpeed;
     int humidity;
     int timezone;
     String icon;
  Weather weather;
  WeatherModel  _weatherModel=new WeatherModel();
  TextEditingController _searchCityName = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    /// init url
   updateUI(locationWeather);
  }
     void updateUI(dynamic weatherData) {
       setState(() {
         if (weatherData == null) {
           temp = 0;
           icon = 'Error';
           description = 'Unable to get weather data';
           fullLocation = '';
           return;
         }
         double tem= weatherData['main']['temp'];
         temp = tem.toInt()- 273;
         fullLocation = weatherData['name'] + ', ' + weatherData['sys']['country'];
         status = weatherData['weather'][0]['main'];
         description = weatherData['weather'][0]['description'];
         pressure = weatherData['main']['pressure'];
         visibility = weatherData['visibility'];
         windSpeed = weatherData['wind']['speed'];
         humidity = weatherData['main']['humidity'];
         timezone = (weatherData['timezone'] / 3600).toInt();

         icon = 'http://openweathermap.org/img/w/${weatherData['weather'][0]['icon']}.png';
       });
     }



  @override
  Widget build(BuildContext context) {
    return
      CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  fullLocation,
                  style: bTextStyleLocation,
                ),
                leading: IconButton(
                  icon: Icon(Icons.my_location),
                  onPressed: () async {
                    var weatherData=await _weatherModel.getLocationWeather();
                    setState(() {
                     updateUI(weatherData);
                    });
                  },
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: MainWeather(
                    temp: temp,
                    status: status,
                    icon: icon,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    WeatherDetailsView(
                      'Weather',
                      description.toString(),
                      Icons.cloud,
                    ),
                    WeatherDetailsView(
                      'Pressure',
                      pressure.toString(),
                      Icons.pie_chart,
                      unit: ' hPa',
                    ),
                    WeatherDetailsView(
                      'Visibility',
                      visibility.toString(),
                      Icons.remove_red_eye,
                      unit: ' m',
                    ),
                    WeatherDetailsView(
                      'Wind Speed',
                      '${windSpeed}',
                      Icons.toys,
                      unit: ' m/s',
                    ),
                    WeatherDetailsView(
                      'Humidity',
                      humidity.toString(),
                      Icons.opacity,
                      unit: '%',
                    ),
                    WeatherDetailsView(
                      'Timezone',
                      'UTC+' + timezone.toString(),
                      Icons.av_timer,
                    ),
                    Container(
                      height: height * 0.15,
                      //padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            controller: _searchCityName,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Type city here ...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          RaisedButton(
                            child: Text('Search', style: bTextStyleLocation),
                            color: Colors.transparent,
                            onPressed: () async {
                              var weatherData=await _weatherModel.getCityWeather(_searchCityName.text);
                              print(weatherData);
                              setState(() {
                                updateUI(weatherData);
                                _searchCityName.text="";
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

  }
}
