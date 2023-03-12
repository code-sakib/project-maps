import 'package:dio/dio.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_turn_by_turn/core/constants/maps_constants.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';

Future<SearchApiModel> searchRequests(String query) async {
  Dio dio = Dio();
  const String baseUrl = MapConstants.searchApiRequestBaseUrl;
  LatLng currentLatLng = LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
  String finalUrl =
      '$baseUrl$query.json?proximity=${currentLatLng.longitude}%2C${currentLatLng.latitude}&types=postcode%2Cplace%2Caddress%2Cdistrict&language=en&access_token=${MapConstants.mapBoxAccessToken}';
  Future<Response> response = dio.get(finalUrl);

  try {
    SearchApiModel searchApiModel = await response.then((responseData) {
      if (responseData.statusCode == 200) {
        return SearchApiModel.onSuccess(responseData.data);
      } else {
        return SearchApiModel.onError(responseData.data);
      }
    });
    return searchApiModel;
  } catch (e) {
    return SearchApiModel.onError({"message": 'Error'});
  }
}

class SearchApiModel {
  Map<String, dynamic>? place1;
  Map<String, dynamic>? place2;
  Map<String, dynamic>? place3;
  Map<String, dynamic>? place4;
  Map<String, dynamic>? place5;
  Map<String, String>? errorText;
  SearchApiModel({
    this.place1,
    this.place2,
    this.place3,
    this.place4,
    this.place5,
    this.errorText,
  });

  factory SearchApiModel.onSuccess(Map json) {
    return SearchApiModel(place1: {
      'text': json['features'][0]['text'],
      'place_name': json['features'][0]['place_name'],
      'latLng': json['features'][0]['center']
    }, place2: {
      'text': json['features'][1]['text'],
      'place_name': json['features'][1]['place_name'],
      'latLng': json['features'][1]['center']
    }, place3: {
      'text': json['features'][2]['text'],
      'place_name': json['features'][2]['place_name'],
      'latLng': json['features'][2]['center']
    }, place4: {
      'text': json['features'][3]['text'],
      'place_name': json['features'][3]['place_name'],
      'latLng': json['features'][3]['center']
    }, place5: {
      'text': json['features'][4]['text'],
      'place_name': json['features'][4]['place_name'],
      'latLng': json['features'][4]['center']
    });
  }

  factory SearchApiModel.onError(Map json) {
    return SearchApiModel(errorText: {'message': json.values.first});
  }
}
