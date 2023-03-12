import 'package:dio/dio.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_turn_by_turn/core/constants/maps_constants.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';

Future<Map<String, dynamic>?> directionsApiRequest(
    {required LatLng cor1,
    required LatLng cor2,
    String navType = 'cycling'}) async {
  const String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  String finalUrl =
      '$baseUrl/$navType/${cor1.longitude}%2C${cor1.latitude}%3B${cor2.longitude}%2C${cor2.latitude}?alternatives=false&geometries=geojson&language=en&overview=simplified&steps=true&access_token=${MapConstants.mapBoxAccessToken}';

  final dio = Dio();
  Map<String, dynamic>? responseData;

  try {
    dio.options.contentType = Headers.jsonContentType;
    Response response = await dio.get(finalUrl);
    responseData = response.data;
    requestError = false;
    return (responseData);
  } on DioError catch (e) {
    //Error handling of direction Api request.
    Map<String, dynamic> mapError = e.response?.data as Map<String, dynamic>;
    requestError = true;
    return mapError;
  }
}

Future<Map<String, dynamic>?> directionApiResponse(
    LatLng cor1, LatLng cor2) async {
  Map<String, dynamic>? directionApiResponseData =
      await directionsApiRequest(cor1: cor1, cor2: cor2);

  if (directionApiResponseData!['code'] == 'Ok') {
    final geometry = directionApiResponseData['routes'][0]['geometry'];
    final duration = directionApiResponseData['routes'][0]['duration'];
    final distance = directionApiResponseData['routes'][0]['distance'];
    final code = directionApiResponseData['code'];

    Map<String, dynamic> modifiedResponse = {
      'geometry': geometry,
      'duration': duration,
      'distance': distance,
      'code': code
    };

    return modifiedResponse;
  } else if (directionApiResponseData['code'] == 'NoRoute') {
    requestError = true;
    final noRouteReponse = {
      '0': 'No Route for this location. Invalid location'
    };

    return noRouteReponse;
  } else if (directionApiResponseData['code'] == 'NoSegment') {
    requestError = true;
    final noSegmentReponse = {
      '0': 'No directions can be drawn because location is too close'
    };

    return noSegmentReponse;
  } else if (directionApiResponseData['code'] == 'Forbidden') {
    requestError = true;

    final forbiddenReponse = {'0': 'Forbidden location to show direction'};

    return forbiddenReponse;
  } else if (directionApiResponseData['code'] == 'ProfileNotFound') {
    requestError = true;
    final profileNotFound = {
      '0': 'Error fetching location. Try other locations'
    };

    return profileNotFound;
  } else if (directionApiResponseData['code'] == 'InvalidInput') {
    requestError = true;
    final invalidInputResponse = {'0': 'Invalid Input'};

    return invalidInputResponse;
  } else {
    requestError = true;
    final elseResponse = {
      '0': 'Something went wrong sorry. Try other locations'
    };

    return elseResponse;
  }
}
