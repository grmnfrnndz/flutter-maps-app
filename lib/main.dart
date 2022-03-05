import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/pages/pages.dart';
import 'package:maps_app/blocs/blocs.dart';

import 'services/traffic_service.dart';

void main() => runApp(const StateApp());


class StateApp extends StatelessWidget {
  const StateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => GpsBloc(),),
        BlocProvider(create: (BuildContext context) => LocationBloc(),),
        BlocProvider(create: (BuildContext context) => MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context)),),
        BlocProvider(create: (BuildContext context) => SearchBloc(trafficService: TrafficService()),),
      ],
      child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapps App',
      debugShowCheckedModeBanner: false,
      // home: LoadingPage(),
      home: LoadingPage(),
      // home: TestMarkerPage(),
    );
  }
}