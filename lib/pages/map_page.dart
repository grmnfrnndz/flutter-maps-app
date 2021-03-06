import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
       builder: (context, locationState) {

        if (locationState.lastKnowLocation == null) return const Center(child: Text('Espere por favor...'));

        return BlocBuilder<MapBloc, MapState>(
          builder: (context, mapState) {

            Map<String, Polyline> polylines = Map.from(mapState.polylines);
            Map<String, Marker> markers = Map.from(mapState.markers);
            if (!mapState.showMyRoute) {
              polylines.removeWhere((key, value) => key == 'myRoute');
              markers.removeWhere((key, value) => key == 'start');
            }

            return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Stack(
                    children: [
                      MapsView(initialLocation: locationState.lastKnowLocation!,
                        polylines: polylines.values.toSet(),
                        markers: markers.values.toSet(),
                        ),
                
                      // TODO: implementar botones...
                      const SearchBar(),
                      ManualMarker(),
                    ],
                  ),
                );
          },
        );
       },
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     floatingActionButton: Column(
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
          BtnToggleUserRoute(),
          BtnFolllowUser(),
          BtnCurrentLocation(),
       ],
     ),
   );
  }
}