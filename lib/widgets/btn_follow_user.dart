import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';


class BtnFolllowUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            
            return IconButton(
                  icon: Icon(state.isFollowingUser ? Icons.directions_walk_sharp : Icons.hail_rounded, color: Colors.black,), 
                  onPressed: () {
        
                    mapBloc.add(OnStartFollowingUserEvent());
                    
                  },
            );
          },
        ),
      )
    );
  }
}
