import 'package:flutter/material.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/json/weather_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class GlobalModel extends ChangeNotifier {
  late GlobalLogic logic;
  late BuildContext context;

  ///GlobalModel可以用来统一管理所有的model，这里只管理了一部分
  late MainPageModel mainPageModel;
  late SearchPageModel searchPageModel;
  late TaskDetailPageModel taskDetailPageModel;

  ///app的名字
  String appName = '一日';

  ///当前的主题颜色数据
  ThemeBean currentThemeBean = ThemeBean(
    themeName: 'pink',
    colorBean: ColorBean.fromColor(MyThemeColor.defaultColor),
    themeType: MyTheme.defaultTheme,
  );

  ///是否开启主页背景渐变
  bool isBgGradient = false;

  ///是否开启主页背景颜色跟随卡片图标颜色
  bool isBgChangeWithCard = false;

  ///是否开启卡片图标颜色跟随主页背景
  bool isCardChangeWithBg = false;

  ///是否开启首页动画
  bool enableSplashAnimation = true;

  ///是否开启主页卡片无限循环滚动
  bool enableInfiniteScroll = false;

  ///是否开启天气
  bool enableWeatherShow = false;

  ///是否开启主页背景为网络图片
  bool enableNetPicBgInMainPage = false;

  ///是否开启自动夜间模式
  bool enableAutoDarkMode = false;

  ///当前自动夜间模式，白天的时间区间,比如：'7/20'
  String autoDarkModeTimeRange = '';

  ///当前主页网络背景图片地址
  String currentMainPageBgUrl = '';

  ///当前位置信息(经纬度)
  String currentPosition = '';

  ///当前天气的json
  late WeatherBean weatherBean;

  ///设置页面，用于控制天气获取的loading加载框
  LoadingController loadingController = LoadingController();

  ///当前语言
  List<String> currentLanguageCode = ['zh', 'CN'];
  String currentLanguage = '中文';
  late Locale currentLocale;

  ///当前导航栏头部背景
  String currentNavHeader = NavHeadType.meteorShower;

  ///导航栏头部选择网络图片时的图片地址
  String currentNetPicUrl = "";

  ///是否进入登录页
  late bool goToLogin;

  GlobalModel() {
    logic = GlobalLogic(this);
  }

  void setContext(BuildContext context) {}

  void setMainPageModel(MainPageModel mainPageModel) {}

  void setSearchPageModel(SearchPageModel searchPageModel) {}

  void setTaskDetailPageModel(TaskDetailPageModel taskDetailPageModel) {}

  @override
  void dispose() {
    super.dispose();
    debugPrint("GlobalModel销毁了");
  }

  void refresh() {
    notifyListeners();
  }
}
