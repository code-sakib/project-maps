import 'package:mapbox_gl/mapbox_gl.dart';

class MapConstants {
  static const String mapBoxAccessToken =
      'pk';

  static const String mapBoxStyleId =
      'https://api.mapbox.com/styles/v1/sakibmaps/clct3j2ad001714o2wfgjrbyf/tiles/256/{z}/{x}/{y}@2x?access_token=pk';

  static LatLng defaultlocation = const LatLng(18.9294, 72.8310);

  static const String searchApiRequestBaseUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/';
}
