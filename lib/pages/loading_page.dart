import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/pages/gps_access_page.dart';
import 'package:maps_app/pages/map_page.dart';

import '../blocs/blocs.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted 
          ? MapsPage()
          : GpsAccessPage();
        },
    ));
      
  }
}