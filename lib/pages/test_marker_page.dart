import 'package:flutter/material.dart';

import '../markers/markers.dart';


class TestMarkerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // color: Colors.red,
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: EndMarker(
              destination: 'Mi Casa fdsf fsdfsf fdsfdfs',
              kilometros: 86
            ),
          ),
        ),
     ),
   );
  }
}