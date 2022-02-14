import 'dart:async';

import 'package:geolocator/geolocator.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscription;

  GpsBloc() : super(GpsState(isGpsEnabled: false, isGpsPermissionGranted: false)) {
    
    on<GpsPermissionEvent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted
      ))
    );

    _init();
  }



  Future<void> _init() async {
    
    // llamada secuencial de Future
    // final isEnabled = await _checkGpsStatus();
    // final isGRanted = await _isPermisionGranted();
    // print('isEnabled: $isEnabled, isGRanted: $isGRanted');

    // llamada simultanea de Future
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermisionGranted()
    ]);


    add(GpsPermissionEvent(
      isGpsEnabled: gpsInitStatus[0], 
      isGpsPermissionGranted: gpsInitStatus[1])
      );


  }

  Future<bool> _isPermisionGranted() async {
    final isGranted = await Permission.location.isGranted;

    return isGranted;
  }


  Future<bool> _checkGpsStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();

    // listener que esta escuchando cualquier cambio del GPS
    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      add(GpsPermissionEvent(
          isGpsEnabled: isEnabled, 
          isGpsPermissionGranted: state.isGpsPermissionGranted)
        );
     });

    return isEnabled;
  }


  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsPermissionEvent(
          isGpsEnabled: state.isGpsEnabled, 
          isGpsPermissionGranted: true)
        );
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsPermissionEvent(
          isGpsEnabled: state.isGpsEnabled, 
          isGpsPermissionGranted: false)
        );
        openAppSettings();
        break;
    }

  }




  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }


}
