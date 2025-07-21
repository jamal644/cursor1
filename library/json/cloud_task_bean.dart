import 'package:todo_list/json/task_bean.dart';

class CloudTaskBean {
  /*
   * description : "获取日记列表成功"
   * status : 0
   * taskList : [{...}]
   */

  String description = '';
  int status = 0;
  List<TaskBean> taskList = [];

  static CloudTaskBean fromMap(Map<String, dynamic> map) {
    CloudTaskBean cloudTaskBean = new CloudTaskBean();
    cloudTaskBean.description = map['description'] ?? '';
    cloudTaskBean.status = map['status'] ?? 0;
    cloudTaskBean.taskList = TaskBean.fromNetMapList(map['taskList']);
    return cloudTaskBean;
  }

  static List<CloudTaskBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<CloudTaskBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }
}
