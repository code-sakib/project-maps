import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';
import 'package:mapbox_turn_by_turn/data/weather/models/current_weather_data.dart';
import 'package:mapbox_turn_by_turn/data/weather/weather_service.dart';

abstract class WeatherEvent {}

class WeatherInitial extends WeatherEvent {}

class RequestWeatherData extends WeatherEvent {
  //Current weather of city
  String requestedCity;
  CurrentWeatherData? currentWeatherData;

  //Five Cities weather data
  List<CurrentWeatherData?> listOfCitiesWeather = [];
  dynamic errorMap = {};

  RequestWeatherData({this.requestedCity = 'mumbai'});

  static List<String> listOfOptionCities = [
    'atlanta',
    'california',
    'france',
    'switzerland',
    'new zealand',
    'chicago',
    'africa',
    'ontario',
    'new york',
    'toronto',
    'berlin',
    'paris',
    'china',
    'bengal',
  ];

  //Weather Forecasting
  List<FiveDaysForecast> forecastData = [];

  Future<void> getData() async {
    var requestedData =
        await WeatherService(city: requestedCity).getCurrentWeatherData();
    if (requestedData is Map) {
      errorMap = requestedData;
    } else if (requestedData is CurrentWeatherData) {
      currentWeatherData = requestedData;
    }
  }

  Future<List> getDataOfFiveCities() async {
    List<String> listOfCityToBeDisplayed = [];
    listOfOptionCities.shuffle();

    for (var city in listOfOptionCities) {
      if (!displayedWeatherOfCity.contains(city)) {
        listOfCityToBeDisplayed.add(city);
      }
    }

    for (var i = 0; i < 5; i++) {
      var requestedData = await WeatherService(city: listOfCityToBeDisplayed[i])
          .getCurrentWeatherData();
      if (requestedData is Map) {
        errorMap = requestedData;
      } else if (requestedData is CurrentWeatherData) {
        listOfCitiesWeather.add(requestedData);
      }
    }
    return listOfCitiesWeather;
  }

  Future<void> getForecaseData() async {
    List<FiveDaysForecast>? requestedData =
        await WeatherService(city: requestedCity).getFiveDaysForecast();

    if (requestedData != null) {
      forecastData = requestedData;
    } else {
      forecastData = [];
    }
  }

  RequestWeatherData? copyWith(RequestWeatherData other) {
    if (other.requestedCity != requestedCity ||
        other.listOfCitiesWeather != listOfCitiesWeather) {
      return other;
    } else {
      return other;
    }
  }
}

class WeatherBloc extends Bloc<WeatherEvent, RequestWeatherData> {
  WeatherBloc() : super(RequestWeatherData()) {
    on<WeatherEvent>((event, emit) async {
      if (event is RequestWeatherData) {
        RequestWeatherData obj = state
            .copyWith(RequestWeatherData(requestedCity: event.requestedCity))!;
        await obj.getData();
        await obj.getForecaseData();
        emit(obj);
      } else {
        emit(state);
      }
    });
  }
}

class CitiesBloc extends Bloc<WeatherEvent, List> {
  CitiesBloc() : super(RequestWeatherData().listOfCitiesWeather) {
    on<WeatherEvent>((event, emit) async {
      if (event is RequestWeatherData) {
        await event.getDataOfFiveCities();
        event.copyWith(event);
        emit(event.listOfCitiesWeather);
      }
    });
  }
}

class WeatherNotifier extends ChangeNotifier {
  RequestWeatherData? requestedWeatherData;

  changeWeather(String cityName) async {
    requestedWeatherData = RequestWeatherData(requestedCity: cityName);
    requestedWeatherData!.getData();
    notifyListeners();
  }
}
