import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:maps_app/services/services.dart';

import '../../models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  TrafficService trafficService; 


  SearchBloc(
    {
      required this.trafficService,
    }
  ) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>((event, emit) => emit(state.copyWith(displayManualMarker: true)));
    on<OnHideManualMarkerEvent>((event, emit) => emit(state.copyWith(displayManualMarker: false)));
  }


  Future<RouteDestination> getCoordsStartToEnd(LatLng start, LatLng end) async {

    final trafficResponse = await trafficService.getCoordsStartToEnd(start, end);

    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;
    final geometry = trafficResponse.routes[0].geometry;

    // decodificar
    final points = decodePolyline(geometry, accuracyExponent: 6);
    final latLngList = points.map((coors) => LatLng(coors[0].toDouble(), coors[1].toDouble())).toList();


    return RouteDestination(
      points: latLngList,
      distance: distance, 
      duration: duration, 
    );
    
  }


}
