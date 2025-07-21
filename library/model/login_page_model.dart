import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class LoginPageModel extends ChangeNotifier {
  late BuildContext context;
  late bool isFirst;
  late LoginPageLogic logic;

  String currentAnimation = "move";
  bool showLoginWidget = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailOk = false;
  bool isPasswordOk = false;
  bool isLoginNow = false;

  ///表示登录页面是不是第一个页面
  final formKey = GlobalKey<FormState>();

  CancelToken cancelToken = CancelToken();

  LoadingController loadingController = LoadingController();

  LoginPageModel({bool isFirst = false}) {
    logic = LoginPageLogic(this);
    this.isFirst = isFirst;
  }

  void setContext(BuildContext context) {}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cancelToken.cancel();
    super.dispose();
    debugPrint("LoginPageModel销毁了");
  }

  void refresh() {
    notifyListeners();
  }
}
