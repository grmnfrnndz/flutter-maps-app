part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final bool followingUser;

  const MapState({
    this.isMapInitialized = false, 
    this.followingUser = false});

  MapState copyWith({
    bool? isMapInitialized,
    bool? followingUser
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    followingUser: followingUser ?? this.followingUser
  );


  @override
  List<Object> get props => [isMapInitialized, followingUser];
}
