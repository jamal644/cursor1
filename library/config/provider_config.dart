import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/pages/all_page.dart';

class ProviderConfig {
  static final ProviderConfig _instance = ProviderConfig._internal();

  static ProviderConfig getInstance() {
    return _instance;
  }

  ProviderConfig._internal();

  ///全局provider
  ChangeNotifierProvider<GlobalModel> getGlobal(Widget child) {
    return ChangeNotifierProvider<GlobalModel>(
      create: (context) => GlobalModel(),
      child: child,
    );
  }

  ///主页provider
  ChangeNotifierProvider<MainPageModel> getMainPage() {
    return ChangeNotifierProvider<MainPageModel>(
      create: (context) => MainPageModel(),
      child: MainPage(),
    );
  }

  ///任务详情页provider
  ChangeNotifierProvider<TaskDetailPageModel> getTaskDetailPage(
    int index,
    TaskBean taskBean, {
    DoneTaskPageModel? doneTaskPageModel,
    SearchPageModel? searchPageModel,
  }) {
    return ChangeNotifierProvider<TaskDetailPageModel>(
      create: (context) => TaskDetailPageModel(
        taskBean,
        doneTaskPageModel: doneTaskPageModel ?? DoneTaskPageModel(),
        searchPageModel: searchPageModel ?? SearchPageModel(),
        heroTag: index,
      ),
      child: TaskDetailPage(),
    );
  }

  ///任务编辑页provider
  ChangeNotifierProvider<EditTaskPageModel> getEditTaskPage(
      TaskIconBean taskIcon,
      {TaskDetailPageModel? taskDetailPageModel,
      TaskBean? taskBean}) {
    return ChangeNotifierProvider<EditTaskPageModel>(
      create: (context) => EditTaskPageModel(
          oldTaskBean: taskBean ??
              TaskBean(
                  taskIconBean: taskIcon,
                  textColor:
                      ColorBean(red: 0, green: 0, blue: 0, opacity: 1.0))),
      child: EditTaskPage(
        taskIcon,
        taskDetailPageModel: taskDetailPageModel ??
            TaskDetailPageModel(
                TaskBean(
                    taskIconBean: taskIcon,
                    textColor:
                        ColorBean(red: 0, green: 0, blue: 0, opacity: 1.0)),
                doneTaskPageModel: DoneTaskPageModel(),
                searchPageModel: SearchPageModel(),
                heroTag: 0),
      ),
    );
  }

  ///图标设置页provider
  ChangeNotifierProvider<IconSettingPageModel> getIconSettingPage() {
    return ChangeNotifierProvider<IconSettingPageModel>(
      create: (context) => IconSettingPageModel(),
      child: IconSettingPage(),
    );
  }

  ///主题设置页provider
  ChangeNotifierProvider<ThemePageModel> getThemePage() {
    return ChangeNotifierProvider<ThemePageModel>(
      create: (context) => ThemePageModel(),
      child: ThemePage(),
    );
  }

  ///头像裁剪页provider
  ChangeNotifierProvider<AvatarPageModel> getAvatarPage(
      {MainPageModel? mainPageModel}) {
    return ChangeNotifierProvider<AvatarPageModel>(
      create: (context) => AvatarPageModel(),
      child: AvatarPage(
        mainPageModel: mainPageModel ?? MainPageModel(),
      ),
    );
  }

  ///完成列表页provider
  ChangeNotifierProvider<DoneTaskPageModel> getDoneTaskPage() {
    return ChangeNotifierProvider<DoneTaskPageModel>(
      create: (context) => DoneTaskPageModel(),
      child: DoneTaskPage(),
    );
  }

  ///搜索任务页provider
  ChangeNotifierProvider<SearchPageModel> getSearchPage() {
    return ChangeNotifierProvider<SearchPageModel>(
      create: (context) => SearchPageModel(),
      child: SearchPage(),
    );
  }

  ///意见反馈页provider
  ChangeNotifierProvider<FeedbackPageModel> getFeedbackPage(
      FeedbackWallPageModel feedbackWallPageModel) {
    return ChangeNotifierProvider<FeedbackPageModel>(
      create: (context) => FeedbackPageModel(),
      child: FeedbackPage(feedbackWallPageModel),
    );
  }

  ///意见反馈墙页provider
  ChangeNotifierProvider<FeedbackWallPageModel> getFeedbackWallPage() {
    return ChangeNotifierProvider<FeedbackWallPageModel>(
      create: (context) => FeedbackWallPageModel(),
      child: FeedbackWallPage(),
    );
  }

  ///登录页provider
  ChangeNotifierProvider<LoginPageModel> getLoginPage({bool isFirst = false}) {
    return ChangeNotifierProvider<LoginPageModel>(
      create: (context) => LoginPageModel(isFirst: isFirst),
      child: LoginPage(),
    );
  }

  ///注册页provider
  ChangeNotifierProvider<RegisterPageModel> getRegisterPage() {
    return ChangeNotifierProvider<RegisterPageModel>(
      create: (context) => RegisterPageModel(),
      child: RegisterPage(),
    );
  }

  ///重设密码页provider,可以设重设密码，也可以设是记密码
  ChangeNotifierProvider<ResetPasswordPageModel> getResetPasswordPage(
      {bool isReset = true}) {
    return ChangeNotifierProvider<ResetPasswordPageModel>(
      create: (context) => ResetPasswordPageModel(isReset),
      child: ResetPasswordPage(),
    );
  }

  ///网络图片页provider，用于设置账号页面的背景，或者侧滑栏的头部,或者主页背景
  ChangeNotifierProvider<NetPicturesPageModel> getNetPicturesPage(
      {required String useType,
      AccountPageModel? accountPageModel,
      TaskBean? taskBean}) {
    return ChangeNotifierProvider<NetPicturesPageModel>(
      create: (context) {
        final model = NetPicturesPageModel();
        model.proceed(
          useType: useType,
          accountPageModel: accountPageModel ?? AccountPageModel(),
          taskBean: taskBean ??
              TaskBean(
                  taskIconBean: TaskIconBean(
                      taskName: '',
                      iconBean: IconBean(
                          codePoint: 0,
                          fontFamily: '',
                          fontPackage: '',
                          iconName: '',
                          matchTextDirection: false),
                      colorBean:
                          ColorBean(red: 0, green: 0, blue: 0, opacity: 1.0)),
                  textColor:
                      ColorBean(red: 0, green: 0, blue: 0, opacity: 1.0)),
        );
        return model;
      },
      child: NetPicturesPage(),
    );
  }

  ///账号页面的provider
  ChangeNotifierProvider<AccountPageModel> getAccountPage() {
    return ChangeNotifierProvider<AccountPageModel>(
      create: (context) => AccountPageModel(),
      child: AccountPage(),
    );
  }
}
