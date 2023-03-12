import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_turn_by_turn/core/constants/maps_constants.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';

Future<void> initialLocationAndSave() async {
  LatLng currentLocation = MapConstants.defaultlocation;

  try {
    bool? serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await sharedPreferences.setDouble('latitude', currentLocation.latitude);
      await sharedPreferences.setDouble('longitude', currentLocation.longitude);
      return;
    }

    LocationPermission? permissionStatus = await Geolocator.checkPermission();
    if (permissionStatus == LocationPermission.denied) {
      permissionStatus = await Geolocator.requestPermission();
      if (permissionStatus == LocationPermission.denied) {
        await sharedPreferences.setDouble('latitude', currentLocation.latitude);
        await sharedPreferences.setDouble(
            'longitude', currentLocation.longitude);
        return;
      }
    }

    if (permissionStatus == LocationPermission.deniedForever) {
      await sharedPreferences.setDouble('latitude', currentLocation.latitude);
      await sharedPreferences.setDouble('longitude', currentLocation.longitude);
      return;
    }
  } catch (e) {
    await sharedPreferences.setDouble('latitude', currentLocation.latitude);
    await sharedPreferences.setDouble('longitude', currentLocation.longitude);
    return;
  }
  deviceLocationPermission.value = true;

  currentLocation = await Geolocator.getCurrentPosition()
      .then((location) => LatLng(location.latitude, location.longitude));

  await sharedPreferences.setDouble('latitude', currentLocation.latitude);
  await sharedPreferences.setDouble('longitude', currentLocation.longitude);
  await userAddressFromLatLng(
    LatLng(sharedPreferences.getDouble('latitude')!,
        sharedPreferences.getDouble('longitude')!),
  );
}

Future<void> userAddressFromLatLng(LatLng latLng) async {
  const String baseUrl = MapConstants.searchApiRequestBaseUrl;
  String query = '${latLng.longitude},${latLng.latitude}';
  String finalUrl =
      '$baseUrl$query.json?access_token=${MapConstants.mapBoxAccessToken}&=';
  String responseDataAddress = 'No Value';

  Dio dio = Dio();

  Future<Response> response = dio.get(finalUrl);

  try {
    await response.then((responseData) {
      if (responseData.data['features'] == []) {
        responseDataAddress = 'Error Fetching Address.';
      } else {
        responseDataAddress = responseData.data['features'][0]['place_name'];
      }
    });
  } catch (e) {
    responseDataAddress = 'Error Fetching Address.';
  }
  sharedPreferences.setString('userAddress', responseDataAddress);
}
