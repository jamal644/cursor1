class SuggestionBean {
  /*
   * description : "查询成功"
   * status : 0
   * suggestions : [{"id":9,"account":"default","suggestion":"test for submitting suggestions with avatar","connect_way":"<emoji>2<emoji>","avatarUrl":"files/default/2019/7/icon.png","userName":"anonymous","time":"2019-08-15"},{"id":10,"account":"default","suggestion":"test for submitting suggestions with avatar","connect_way":"<emoji>2<emoji>","avatarUrl":"files/default/2019/7/icon.png","userName":"anonymous","time":"2019-08-15"},{"id":11,"account":"default","suggestion":"test for submitting suggestions with avatar","connect_way":"<emoji>2<emoji>","avatarUrl":"files/default/2019/7/icon.png","userName":"anonymous","time":"2019-08-15"},{"id":12,"account":"default","suggestion":"test for submitting suggestions with avatar","connect_way":"<emoji>2<emoji>","avatarUrl":"files/default/2019/7/icon.png","userName":"anonymous","time":"2019-08-15"}]
   */

  String description = '';
  int status = 0;
  List<SuggestionsListBean> suggestions = [];

  static SuggestionBean fromMap(Map<String, dynamic> map) {
    SuggestionBean suggestionBean = SuggestionBean();
    suggestionBean.description = map['description'] ?? '';
    suggestionBean.status = map['status'] ?? 0;
    suggestionBean.suggestions =
        SuggestionsListBean.fromMapList(map['suggestions']);
    return suggestionBean;
  }

  static List<SuggestionBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<SuggestionBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }
}

class SuggestionsListBean {
  /*
   * account : "default"
   * suggestion : "test for submitting suggestions with avatar"
   * connect_way : "<emoji>2<emoji>"
   * avatarUrl : "files/default/2019/7/icon.png"
   * userName : "anonymous"
   * time : "2019-08-15"
   * id : 9
   */

  String account = '';
  String suggestion = '';
  String connectWay = '';
  String avatarUrl = '';
  String userName = '';
  String time = '';
  int id = 0;

  static SuggestionsListBean fromMap(Map<String, dynamic> map) {
    SuggestionsListBean suggestionsListBean = SuggestionsListBean();
    suggestionsListBean.account = map['account'] ?? '';
    suggestionsListBean.suggestion = map['suggestion'] ?? '';
    suggestionsListBean.connectWay = map['connect_way'] ?? '';
    suggestionsListBean.avatarUrl = map['avatarUrl'] ?? '';
    suggestionsListBean.userName = map['userName'] ?? '';
    suggestionsListBean.time = map['time'] ?? '';
    suggestionsListBean.id = map['id'] ?? 0;
    return suggestionsListBean;
  }

  static List<SuggestionsListBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<SuggestionsListBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }
}
