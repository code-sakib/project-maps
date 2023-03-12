import 'package:dio/dio.dart';

class WeatherApiRepository {
  final String url;

  const WeatherApiRepository({required this.url});

  static final Dio _dio = Dio();

  Future<Map> get() async {
    Map rawData = {};
    await _dio.get(url).then((response) {
      try {
        if (response.statusCode == 200) {
          rawData = response.data;
        } else {
          rawData = {'Error': 'Unknown Error'};
        }
      } on DioError catch (e) {
        rawData = {'Error': e.message};
      }
    }).catchError((catchError) {
      rawData = {'Error': '$catchError'};
    });
    return rawData;
  }
}
