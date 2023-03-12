import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_turn_by_turn/data/bloc/weather_bloc.dart';

class ForJust extends StatelessWidget {
  const ForJust({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherEvent>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state is RequestWeatherData
                      ? Text('${state.currentWeatherData!.name}')
                      : Text('$state'),
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<WeatherBloc>(context)
                            .add(RequestWeatherData(requestedCity: 'mumbai'));
                      },
                      child: const Text('sdf'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
