import 'package:flutter/material.dart';
import 'package:simpleweatherapp/utils/size.dart';
import 'package:simpleweatherapp/utils/theme.dart';

class WeatherDetailsView extends StatelessWidget {
  final String title;
  final String data;
  final IconData icon;
  String unit;
  WeatherDetailsView(this.title, this.data, this.icon, {this.unit = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: height * 0.004, horizontal: width * 0.04),
      child: Card(
        elevation: 2,
        color: Colors.transparent,
        child: ListTile(
          title: Text('$title : $data$unit', style: bTextStyleDetail),
          trailing: Icon(icon),
        ),
      ),
    );
  }
}
