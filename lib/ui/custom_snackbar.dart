import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {


  CustomSnackBar({Key? key,
    required String message,
    String btnLabel = 'OK',
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onOK
  }): super(
    key: key,
    content: Text(message),
    duration: duration,
    action: SnackBarAction(
      label: btnLabel,
      onPressed: () {
        if (onOK != null) {
          onOK();
        }
      },
    )
    ); 

}
