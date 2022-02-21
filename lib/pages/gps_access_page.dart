import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';

class GpsAccessPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: _AccessButton(),
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            // print(state);
            
            return !state.isGpsEnabled 
            ? const _EnableGpsMessage() 
            : const _AccessButton();
          },
        ),
     ),
   );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Debe habilitar el GPS',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Es necesario el acceso al GPS'),
          MaterialButton(
            child: Text('Solicitar Acceso Al GPS', style: TextStyle(color: Colors.white),),
            color: Colors.black,
            shape: const StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: () {

              final gpsBloc = BlocProvider.of<GpsBloc>(context, listen:false);
              // final gpsBloc = context.read<GpsBloc>();

              gpsBloc.askGpsAccess();

            },
          )
        ],
      );
  }
}