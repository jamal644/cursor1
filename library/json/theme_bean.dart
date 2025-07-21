import 'package:todo_list/json/color_bean.dart';
export 'package:todo_list/json/color_bean.dart';

class ThemeBean {
  String themeName;
  ColorBean colorBean;
  String themeType;

  ThemeBean(
      {required this.themeName,
      required this.colorBean,
      required this.themeType});

  static ThemeBean fromMap(Map<String, dynamic> map) {
    return ThemeBean(
      themeName: map['themeName'] ?? '',
      colorBean: ColorBean.fromMap(map['colorBean']),
      themeType: map['themeType'] ?? '',
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'themeName': themeName,
      'colorBean': colorBean.toMap(),
      'themeType': themeType
    };
  }

  @override
  bool operator ==(Object other) {
    return other is ThemeBean && other.themeName == themeName;
  }

  @override
  int get hashCode => themeName.hashCode;
}
