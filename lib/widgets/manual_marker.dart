import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

import '../helpers/helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        
        if(state.displayManualMarker) {
          return _ManualMarkerBody();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}


class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [

          Positioned(
            top: 40,
            left: 20,
            child: _BtnBack(),
          ),

          Center(
            child: Transform.translate(
              offset: Offset(0, -20),
              child: BounceInDown(
                from: 100,
                child: Icon(Icons.location_on_rounded, size: 50,)),
            ),
          ),


          // Boton de confirmar
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: Duration(milliseconds: 300),
              child: MaterialButton(
                color: Colors.black,
                minWidth: size.width - 120,
                elevation: 0,
                height: 50,
                shape: StadiumBorder(),
                onPressed: () async {
                  final start = locationBloc.state.lastKnowLocation;
                  if (start == null) return;

                  final end = mapBloc.mapCenter;
                
                  if (end == null) return;

                  showLoadingMessage(context);

                  final routeDestination = await searchBloc.getCoordsStartToEnd(start, end);
                  await mapBloc.drawRoutePolyline(routeDestination);
                  searchBloc.add(OnHideManualMarkerEvent());

                  Navigator.pop(context);

                },
                child: const Text('Confirmar Destino', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
              ),
            ),
          )


        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
    
            // TODO: Cancelar el marcador manual
            searchBloc.add(OnHideManualMarkerEvent());
    
          },
        ),
      ),
    );
  }
}


