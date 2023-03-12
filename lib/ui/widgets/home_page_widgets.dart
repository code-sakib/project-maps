import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

Map typesOfMapsMap = {
  'static': 'assets/static_img.jpg',
  'terrain': 'assets/terrain_view.png',
  'satellite': 'assets/satellite_img.jpg'
};

String currentMap = MapboxStyles.MAPBOX_STREETS;

Positioned typesOfMaps(BuildContext context, Function() onTap, bool isStatic) {
  return Positioned(
      top: 80,
      right: 10,
      child: IconButton(
          onPressed: () {
            showBottomSheet(
              backgroundColor: Colors.grey[200],
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              builder: (context) {
                List namesOfMap = [];
                typesOfMapsMap.forEach((key, value) {
                  namesOfMap.add(key);
                });
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 200,
                    width: double.maxFinite,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (namesOfMap[index] == 'satellite') {
                                currentMap = MapboxStyles.SATELLITE_STREETS;
                              } else if (namesOfMap[index] == 'terrain') {
                                currentMap = MapboxStyles.OUTDOORS;
                              } else {
                                currentMap = MapboxStyles.MAPBOX_STREETS;
                              }
                              onTap();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        '${typesOfMapsMap[namesOfMap[index]]}',
                                        height: 90,
                                        width: 90,
                                      ),
                                    ),
                                    Text(
                                      '${namesOfMap[index]}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.filter_none_rounded)));
}

// FlutterMap flutterMap(String state) {
//   return FlutterMap(
//     options:
//         MapOptions(minZoom: 5, maxZoom: 18, center: MapConstants.myLocation),
//     children: [
//       TileLayer(
//         urlTemplate: state,
//         additionalOptions: const {
//           'mapStyleId': MapsApi.mapBoxStyleId,
//           'accessToken': MapsApi.mapBoxAccessToken,
//         },
//       ),
//       // FutureBuilder(
//       //     future: getUsersCurrentLocation(),
//       //     builder: (context, location) {
//       //       return MarkerLayer(
//       //         markers: [
//       //           Marker(
//       //               point: location.data ?? MapConstants.myLocation,
//       //               builder: (context) {
//       //                 return Image.asset('assets/marker.png');
//       //               })
//       //         ],
//       //       );
//       //     })
//     ],
//   );
// }
