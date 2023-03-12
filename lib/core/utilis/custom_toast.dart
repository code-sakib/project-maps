import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Widget showCustomToast(BuildContext context, String msg,
    [int gravity = 5, int duration = 2]) {
  ToastContext().init(context);
  Toast.show(msg, gravity: gravity, duration: duration);

  return const Text('');
}
