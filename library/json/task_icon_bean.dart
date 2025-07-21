import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/json/color_bean.dart';
export 'package:todo_list/json/color_bean.dart';

class TaskIconBean {
  String taskName;
  IconBean iconBean;
  ColorBean colorBean;

  TaskIconBean(
      {required this.taskName,
      required this.iconBean,
      required this.colorBean});

  static TaskIconBean fromMap(Map<String, dynamic> map) {
    return TaskIconBean(
      taskName: map['taskName'] ?? '',
      colorBean: ColorBean.fromMap(map['colorBean']),
      iconBean: IconBean.fromMap(map['iconBean']),
    );
  }

  static List<TaskIconBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<TaskIconBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'taskName': taskName,
      'iconBean': iconBean.toMap(),
      'colorBean': colorBean.toMap()
    };
  }
}

class IconBean {
  int codePoint;
  String fontFamily;
  String fontPackage;
  String iconName;
  bool matchTextDirection;

  IconBean({
    required this.codePoint,
    required this.fontFamily,
    required this.fontPackage,
    required this.iconName,
    required this.matchTextDirection,
  });

  static IconData fromBean(IconBean bean) =>
      IconData(bean.codePoint, fontFamily: bean.fontFamily);

  static IconBean fromMap(Map<String, dynamic> map) {
    return IconBean(
      codePoint: map['codePoint'] is int
          ? map['codePoint']
          : int.parse(map['codePoint'] ?? '0'),
      fontFamily: map['fontFamily'] ?? '',
      fontPackage: map['fontPackage'] ?? '',
      iconName: map['iconName'] ?? '',
      matchTextDirection: map['matchTextDirection'] == 'true',
    );
  }

  static IconBean fromIconData(IconData iconData) {
    return IconBean(
      codePoint: iconData.codePoint,
      fontFamily: iconData.fontFamily ?? '',
      fontPackage: iconData.fontPackage ?? '',
      iconName: '',
      matchTextDirection: iconData.matchTextDirection,
    );
  }

  static List<IconBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<IconBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }

  static Future<List<IconBean>> loadAsset() async {
    String json = await rootBundle.loadString('local_json/icon_json.json');
    return IconBean.fromMapList(jsonDecode(json));
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'codePoint': codePoint.toString(),
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
      'iconName': iconName,
      'matchTextDirection': matchTextDirection.toString()
    };
  }
}
