import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter/painting.dart' as painting;

class NetPicturesPageModel extends ChangeNotifier {
  NetPicturesPageLogic logic;
  BuildContext context;
  GlobalModel globalModel;

  List<PhotoBean> photos = [];
  String loadingErrorText = "";

  LoadingFlag loadingFlag = LoadingFlag.loading;
  RefreshController refreshController = RefreshController(initialRefresh: true);
  CancelToken cancelToken = CancelToken();

  ///用于判断是否被销毁，防止与dio搭配使用报错
  bool isDisposed = false;

  ///表示这个网络图片是用来干嘛的,比如用来设置账号页面的背景、侧滑栏的头部图片
  String useType;

  ///[accountPageModel]是从'我的账号'页面进入时传过来的值
  AccountPageModel accountPageModel;

  ///[taskBean]表示当前背景设置页是为任务卡片设置背景
  TaskBean taskBean;

  void proceed(
      {required String useType,
      required AccountPageModel accountPageModel,
      required TaskBean taskBean}) {
    this.useType = useType;
    this.accountPageModel = accountPageModel;
    this.taskBean = taskBean;
    logic = NetPicturesPageLogic(this);
  }

  void setContext(BuildContext context, GlobalModel globalModel) {}

  @override
  void dispose() {
    isDisposed = true;
    refreshController.dispose();
    if (!cancelToken.isCancelled) cancelToken.cancel();
    painting.imageCache.clear();
    super.dispose();
    debugPrint("NetPicturesPageModel销毁了");
  }

  void refresh() {
    if (!isDisposed) notifyListeners();
  }
}

enum PopItemType {
  local,
  history,
}
