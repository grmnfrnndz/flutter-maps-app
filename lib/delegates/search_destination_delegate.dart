import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

import '../models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  

  SearchDestinationDelegate():super(
    searchFieldLabel: 'Buscar Destino...'
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {

        final result = SearchResult(cancel: true);

        close(context, result);
      });
  }

  @override
  Widget buildResults(BuildContext context) {

    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    searchBloc.getPlacesByQuery(locationBloc.state.lastKnowLocation!, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;

        return ListView.separated(
          itemBuilder: (context, i) {
            final place = places[i];
            return ListTile(
              title: Text('$place.text'),
              subtitle: Text('$place.placeName'),
              leading: const Icon(Icons.place_outlined, color: Colors.black),
              onTap: () {
                print('enviar este lugar $place');

                final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(place.center[1], place.center[0]),
                  name: place.text,
                  description: place.placeName
                );
                
                searchBloc.add(AddToHistory(place));

                close(context, result);
              },
            );
          }, 
          separatorBuilder: (context, i) => const Divider(), 
          itemCount: places.length);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black),
          title: const Text('Colocar la Ubicacion manualmente', style: TextStyle(color: Colors.black)),
          onTap: () {

            final result = SearchResult(cancel: false, manual: true);

            close(context, result);
          },
          ),
          

          ...searchBloc.state.history.map((place) => ListTile(
            title: Text('$place.text'),
              subtitle: Text('$place.placeName'),
              leading: const Icon(Icons.history_outlined, color: Colors.black),
              onTap: () {

                final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(place.center[1], place.center[0]),
                  name: place.text,
                  description: place.placeName
                );
                
                close(context, result);
              },
            )
          ).toList()
          ,

      ],
    );
  }



}