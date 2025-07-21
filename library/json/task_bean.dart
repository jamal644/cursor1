import 'dart:convert';

import 'package:todo_list/json/task_icon_bean.dart';

//单个任务的json数据
class TaskBean {
  late int id;
  String taskName;
  String taskType;
  String account;
  int taskStatus;
  int taskDetailNum;
  double overallProgress;

  ///存放在云端后拿到的云数据库Id,若[cloudId]为空，表示尚未上传到云端
  String uniqueId;

  ///是否需要在云端更新,true or false
  String needUpdateToCloud;

  ///任务修改次数
  int changeTimes;

  ///创建任务的时间
  String createDate;

  ///任务完成的时间
  String finishDate;

  ///用户设置的任务开始时间
  String startDate;

  ///用户设置的任务结束时间
  String deadLine;

  ///当前任务的图标信息
  TaskIconBean taskIconBean;
  List<TaskDetailBean> detailList;

  ///以下内容，只存储在本地数据库内。

  ///当前字体颜色
  ColorBean textColor;

  ///当前卡片背景图片地址
  String backgroundUrl;

  TaskBean({
    this.taskName = "",
    this.taskType = "",
    this.taskStatus = TaskStatus.todo,
    this.taskDetailNum = 0,
    this.overallProgress = 0.0,
    this.uniqueId = "",
    this.needUpdateToCloud = 'true',
    this.changeTimes = 0,
    this.createDate = "",
    this.finishDate = "",
    this.account = "default",
    this.startDate = "",
    this.deadLine = "",
    required this.taskIconBean,
    List<TaskDetailBean>? detailList,
    required this.textColor,
    this.backgroundUrl = "",
  }) : detailList = detailList ?? <TaskDetailBean>[];

  static TaskBean fromMap(Map<String, dynamic> map) {
    return TaskBean(
      taskName: map['taskName'] ?? '',
      taskType: map['taskType'] ?? '',
      taskDetailNum: map['taskDetailNum'] ?? 0,
      taskStatus: map['taskStatus'] ?? TaskStatus.todo,
      account: map['account'] ?? 'default',
      uniqueId: map['uniqueId'] ?? '',
      needUpdateToCloud: map['needUpdateToCloud'] ?? 'false',
      changeTimes: map['changeTimes'] ?? 0,
      overallProgress: map['overallProgress'] != null
          ? double.parse(map['overallProgress'].toString())
          : 0.0,
      createDate: map['createDate'] ?? '',
      finishDate: map['finishDate'] ?? '',
      startDate: map['startDate'] ?? '',
      deadLine: map['deadLine'] ?? '',
      taskIconBean: map['taskIconBean'] != null
          ? (map['taskIconBean'] is String
              ? TaskIconBean.fromMap(jsonDecode(map['taskIconBean']))
              : TaskIconBean.fromMap(map['taskIconBean']))
          : TaskIconBean(
              taskName: '',
              iconBean: IconBean(
                  codePoint: 0,
                  fontFamily: '',
                  fontPackage: '',
                  iconName: '',
                  matchTextDirection: false),
              colorBean: ColorBean(red: 0, green: 0, blue: 0, opacity: 1.0)),
      detailList: map['detailList'] != null
          ? (map['detailList'] is String
              ? TaskDetailBean.fromMapList(jsonDecode(map['detailList']))
              : TaskDetailBean.fromMapList(map['detailList']))
          : <TaskDetailBean>[],
      textColor: map['textColor'] != null
          ? (map['textColor'] is String
              ? ColorBean.fromMap(jsonDecode(map['textColor']))
              : ColorBean.fromMap(map['textColor']))
          : ColorBean(red: 0, green: 0, blue: 0, opacity: 1.0),
      backgroundUrl: map['backgroundUrl'] ?? '',
    );
  }

