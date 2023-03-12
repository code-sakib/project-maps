import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mapbox_turn_by_turn/data/bloc/weather_bloc.dart';
import 'package:mapbox_turn_by_turn/data/weather/models/current_weather_data.dart';
import 'package:mapbox_turn_by_turn/ui/pages/home_page.dart';
import 'package:mapbox_turn_by_turn/ui/widgets/weather_page_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(RequestWeatherData());
    BlocProvider.of<CitiesBloc>(context).add(RequestWeatherData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  image: DecorationImage(
                      image: AssetImage('assets/weather/all_weather.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: [
                    const Positioned(
                      top: 90,
                      left: 50,
                      child: SizedBox(
                        width: 270,
                        height: 40,
                        child: SearchWeatherBar(),
                      ),
                    ),
                    BlocBuilder<WeatherBloc, RequestWeatherData>(
                      builder: (context, state) {
                        return Align(
                          alignment: const Alignment(0.0, 1.1),
                          child: SizedBox(
                            width: 10,
                            height: 0,
                            child: OverflowBox(
                              minHeight: 0,
                              minWidth: 0,
                              maxWidth: MediaQuery.of(context).size.width,
                              maxHeight:
                                  MediaQuery.of(context).size.height / 3.5,
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: state.currentWeatherData !=
                                                    null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      state.currentWeatherData!
                                                          .name!
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium!
                                                                  .fontSize),
                                                    ),
                                                  )
                                                : const Text("No City Found"),
                                          ),
                                          Text(DateFormat()
                                              .add_MMMMEEEEd()
                                              .format(DateTime.now())),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      state.currentWeatherData !=
                                                              null
                                                          ? '${state.currentWeatherData!.weatherDetailsModel!['description']}'
                                                          : '',
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      state.currentWeatherData !=
                                                              null
                                                          ? '${state.currentWeatherData!.main!['temp'].toStringAsPrecision(2)}\u2103'
                                                          : '',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      state.currentWeatherData !=
                                                              null
                                                          ? 'min: ${state.currentWeatherData!.main!['temp_min']}\u2103/max: ${state.currentWeatherData!.main!['temp_max'].toStringAsPrecision(3)}\u2103'
                                                          : '',
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 120,
                                                    height: 100,
                                                    decoration: const BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'assets/weather/weather_icon.jpg'),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  Text(
                                                    state.currentWeatherData !=
                                                            null
                                                        ? 'wind: ${state.currentWeatherData!.wind!['speed']}m/s'
                                                        : '',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
                height: 600,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        padding: const EdgeInsets.only(top: 120),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'other city'.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            BlocProvider.of<CitiesBloc>(context)
                                                .add(RequestWeatherData());
                                          },
                                          icon:
                                              const Icon(Icons.refresh_rounded))
                                    ],
                                  ),
                                ),
                                BlocBuilder<CitiesBloc, List>(
                                  builder: (context, state) {
                                    return SizedBox(
                                        height: 150,
                                        child: ListView.separated(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const VerticalDivider(
                                                      color: Colors.transparent,
                                                      width: 5,
                                                    ),
                                            itemCount: state.length,
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                  width: 140,
                                                  height: 150,
                                                  child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                                (state[index]
                                                                            ?.name !=
                                                                        null)
                                                                    ? '${state[index]?.name}'
                                                                    : 'Not Found',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16)),
                                                            Text(
                                                                (state[index] !=
                                                                        null)
                                                                    ? '${state[index]!.main!['temp'].toStringAsPrecision(2)}\u2103'
                                                                    : 'Not Found',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16)),
                                                            Container(
                                                              width: 50,
                                                              height: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/weather/weather_icon.jpg'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                                (state[index] !=
                                                                        null)
                                                                    ? '${state[index]!.weatherDetailsModel!['description']}'
                                                                    : 'Not Found',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            14)),
                                                          ])));
                                            }));
                                  },
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'forcast next 5 days'.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ],
                                  ),
                                ),
                                BlocBuilder<WeatherBloc, RequestWeatherData>(
                                  builder: (context, state) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 240,
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: SfCartesianChart(
                                          primaryXAxis: CategoryAxis(),
                                          series: <
                                              ChartSeries<FiveDaysForecast,
                                                  String>>[
                                            SplineSeries<FiveDaysForecast,
                                                String>(
                                              dataSource: state.forecastData,
                                              xValueMapper:
                                                  (FiveDaysForecast f, _) =>
                                                      f.dateTime,
                                              yValueMapper:
                                                  (FiveDaysForecast f, _) =>
                                                      f.temp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ]),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/');
        },
        child: const Icon(Icons.my_location_rounded),
      ),
    );
  }
}
