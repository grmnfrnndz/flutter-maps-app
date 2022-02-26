import 'package:flutter/material.dart';

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
        // TODO: se debe retornar algo no null


        final result = SearchResult(cancel: true);

        close(context, result);
      });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black),
          title: const Text('Colocar la Ubicacion manualmente', style: TextStyle(color: Colors.black)),
          onTap: () {
            // TODO: regresar algo

            final result = SearchResult(cancel: false, manual: true);

            close(context, result);
          },
          ),
          
      ],
    );
  }



}