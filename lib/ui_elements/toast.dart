import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:myflutterapp/constants/ui_values.dart';

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: const Color(UiValues.wuwerBlue),
      fontSize: 22.0);
}