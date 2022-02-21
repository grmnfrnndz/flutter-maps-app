import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/views.dart';
import 'package:maps_app/widgets/widgets.dart';


class MapsPage extends StatefulWidget {

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {

  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context, listen: false);
    locationBloc.startFollowingUser();

  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: BlocBuilder<LocationBloc, LocationState>(
       builder: (context, state) {

        if (state.lastKnowLocation == null) return const Center(child: Text('Espere por favor...'));

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              MapsView(initialLocation: state.lastKnowLocation!,),
        
              // TODO: implementar botones...
        
            ],
          ),
        );
       },
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     floatingActionButton: Column(
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
          BtnCurrentLocation()
       ],
     ),
   );
  }
}