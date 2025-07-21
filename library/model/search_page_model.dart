import 'package:flutter/cupertino.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/logic/search_page_logic.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class SearchPageModel extends ChangeNotifier {
  late BuildContext context;
  late SearchPageLogic logic;
  late GlobalModel _globalModel;

  List<TaskBean> searchTasks = [];
  final TextEditingController textEditingController = TextEditingController();
  bool isSearching = false;
  LoadingFlag loadingFlag = LoadingFlag.idle;
  //当前点击进入详情页的index，方便在详情页里面操作删除、更新等
  int currentTapIndex = 0;
  LoadingController loadingController = LoadingController();

  CancelToken cancelToken = CancelToken();

  SearchPageModel() {
    logic = SearchPageLogic(this);
  }

  void setContext(BuildContext context, GlobalModel globalModel) {
    this.context = context;
    this._globalModel = globalModel;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    if (!cancelToken.isCancelled) cancelToken.cancel();
    super.dispose();
    debugPrint("SearchPageModel销毁了");
  }

  void refresh() {
    notifyListeners();
  }
}
