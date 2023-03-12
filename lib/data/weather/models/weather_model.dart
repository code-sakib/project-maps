class WeatherModels {
  static Map? coordinateModel(dynamic json) {
    Map? coordModelMap;
    if (json == null) {
      return coordModelMap;
    } else {
      coordModelMap = {};
      Map jsonEntry = {'lon': json['lon'], 'lat': json['lat']};
      coordModelMap.addEntries(jsonEntry.entries);
      return coordModelMap;
    }
  }

  static Map? weatherDetailsModel(dynamic json) {
    Map? weatherDetailsModelMap;

    if (json == null) {
      return weatherDetailsModelMap;
    } else {
      weatherDetailsModelMap = {};
      Map jsonEntry = {
        'id': json[0]['id'],
        'main': json[0]['main'],
        'description': json[0]['description'],
        'icon': json[0]['icon'],
      };
      weatherDetailsModelMap.addEntries(jsonEntry.entries);

      return weatherDetailsModelMap;
    }
  }

  static Map? mainWeatherModel(dynamic json) {
    Map? mainWeatherModelMap;

    if (json == null) {
      return mainWeatherModelMap;
    } else {
      mainWeatherModelMap = {};
      Map jsonEntry = {
        'temp': json['temp'],
        'feels_like': json['feels_like'],
        'temp_min': json['temp_min'],
        'temp_max': json['temp_max'],
        'pressure': json['pressure'],
        'humidity': json['humidity'],
      };
      mainWeatherModelMap.addEntries(jsonEntry.entries);
      return mainWeatherModelMap;
    }
  }

  static Map? windModel(dynamic json) {
    Map? windModelMap;

    if (json == null) {
      return windModelMap;
    } else {
      windModelMap = {};
      Map jsonEntry = {
        'speed': json['speed'],
        'deg': json['deg'],
      };
      windModelMap.addEntries(jsonEntry.entries);

      return windModelMap;
    }
  }

  static Map? cloudsModel(dynamic json) {
    Map? cloudsModelMap;
    if (json == null) {
      return cloudsModelMap;
    } else {
      cloudsModelMap = {};
      Map jsonEntry = {'all': json['all']};
      cloudsModelMap.addEntries(jsonEntry.entries);

      return cloudsModelMap;
    }
  }

  static Map? sysModel(dynamic json) {
    Map? sysModelMap;

    if (json == null) {
      return sysModelMap;
    } else {
      sysModelMap = {};
      Map jsonEntry = {
        'type': json['type'],
        'id': json['id'],
        'country': json['country'],
        'sunrise': json['sunrise'],
        'sunset': json['sunset'],
      };
      sysModelMap.addEntries(jsonEntry.entries);
      return sysModelMap;
    }
  }
}
