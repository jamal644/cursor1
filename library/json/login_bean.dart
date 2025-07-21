class LoginBean {
  String description = '';
  int status = 0;
  String token = '';
  String username = '';
  String avatarUrl = '';

  static LoginBean fromMap(Map<String, dynamic> map) {
    LoginBean loginBean = LoginBean();
    loginBean.description = map['description'] ?? '';
    loginBean.status = map['status'] ?? 0;
    loginBean.token = map['token'] ?? '';
    loginBean.username = map['username'] ?? '';
    loginBean.avatarUrl = map['avatarUrl'] ?? '';
    return loginBean;
  }

  static List<LoginBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<LoginBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }
}
