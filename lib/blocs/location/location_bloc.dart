import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:bloc/bloc.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {


  StreamSubscription? positionStream;

  LocationBloc() : super(const LocationState()) {


    on<OnStartFollowinfUser>((event, emit) => emit(state.copyWith(followingUser: true)));
    on<OnStopFollowinfUser>((event, emit) => emit(state.copyWith(followingUser: false)));

    on<OnNewUserLocationEvent>((event, emit) {
      // la variable state existe dentro de todo el bloc
      emit(
        state.copyWith(
          lastKnowLocation: event.newLocation, 
          myLocationHistory: [...state.myLocationHistory, event.newLocation])
      );

    });
  }

  Future<LatLng> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    final position_x = LatLng(position.latitude, position.longitude);

    add(OnNewUserLocationEvent(position_x));
    // TODO: retornar un objeto de tipo LatLng

    return position_x;
  }

  void startFollowingUser(){
    add(OnStartFollowinfUser());
    
    print('startFollowingUser');
      positionStream = Geolocator.getPositionStream().listen((event) { 
        final position = event;
        add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
      });
  }

  void stopFollowingUser(){
    add(OnStopFollowinfUser());
    
    positionStream?.cancel();
    print('stopFollowingUser');
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
