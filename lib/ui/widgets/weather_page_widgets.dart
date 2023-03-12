import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';
import 'package:mapbox_turn_by_turn/data/bloc/weather_bloc.dart';

class SearchWeatherBar extends StatefulWidget {
  const SearchWeatherBar({key}) : super(key: key);

  @override
  State<SearchWeatherBar> createState() => _SearchWeatherBarState();
}

class _SearchWeatherBarState extends State<SearchWeatherBar> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: (value) {},
      onSubmitted: (value) {
        BlocProvider.of<WeatherBloc>(
          context,
        ).add(RequestWeatherData(
            requestedCity: value
              ..toLowerCase()
              ..trim()));

        displayedWeatherOfCity.add(value.toLowerCase()..trim());
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
        suffixIcon: IconButton(
            onPressed: () {
              return setState(() {
                textEditingController.text = '';
              });
            },
            icon: const Icon(Icons.cancel_rounded)),
        hintStyle: const TextStyle(color: Colors.white, fontSize: 13),
        hintText: 'search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 13),
    );
  }
}
