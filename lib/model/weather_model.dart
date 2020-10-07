class Weather {
  dynamic temp;
  String fullLocation;
  String status;
  String description;

  int pressure;
  int visibility;
  double windSpeed;
  int humidity;
  int timezone;
  String icon;

  Weather(dynamic map) {
    fromJson(map);
  }

  void fromJson(dynamic map) {
    temp = map['main']['temp'] - 273;
    fullLocation = map['name'] + ', ' + map['sys']['country'];
    status = map['weather'][0]['main'];
    description = map['weather'][0]['description'];
    pressure = map['main']['pressure'];
    visibility = map['visibility'];
    windSpeed = map['wind']['speed'];
    humidity = map['main']['humidity'];
    timezone = (map['timezone'] / 3600).toInt();

    icon = 'http://openweathermap.org/img/w/${map['weather'][0]['icon']}.png';
  }
}
