import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

toast({required String message, Color? colors}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: colors,
      textColor: Colors.white,
      fontSize: 16.0);
}
