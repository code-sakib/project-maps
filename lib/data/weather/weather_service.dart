import 'package:mapbox_turn_by_turn/data/weather/models/current_weather_data.dart';
import 'package:mapbox_turn_by_turn/data/weather/weather_api_repo.dart';

class WeatherService {
  final String city;
  WeatherService({
    required this.city,
  });

  final String baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String apiKey = 'bdcda5a4e384885ce36b7af8c06640a9';

  Future<dynamic> getCurrentWeatherData() async {
    final String finalUrl =
        '$baseUrl/weather?q=$city&appid=$apiKey&units=metric';
    Future<Map<dynamic, dynamic>> modifiedResponse =
        WeatherApiRepository(url: finalUrl).get();

    Object? responseToReturn;

    await modifiedResponse.then((value) {
      if (value.containsKey('Error')) {
        responseToReturn = value;
      } else {
        responseToReturn = CurrentWeatherData.fromJson(value);
      }
    });

    return responseToReturn;
  }

  Future<List<FiveDaysForecast>?> getFiveDaysForecast() async {
    final String finalUrl =
        '$baseUrl/forecast?q=$city&appid=$apiKey&units=metric';

    Future<Map<dynamic, dynamic>> modifiedResponse =
        WeatherApiRepository(url: finalUrl).get();

    List<FiveDaysForecast>? responseToReturn;

    await modifiedResponse.then((value) {
      if (value.containsKey('Error')) {
        responseToReturn = [];
      } else {
        try {
          responseToReturn = (value['list'] as List)
              .map((e) => FiveDaysForecast.fromJson(e))
              .toList();
        } catch (e) {
          responseToReturn = List.empty();
        }
      }
    });

    return responseToReturn;
  }
}
