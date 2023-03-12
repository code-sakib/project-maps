import 'package:mapbox_gl/mapbox_gl.dart';

class MapConstants {
  static const String mapBoxAccessToken =
      'pk.eyJ1Ijoic2FraWJtYXBzIiwiYSI6ImNsZGtnODhkNDBrZzYzb2xnOXZqMGp2MjQifQ.bsOkN3nPZ0A-EsOGKqpaCQ';

  static const String mapBoxStyleId =
      'https://api.mapbox.com/styles/v1/sakibmaps/clct3j2ad001714o2wfgjrbyf/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2FraWJtYXBzIiwiYSI6ImNsY3JoY25nYjBmeGozcHF2OHR1enlwNjkifQ.6XLpH7l82lEIV3Uhr4-X_A';

  static LatLng defaultlocation = const LatLng(18.9294, 72.8310);

  static const String searchApiRequestBaseUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/';
}
