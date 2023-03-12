import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_turn_by_turn/core/constants/maps_constants.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';
import 'package:mapbox_turn_by_turn/core/snack_bar.dart';
import 'package:mapbox_turn_by_turn/data/bloc/map_bloc.dart';
import 'package:mapbox_turn_by_turn/ui/widgets/home_page_widgets.dart';
import 'package:mapbox_turn_by_turn/ui/widgets/ride_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({key}) : super(key: key);
  static bool isStatic = true;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng currentLntLng = getLntLngFromSharedPrefs();
  late CameraPosition initialCameraPosition;
  MapboxMapController? controller;
  bool navigating = false;
  bool addDirections = false;
  Map<String, dynamic>? currentDirectionState;
  bool isStatic = true;
  late Widget showRideBottomSheet;

  onMapCreated(MapboxMapController mapBoxController) async {
    controller = mapBoxController;
  }

  @override
  void initState() {
    super.initState();

    initialCameraPosition = CameraPosition(target: currentLntLng, zoom: 11);
  }

  void onStyleLoadedCallback() async {
    if (addDirections) {
      await controller?.addSymbol(SymbolOptions(
          geometry: LatLng(sharedPreferences.getDouble('destinationLat')!,
              sharedPreferences.getDouble('destinationLng')!),
          iconSize: 0.1,
          iconImage: 'assets/marker.png'));
    } else {
      await controller?.clearSymbols();
      await controller?.removeLayer('lines');
      await controller?.removeSource('fills');
    }

    addDirections
        ? addSourceAndLineLayer(
            LatLng(sharedPreferences.getDouble('destinationLat')!,
                sharedPreferences.getDouble('destinationLng')!),
            true,
            currentDirectionState!['geometry'])
        : null;
  }

  Future<void> addSourceAndLineLayer(
      LatLng newLatLng, bool removeLayer, var geometryCordinates) async {
    //Animating Camera to the new position
    controller?.animateCamera(
      CameraUpdate.newCameraPosition(
          CameraPosition(target: newLatLng, zoom: 5)),
    );

    //Adding polylines
    final myFills = {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'id': 0,
          'properties': <String, dynamic>{},
          'geometry': geometryCordinates
        }
      ]
    };

    //Remove line layer and source if it exists
    if (removeLayer == true) {
      await controller?.removeLayer('lines');
      await controller?.removeSource('fills');
    }

    //Adding new source and layer
    await controller?.addSource(
        'fills', GeojsonSourceProperties(data: myFills));
    await controller?.addLineLayer(
        'fills',
        'lines',
        LineLayerProperties(
            lineColor: Colors.blue.toHexStringRGB(),
            lineCap: 'round',
            lineJoin: 'round',
            lineWidth: 2));
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapEvent>(
      builder: (context, state) {
        if (state is DirectionsBloc) {
          addDirections = true;
          currentDirectionState = state.directionsData;

          showRideBottomSheet = rideBottomSheet(
            context,
            state.directionsData['duration'],
            state.directionsData['distance'],
          );

          initialCameraPosition = CameraPosition(
              target: LatLng(sharedPreferences.getDouble('sourceLat')!,
                  sharedPreferences.getDouble('sourceLng')!));

          if (longPressNumber < 2) {
            longPressNumber += 1;
            Future.delayed(
                const Duration(seconds: 4),
                () => Utilis.showSnackBar(
                    'Longpress "Start Button" => Goto Page'));
          }
        } else {
          addDirections = false;
          onStyleLoadedCallback();
        }

        return Scaffold(
          body: Stack(
            children: [
              MapboxMap(
                accessToken: MapConstants.mapBoxAccessToken,
                initialCameraPosition: initialCameraPosition,
                onMapCreated: onMapCreated,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                onStyleLoadedCallback: onStyleLoadedCallback,
                styleString: currentMap,
              ),
              // searchBar(context),
              typesOfMaps(context, () => setState(() {}), isStatic),
              goToButton(),
              addDirections ? showRideBottomSheet : const Text(''),
            ],
          ),
          bottomNavigationBar: bottomAppBar(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller?.animateCamera(
                  CameraUpdate.newCameraPosition(initialCameraPosition));
            },
            child: const Icon(Icons.my_location_rounded),
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  goToButton() {
    return Positioned(
      bottom: 10,
      right: 15,
      child: FloatingActionButton(
        heroTag: 'goToButton',
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/goto');
        },
        child: const Text('GoTo'),
      ),
    );
  }
}

LatLng getLntLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}

bottomAppBar(BuildContext context) => BottomAppBar(
      notchMargin: 5,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              tooltip: 'Weather',
              onPressed: () => Navigator.of(context).pushNamed('/weather'),
              icon: const Icon(
                Icons.cloud_circle_rounded,
                size: 30,
              )),
          IconButton(
              tooltip: 'Settings',
              onPressed: () => Navigator.of(context).pushNamed('/settings'),
              icon: const Icon(Icons.settings, size: 30)),
        ],
      ),
    );
