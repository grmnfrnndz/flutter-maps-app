import 'package:flutter/material.dart';

class EndMarker extends CustomPainter {

  final int kilometros;
  final String destination;

  EndMarker({
    required this.kilometros, 
    required this.destination
    });



  @override
  void paint(Canvas canvas, Size size) {
    
    final blackPaint = Paint()
      ..color = Colors.black;

  final whitePaint = Paint()
      ..color = Colors.white;


    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // circulo negro
    canvas.drawCircle(
      Offset(size.width * 0.5 ,size.height - circleBlackRadius),
     circleBlackRadius, 
     blackPaint);

    // circle white
    canvas.drawCircle(
      Offset(size.width * 0.5 ,size.height - circleBlackRadius),
     circleWhiteRadius, 
     whitePaint);


    // Dibujar una caja blanca
    final path = Path();
    path.moveTo(10, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(10, 100);
    

    // sombra
    canvas.drawShadow(path, Colors.black, 10, false);

    // caja
    canvas.drawPath(path, whitePaint);

    // caja negra
    const blackBox = Rect.fromLTWH(10, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    // textos 
    // minutos
    final textSpan = TextSpan(
      style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400)
      , text: '$kilometros'
    );

    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      minWidth: 70,
      maxWidth: 80
    );

    minutesPainter.paint(canvas, const Offset(10, 35));


    // palabra min
    final minutesText = TextSpan(
      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)
      , text: 'Kms'
    );

    final minutesMinPainter = TextPainter(
      text: minutesText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    minutesMinPainter.paint(canvas, const Offset(10, 68));


    // descripcion
    final tempDestino = destination;


    final locationText = TextSpan(
      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w300)
      , text: tempDestino,
    );

    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(
      minWidth: size.width - 95,
      maxWidth: size.width - 95
    );

    final double offsetY = (tempDestino.length > 25) ? 35 : 48;

    locationPainter.paint(canvas, Offset(90, offsetY));



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  
  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;


}