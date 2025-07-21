import 'package:flutter/material.dart';

class FullScreenDialog {
  static final FullScreenDialog _instance = FullScreenDialog._internal();

  static FullScreenDialog getInstance() {
    return _instance;
  }

  FullScreenDialog._internal();

  void showDialog(BuildContext context, Widget child) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (ctx, anm1, anm2) {
          return child;
        }));
  }
}
