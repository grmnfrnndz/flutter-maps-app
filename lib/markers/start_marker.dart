import 'package:flutter/material.dart';

class StartMarker extends CustomPainter {

  final int minutes;
  final String destination;

  StartMarker({
    required this.minutes, 
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
      Offset(circleBlackRadius,size.height - circleBlackRadius),
     circleBlackRadius, 
     blackPaint);

    // circle white
    canvas.drawCircle(
      Offset(circleBlackRadius,size.height - circleBlackRadius),
     circleWhiteRadius, 
     whitePaint);


    // Dibujar una caja blanca
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    

    // sombra
    canvas.drawShadow(path, Colors.black, 10, false);

    // caja
    canvas.drawPath(path, whitePaint);

    // caja negra
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    // textos 
    // minutos
    final textSpan = TextSpan(
      style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400)
      , text: '$minutes'
    );

    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    minutesPainter.paint(canvas, const Offset(40, 35));


    // palabra min
    final minutesText = TextSpan(
      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)
      , text: 'Min'
    );

    final minutesMinPainter = TextPainter(
      text: minutesText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    minutesMinPainter.paint(canvas, const Offset(40, 68));


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
      minWidth: size.width - 135,
      maxWidth: size.width - 135
    );

    final double offsetY = (tempDestino.length > 20) ? 35 : 48;

    locationPainter.paint(canvas, Offset(120, offsetY));



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  
  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;


}