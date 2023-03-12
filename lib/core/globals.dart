import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

late SharedPreferences sharedPreferences;

//When permission enables it will rebuild
ValueNotifier<bool> deviceLocationPermission = ValueNotifier<bool>(false);
final scaffolfMessengerKey = GlobalKey<ScaffoldMessengerState>();

//When request fails, notifies to build the error handling
bool requestError = false;

bool? fromEnabled;

bool sourceGiven = false;

int longPressNumber = 0;

int selectLocationNumber = 0;

List<String> displayedWeatherOfCity = [];

