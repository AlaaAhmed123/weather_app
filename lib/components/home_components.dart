import 'package:flutter/material.dart';
import 'package:simpleweatherapp/utils/size.dart';
import 'package:simpleweatherapp/utils/theme.dart';

class MainWeather extends StatelessWidget {
  final String status;
  final String icon;
  int temp;

  MainWeather({this.temp, this.status, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 110),
      child: Column(
        children: [

          Text(
            '${temp.toInt()}°',
            style: bTextStyleDegree,
          ),
          Text(
            '${status}',
            style: bTextStyleDescription,
          ),
          SizedBox(height:1),
          Container(
            child: Image.network(icon),
          ),
        ],
      ),
    );
  }
}
