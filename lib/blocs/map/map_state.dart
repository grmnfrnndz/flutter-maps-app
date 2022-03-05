part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;

  //polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  /*
  'mi_ruta': {
    id: polylineID Google,
    points: [[lat, lng], [123,123], [2332,2323]]
    width: 3
    color: color
  }
   */


  const MapState({
    this.showMyRoute = true,
    this.isMapInitialized = false, 
    this.isFollowingUser = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers
    }): polylines = polylines ?? const {}, markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    bool? showMyRoute
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    showMyRoute: showMyRoute ?? this.showMyRoute,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers
  );


  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, polylines, showMyRoute, markers];
}
