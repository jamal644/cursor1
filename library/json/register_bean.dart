class RegisterBean {
  String description = '';
  String token = '';
  String avatarUrl = '';
  int status = 0;

  static RegisterBean fromMap(Map<String, dynamic> map) {
    RegisterBean diaryBase = RegisterBean();
    diaryBase.description = map['description'] ?? '';
    diaryBase.token = map['token'] ?? '';
    diaryBase.avatarUrl = map['avatarUrl'] ?? '';
    diaryBase.status = map['status'] ?? 0;
    return diaryBase;
  }

  static List<RegisterBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<RegisterBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }
}
