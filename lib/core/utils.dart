import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:to_do_app/core/constants/app_colors.dart';

class Utils {
  static focusFieldChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFocus,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Flushbar(message: message);
    //Fluttertoast.showToast(msg: message);
  }

  static void flushbarErrorMesaage(
    String message,
    Color color,
    BuildContext context,
  ) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        forwardAnimationCurve: Curves.decelerate,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        backgroundColor: color,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(Icons.error, color: Colors.white, size: 28),
      )..show(context),
    );
  }
}
