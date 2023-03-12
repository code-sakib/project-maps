import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MapEvent {
  const MapEvent();
}

class InitialMap extends MapEvent {}

class DirectionsBloc extends MapEvent {
  const DirectionsBloc({required this.directionsData});
  final Map<String, dynamic> directionsData;
}

class MapBloc extends Bloc<MapEvent, MapEvent> {
  MapBloc() : super(InitialMap()) {
    on<MapEvent>((event, emit) {
      if (event is DirectionsBloc) {
        emit(DirectionsBloc(directionsData: event.directionsData));
      } else {
        emit(InitialMap());
      }
    });
  }
}
