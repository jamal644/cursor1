import 'package:flutter/material.dart';

class ColorBean {
  int red;
  int green;
  int blue;
  double opacity;

  ColorBean(
      {required this.red,
      required this.green,
      required this.blue,
      required this.opacity});

  static Color fromBean(ColorBean bean) =>
      Color.fromRGBO(bean.red, bean.green, bean.blue, bean.opacity);

  static ColorBean fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return ColorBean(red: 0, green: 0, blue: 0, opacity: 1.0);
    }
    return ColorBean(
      red: map['red'] is int ? map['red'] : int.parse(map['red'].toString()),
      green: map['green'] is int
          ? map['green']
          : int.parse(map['green'].toString()),
      blue:
          map['blue'] is int ? map['blue'] : int.parse(map['blue'].toString()),
      opacity: map['opacity'] is double
          ? map['opacity']
          : double.parse(map['opacity'].toString()),
    );
  }

  static ColorBean fromColor(Color color) {
    return ColorBean(
      red: color.red,
      green: color.green,
      blue: color.blue,
      opacity: color.opacity,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'red': red.toString(),
      'green': green.toString(),
      'blue': blue.toString(),
      'opacity': opacity.toString()
    };
  }

  bool equalTo(other) {
    if (other.runtimeType != ColorBean) return false;
    ColorBean bean = other;
    return bean.red == red &&
        bean.green == green &&
        bean.blue == blue &&
        bean.opacity == opacity;
  }
}
