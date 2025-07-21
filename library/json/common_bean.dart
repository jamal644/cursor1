class CommonBean {
  String description = '';
  int status = 0;

  static CommonBean fromMap(Map<String, dynamic> map) {
    CommonBean commonBean = CommonBean();
    commonBean.description = map['description'] ?? '';
    commonBean.status = map['status'] ?? 0;
    return commonBean;
  }

  static List<CommonBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<CommonBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }
}