  static TaskBean fromNetMap(Map<String, dynamic> map) {
    return TaskBean(
      taskName: map['taskName'] ?? '',
      taskType: map['taskType'] ?? '',
      taskDetailNum: int.tryParse(map['taskDetailNum']?.toString() ?? '0') ?? 0,
      taskStatus:
          int.tryParse(map['taskStatus']?.toString() ?? '0') ?? TaskStatus.todo,
      account: map['account'] ?? 'default',
      uniqueId: map['uniqueId'] ?? '',
      needUpdateToCloud: map['needUpdateToCloud'] ?? 'false',
      changeTimes: int.tryParse(map['changeTimes']?.toString() ?? '0') ?? 0,
      overallProgress: map['overallProgress'] != null
          ? double.parse(map['overallProgress'].toString())
          : 0.0,
      createDate: map['createDate'] ?? '',
      finishDate: map['finishDate'] ?? '',
      startDate: map['startDate'] ?? '',
      deadLine: map['deadLine'] ?? '',
      taskIconBean: map['taskIconBean'] != null
          ? (map['taskIconBean'] is String
              ? TaskIconBean.fromMap(jsonDecode(map['taskIconBean']))
              : TaskIconBean.fromMap(map['taskIconBean']))
          : TaskIconBean(
              taskName: '',
              iconBean: IconBean(
                  codePoint: 0,
                  fontFamily: '',
                  fontPackage: '',
                  iconName: '',
                  matchTextDirection: false),
              colorBean: ColorBean(red: 0, green: 0, blue: 0, opacity: 1.0)),
      detailList: map['detailList'] != null
          ? (map['detailList'] is String
              ? TaskDetailBean.fromMapList(jsonDecode(map['detailList']))
              : TaskDetailBean.fromMapList(map['detailList']))
          : <TaskDetailBean>[],
      textColor: ColorBean(red: 0, green: 0, blue: 0, opacity: 1.0),
      backgroundUrl: '',
    );
  }

  static List<TaskBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<TaskBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }

  static List<TaskBean> fromNetMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<TaskBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromNetMap(mapList[i]));
    }
    return list;
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskType': taskType,
      'taskStatus': taskStatus,
      'taskDetailNum': taskDetailNum,
      'overallProgress':
          (overallProgress >= 1.0 ? 1.0 : overallProgress).toString(),
      'createDate': createDate,
      'account': account,
      'uniqueId': uniqueId,
      'needUpdateToCloud': needUpdateToCloud,
      'changeTimes': changeTimes ?? 0,
      'finishDate': finishDate,
      'startDate': startDate,
      'deadLine': deadLine,
      'taskIconBean': jsonEncode(taskIconBean.toMap()),
      'textColor': jsonEncode(textColor.toMap()),
      'backgroundUrl': backgroundUrl,
      'detailList': jsonEncode(List.generate(detailList.length, (index) {
        return detailList[index].toMap();
      }))
    };
    //把list转换为string的时候不要直接使用tostring，要用jsonEncode
  }

  @override
  String toString() {
    return 'TaskBean{id: $id, taskName: $taskName, taskType: $taskType, account: $account, taskStatus: $taskStatus, taskDetailNum: $taskDetailNum, overallProgress: $overallProgress, uniqueId: $uniqueId, needUpdateToCloud: $needUpdateToCloud, changeTimes: $changeTimes, createDate: $createDate, finishDate: $finishDate, startDate: $startDate, deadLine: $deadLine, taskIconBean: $taskIconBean, detailList: $detailList, textColor: $textColor, backgroundUrl: $backgroundUrl}';
  }

  ///是否需要在云端更新
  bool getNeedUpdateToCloud(TaskBean taskBean) {
    final uniqueId = taskBean.uniqueId;
    final account = taskBean.account;
    if (account == 'default') return false;
    return taskBean.needUpdateToCloud == 'true';
  }
}

//单个任务详情的json数据
class TaskDetailBean {
  String taskDetailName;
  double itemProgress;

  TaskDetailBean({this.taskDetailName = "", this.itemProgress = 0.0});

  static TaskDetailBean fromMap(Map<String, dynamic> map) {
    TaskDetailBean taskDetailBean = new TaskDetailBean();
    taskDetailBean.taskDetailName = map['taskDetailName'];
    taskDetailBean.itemProgress = map['itemProgress'] is double
        ? map['itemProgress']
        : double.parse(map['itemProgress']);
    return taskDetailBean;
  }

  static List<TaskDetailBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<TaskDetailBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'taskDetailName': taskDetailName,
      'itemProgress': itemProgress.toString()
    };
  }
}

class TaskStatus {
  static const int todo = 0;
  static const int doing = 1;
  static const int done = 2;
}
