import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_turn_by_turn/core/constants/maps_constants.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';
import 'package:mapbox_turn_by_turn/core/snack_bar.dart';
import 'package:mapbox_turn_by_turn/core/utilis/custom_toast.dart';
import 'package:mapbox_turn_by_turn/data/bloc/map_bloc.dart';
import 'package:mapbox_turn_by_turn/data/maps/mapbox_direction_requests.dart';
import 'package:mapbox_turn_by_turn/data/maps/mapbox_search.dart';
import 'package:mapbox_turn_by_turn/ui/pages/home_page.dart';
import 'package:mapbox_turn_by_turn/ui/widgets/goto_page_widgets.dart';

class GoTo extends StatefulWidget {
  const GoTo({key}) : super(key: key);

  @override
  State<GoTo> createState() => _GoToState();

  static _GoToState? of(BuildContext context) =>
      context.findAncestorStateOfType<_GoToState>();
}

class _GoToState extends State<GoTo> {
  final fromLocation = LocationTextField(
    displayCurrentLocation: true,
  );
  final toLocation = LocationTextField();
  bool toBuild = false;
  List listOfResponseText = [];
  List listOfResponsePlaceName = [''];
  List listOfLatLng = [];
  LatLng? sourceLatLng;
  LatLng? destinationLatLng;
  bool destinationGiven = false;

  set responseState(SearchApiModel currentResponses) {
    SearchApiModel? responses;
    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      setState(() {
        listOfResponsePlaceName.clear();
        listOfResponseText.clear();
        responses = currentResponses;
        if (responses != null) {
          if (responses?.place1 != null) {
            listOfResponseText.clear();
            listOfResponsePlaceName.clear();
            listOfLatLng.clear();

            listOfResponseText.add(responses!.place1!['text']);
            listOfResponseText.add(responses!.place2!['text']);
            listOfResponseText.add(responses!.place3!['text']);
            listOfResponseText.add(responses!.place4!['text']);
            listOfResponseText.add(responses!.place5!['text']);

            listOfLatLng.add(responses!.place1!['latLng']);
            listOfLatLng.add(responses!.place2!['latLng']);
            listOfLatLng.add(responses!.place3!['latLng']);
            listOfLatLng.add(responses!.place4!['latLng']);
            listOfLatLng.add(responses!.place5!['latLng']);

            listOfResponsePlaceName.add(responses!.place1!['place_name']);
            listOfResponsePlaceName.add(responses!.place2!['place_name']);
            listOfResponsePlaceName.add(responses!.place3!['place_name']);
            listOfResponsePlaceName.add(responses!.place4!['place_name']);
            listOfResponsePlaceName.add(responses!.place5!['place_name']);

            for (var i = 0; i < listOfResponsePlaceName.length; i++) {
              int toRemove = listOfResponseText[i].length;
              listOfResponsePlaceName[i] =
                  listOfResponsePlaceName[i].replaceRange(0, toRemove + 1, '');
            }
          } else if (responses?.errorText != null) {
            listOfResponsePlaceName.add('Not Found');
            listOfResponseText.add(responses!.errorText!['message']);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Go To'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  fromLocation,
                  const SizedBox(
                    height: 10,
                  ),
                  toLocation,
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(height: 300, child: listOfResponses()),
          const SizedBox(
            height: 10,
          ),
          goButton(),
          toBuild
              ? requestResponse(fromLocation.text, toLocation.text)
              : const Text('')
        ],
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

  listOfResponses() {
    return ListView.builder(
      itemCount: listOfResponseText.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/marker.png'),
                    radius: 18,
                    backgroundColor: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Text(
                    '${listOfResponseText[index]}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${listOfResponsePlaceName[index]}'),
                  onTap: () {
                    try {
                      if (fromEnabled != null) {
                        if (fromEnabled!) {
                          fromLocation.settingText =
                              '${listOfResponseText[index]} ${listOfResponsePlaceName[index]}';
                          sharedPreferences.setString(
                              'from', fromLocation.text);
                          sharedPreferences.setDouble(
                              'sourceLat', listOfLatLng[index][1]);
                          sharedPreferences.setDouble(
                              'sourceLng', listOfLatLng[index][0]);

                          sharedPreferences.setString(
                              'sourceAddress', listOfResponseText[index]);

                          sourceGiven = true;
                          sourceLatLng = LatLng(
                              sharedPreferences.getDouble('sourceLat')!,
                              sharedPreferences.getDouble('sourceLng')!);
                        } else {
                          toLocation.settingText = listOfResponseText[index] +
                              listOfResponsePlaceName[index];
                          sharedPreferences.setString('to', toLocation.text);
                          sharedPreferences.setDouble(
                              'destinationLat', listOfLatLng[index][1]);
                          sharedPreferences.setDouble(
                              'destinationLng', listOfLatLng[index][0]);

                          sharedPreferences.setString(
                              'destinationAddress', listOfResponseText[index]);

                          destinationGiven = true;
                          destinationLatLng = LatLng(
                              sharedPreferences.getDouble('destinationLat')!,
                              sharedPreferences.getDouble('destinationLng')!);
                        }
                      }
                    } catch (e) {
                      Utilis.showSnackBar('Please Input Valid Location');
                    }
                  }),
              const Divider(
                thickness: 2,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget goButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            if (fromLocation.text != '' && toLocation.text != '') {
              toBuild = true;
            } else {
              showCustomToast(context, 'Fields cannot be null');
            }
          });
        },
        child: const Text('Directions'));
  }

  Widget requestResponse(String fromLocationText, String toLocationText) {
    if (sourceGiven && destinationGiven) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => onRequestResult(
              directionApiResponse(sourceLatLng ?? MapConstants.defaultlocation,
                  destinationLatLng ?? MapConstants.defaultlocation),
              context),
        );
      });
    } else {
      if (selectLocationNumber < 2) {
        selectLocationNumber += 1;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          showCustomToast(context, 'Select location from list for convenience');
        });
      }
    }

    return Container();
  }

  FutureBuilder onRequestResult(
    Future<Map<String, dynamic>?> directionApiResponse,
    BuildContext context,
  ) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: directionApiResponse,
        builder: (context, directionApiResponse) {
          bool addNavigateTo = false;
          List listOfText = [];

          if (directionApiResponse.data != null && requestError) {
            directionApiResponse.data?.forEach((key, value) {
              listOfText.add(value);
            });
          } else if (directionApiResponse.data != null && !requestError) {
            if (directionApiResponse.data!['code'] == 'Ok') {
              addNavigateTo = true;
              listOfText.add('Fetching directions... ');
            } else {
              listOfText.add(directionApiResponse.data!['0']);
            }
          }

          if (directionApiResponse.hasError) {
            listOfText.add('Input Error');
          }

          Widget navigateTo() {
            Map<String, dynamic>? toBuildDirectionData = {
              'geometry': directionApiResponse.data!['geometry'],
              'duration': directionApiResponse.data!['duration'],
              'distance': directionApiResponse.data!['distance'],
            };
            Timer(
                const Duration(
                  seconds: 3,
                ), () {
              Navigator.of(context).pushNamed('/home');
              BlocProvider.of<MapBloc>(context)
                  .add(DirectionsBloc(directionsData: toBuildDirectionData));
            });

            return const CircularProgressIndicator();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 250),
            child: Card(
              color: requestError ? Colors.red[200] : Colors.green[200],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    listOfText.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: listOfText
                                .map((e) => Text('-${e.toString()}'))
                                .toList())
                        : const Text(''),
                    addNavigateTo
                        ? SizedBox(height: 18, width: 20, child: navigateTo())
                        : const Text(''),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
