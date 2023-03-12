import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';
import 'package:mapbox_turn_by_turn/data/bloc/map_bloc.dart';

Widget rideBottomSheet(
  BuildContext context,
  duration,
  distance,
) {
  String sourceAddress =
      sharedPreferences.getString('sourceAddress') ?? 'No Location';
  String destinationAddress =
      sharedPreferences.getString('destinationAddress') ?? 'No Location';
  // String objDuration =
  //     _formatDurationInhhMmSs(Duration(seconds: duration.round()));
  // String objDistance = (distance / 1000).toStringAsFixed(1);

  return Positioned(
      bottom: 5,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('$sourceAddress ➡ $destinationAddress',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.indigo)),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<MapBloc>(context).add(InitialMap());
                          },
                          icon: const Icon(Icons.cancel_rounded))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      tileColor: Colors.grey[200],
                      leading: const Image(
                          image: AssetImage('assets/marker.png'),
                          height: 35,
                          width: 35),
                      title: const Text('Car',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  ElevatedButton(
                      onLongPress: () =>
                          Navigator.of(context).pushNamed('/goto'),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/navigate'),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Start your ride now'),
                          ])),
                ]),
          ),
        ),
      ));
}

// String _formatDurationInhhMmSs(Duration fetchedduration) {
//   final hh = (fetchedduration.inHours).toString().padLeft(2, '0');
//   final mm = (fetchedduration.inMinutes % 60).toString().padLeft(2, '0');
//   final ss = (fetchedduration.inSeconds % 60).toString().padLeft(2, '0');
//   String displayTime = '';
//   if (hh.contains('00')) {
//     displayTime = '$mm.$ss' 'min';
//   } else {
//     displayTime = '$hh.$mm' 'hr';
//   }

//   return displayTime; 
// }
