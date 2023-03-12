import 'package:mapbox_turn_by_turn/data/weather/models/weather_model.dart';

class CurrentWeatherData {
  Map? coordinateModel;
  Map? weatherDetailsModel;
  String? base;
  Map? main;
  int? visibility;
  Map? wind;
  Map? clouds;
  int? dt;
  Map? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  CurrentWeatherData(
      {this.coordinateModel,
      this.weatherDetailsModel,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  factory CurrentWeatherData.fromJson(dynamic json) {
    if (json == null) {
      return CurrentWeatherData();
    } else {
      return CurrentWeatherData(
          coordinateModel: WeatherModels.coordinateModel(json['coord']),
          weatherDetailsModel:
              WeatherModels.weatherDetailsModel(json['weather']),
          base: json['base'],
          main: WeatherModels.mainWeatherModel(json['main']),
          visibility: json['visibility'],
          wind: WeatherModels.windModel(json['wind']),
          clouds: WeatherModels.cloudsModel(json['clouds']),
          dt: json['dt'],
          sys: WeatherModels.sysModel(json['sys']),
          timezone: json['timezone'],
          id: json['id'],
          name: json['name'],
          cod: json['cod']);
    }
  }
}

class FiveDaysForecast {
  final String? dateTime;
  final int? temp;
  FiveDaysForecast({
    this.dateTime,
    this.temp,
  });

  factory FiveDaysForecast.fromJson(dynamic json) {
    if (json == null) {
      return FiveDaysForecast();
    } else {
      var f = json['dt_txt'].split(' ')[0].split('-')[2];
      var l = json['dt_txt'].split(' ')[1].split(':')[0];

      var fandl = '$f-$l';
      return FiveDaysForecast(
          dateTime: fandl,
          temp: double.parse(json['main']['temp'].toString()).round());
    }
  }
}
