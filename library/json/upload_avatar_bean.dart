class UploadAvatarBean {
  /*
   * description : "头像上传成功"
   * filePath : "files/772565130@qq.com/2019/7/avatar.jpg"
   * status : 0
   */

  String description = '';
  String filePath = '';
  int status = 0;

  static UploadAvatarBean fromMap(Map<String, dynamic> map) {
    UploadAvatarBean uploadAvatarBean = UploadAvatarBean();
    uploadAvatarBean.description = map['description'] ?? '';
    uploadAvatarBean.filePath = map['filePath'] ?? '';
    uploadAvatarBean.status = map['status'] ?? 0;
    return uploadAvatarBean;
  }

  static List<UploadAvatarBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<UploadAvatarBean> list = [];
    for (int i = 0; i < mapList.length; i++) {
      list.add(fromMap(mapList[i]));
    }
    return list;
  }
}
