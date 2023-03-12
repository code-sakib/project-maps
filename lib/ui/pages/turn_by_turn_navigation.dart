import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';

class TurnByTurn extends StatefulWidget {
  const TurnByTurn({Key? key}) : super(key: key);

  @override
  State<TurnByTurn> createState() => _TurnByTurnState();
}

class _TurnByTurnState extends State<TurnByTurn> {
  // Waypoints to mark trip start and end
  LatLng source = LatLng(sharedPreferences.getDouble('sourceLat')!,
      sharedPreferences.getDouble('sourceLng')!);
  LatLng destination = LatLng(sharedPreferences.getDouble('destinationLat')!,
      sharedPreferences.getDouble('destinationLng')!);
  late WayPoint sourceWaypoint, destinationWaypoint;
  List<WayPoint> wayPoints = <WayPoint>[];

  // Config variables for Mapbox Navigation
  late MapBoxNavigation directions;
  late MapBoxOptions _options;
  late double distanceRemaining, durationRemaining;
  late MapBoxNavigationViewController _controller;
  final bool isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    if (!mounted) return;

    // Setup directions and options
    directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);
    _options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        isOptimized: true,
        units: VoiceUnits.metric,
        language: "en");

    // Configure waypoints
    sourceWaypoint = WayPoint(
        name: "Source", latitude: source.latitude, longitude: source.longitude);
    destinationWaypoint = WayPoint(
        name: "Destination",
        latitude: destination.latitude,
        longitude: destination.longitude);
    wayPoints.add(sourceWaypoint);
    wayPoints.add(destinationWaypoint);

    // Start the trip
    await directions.startNavigation(wayPoints: wayPoints, options: _options);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Navigation'),
      ),
    );
  }

  Future<void> _onRouteEvent(e) async {
    try {
      {
        distanceRemaining = await directions.distanceRemaining;
        durationRemaining = await directions.durationRemaining;
      }
    } catch (e) {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    try {
      switch (e.eventType) {
        case MapBoxEvent.progress_change:
          var progressEvent = e.data as RouteProgressEvent;
          arrived = progressEvent.arrived!;
          if (progressEvent.currentStepInstruction != null) {
            instruction = progressEvent.currentStepInstruction!;
          }
          break;
        case MapBoxEvent.route_building:
        case MapBoxEvent.route_built:
          routeBuilt = true;
          break;
        case MapBoxEvent.route_build_failed:
          routeBuilt = false;
          break;
        case MapBoxEvent.navigation_running:
          isNavigating = true;
          break;
        case MapBoxEvent.on_arrival:
          arrived = true;
          if (!isMultipleStop) {
            await Future.delayed(const Duration(seconds: 3));
            await _controller.finishNavigation();
          } else {}
          break;
        case MapBoxEvent.navigation_finished:
          routeBuilt = false;
          isNavigating = false;
          Navigator.of(context).pushReplacementNamed('/home');
          break;
        case MapBoxEvent.navigation_cancelled:
          routeBuilt = false;
          isNavigating = false;

          break;
        default:
          break;
      }
    } catch (e) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
