import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/themes.dart';

import '../../helpers/helpers.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSuscription;

  MapBloc({
    required this.locationBloc
    }) : super(const MapState()) {
    
  
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    on<OnStopFollowingUserEvent>((event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<UpdateUserPolylinesEvent>(_onPolylinesNewPoint);
    on<OnToggleUserRoute>((event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));
    on<DisplayPolylinesEvent>((event, emit) => emit(state.copyWith(polylines: event.polylines, markers: event.markers)));


    locationStateSuscription = locationBloc.stream.listen((locationState) {

      if(locationState.lastKnowLocation != null) {
        add(UpdateUserPolylinesEvent(userLocations: locationState.myLocationHistory));
      }

      if (!state.isFollowingUser) return;
      if(locationState.lastKnowLocation == null) return;

      moveCamara(locationState.lastKnowLocation!);

    });


  }


  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;

    _mapController!.setMapStyle(jsonEncode(uberMapTheme));

    emit(state.copyWith(isMapInitialized: true));
  }

  void moveCamara(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }


  void _onStartFollowingUser(OnStartFollowingUserEvent event, Emitter<MapState> emit) {

    emit(state.copyWith(isFollowingUser: true));
    
    if(locationBloc.state.lastKnowLocation == null) return;

    moveCamara(locationBloc.state.lastKnowLocation!);

  }

  void _onPolylinesNewPoint(UpdateUserPolylinesEvent event, Emitter<MapState> emit) {

    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));

  }

  Future drawRoutePolyline(RouteDestination destination ) async {

    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.grey,
      width: 4,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );


    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    double tripDuration = (destination.duration / 60).floorToDouble();


    // custom markers
    // final iconStartMarker = await getAssetImagenMarker();
    // final iconEndMarker = await getNetworkImageMarker();

    // marker from widgets
    final iconStartMarker = await getStartCustomMarker(tripDuration.toInt(), 'Mi origen');
    final iconEndMarker = await getEndCustomMarker(kms.toInt(), destination.endPlace.placeName);



    final markerIdStart = const MarkerId('start');
    final startMarker = Marker(
      markerId: markerIdStart,
      position: destination.points.first,
      anchor: const Offset(0, 0.8),
      icon: iconStartMarker,
      infoWindow: InfoWindow(
        title: 'Inicio',
        snippet: 'Kms: $kms, duration: $tripDuration'
      )

    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: iconEndMarker,
      
      infoWindow: InfoWindow(
        title: destination.endPlace.text,
        snippet: destination.endPlace.placeName,
      )
    );


  // se crea una copia
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;


    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;


    add(DisplayPolylinesEvent(currentPolylines, currentMarkers));

    await Future.delayed(const Duration(milliseconds: 300));
    _mapController?.showMarkerInfoWindow(markerIdStart);
  }

  @override
  Future<void> close() {
    _mapController?.dispose();
    locationStateSuscription?.cancel();
    return super.close();
  }

}
