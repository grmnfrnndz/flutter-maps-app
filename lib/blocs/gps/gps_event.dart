part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}


class GpsPermissionEvent extends GpsEvent {

  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  GpsPermissionEvent({
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted}){

      print(this);
    }

  @override
  String toString() => 'GpsPermissionEvent: { isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted}';

}