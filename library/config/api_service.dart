import 'dart:convert';

import 'package:todo_list/json/all_beans.dart';
import 'package:todo_list/json/task_bean.dart';
export 'package:todo_list/json/all_beans.dart';

import 'api_strategy.dart';
export 'package:dio/dio.dart';

///这里存放所有的网络请求接口
class ApiService {
  static final ApiService _instance = ApiService._internal();

  static ApiService get instance => _instance;

  static final int requestSucceed = 0;
  static final int requestFailed = 1;

  ApiService._internal() {
    ///初始化
  }

  ///获取图片
  void getPhotos({
    required Function success,
    required Function failed,
    required Function error,
    required Map<String, String> params,
    required CancelToken token,
    required int startPage,
  }) {
    ApiStrategy.getInstance().get(
      "https://api.unsplash.com/photos/",
      (data) {
        if (data.toString().contains("errors")) {
          failed(data);
        } else {
          List<PhotoBean> beans = PhotoBean.fromMapList(data);
          success(beans, data);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

  ///提交建议(新增头像上传)
  void postSuggestionWithAvatar(
      {required FormData params,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken token}) {
    ApiStrategy.getInstance().postUpload(
        "fUser/oneDaySuggestion",
        (data) {
          CommonBean commonBean = CommonBean.fromMap(data);
          if (commonBean.status == requestSucceed) {
            success(commonBean);
          } else {
            failed(commonBean);
          }
        },
        (count, total) {},
        formData: params,
        errorCallBack: (errorMessage) {
          error(errorMessage);
        });
  }

  ///获取建议列表
  void getSuggestions({
    required Function success,
    required Function error,
    required CancelToken token,
  }) {
    ApiStrategy.getInstance().get(
      "fUser/getSuggestion",
      (data) {
        success(data);
      },
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

  ///通用的请求
  void postCommon(
      {required Map<String, String> params,
      required Function success,
      required Function failed,
      required Function error,
      required String url,
      required CancelToken token}) {
    ApiStrategy.getInstance().post(
        url,
        (data) {
          CommonBean commonBean = CommonBean.fromMap(data);
          if (commonBean.status == requestSucceed) {
            success(commonBean);
          } else {
            failed(commonBean);
          }
        },
        params: params,
        errorCallBack: (errorMessage) {
          error(errorMessage);
        },
        token: token);
  }

  ///天气获取
  void getWeatherNow({
    required Function success,
    required Function failed,
    required Function error,
    required Map<String, String> params,
    required CancelToken token,
  }) {
    ApiStrategy.getInstance().get(
      "https://free-api.heweather.com/s6/weather/now",
      (data) {
        WeatherBean weatherBean = WeatherBean.fromMap(data);
        if (weatherBean.heWeather6[weatherBean.heWeather6.length - 1].status ==
            "ok") {
          success(weatherBean);
        } else {
          failed(weatherBean);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

  ///检查更新
  void checkUpdate({
    required Function success,
    required Function error,
    required Map<String, String> params,
    required CancelToken token,
  }) {
    ApiStrategy.getInstance().post(
      "app/checkUpdate",
      (data) {
        UpdateInfoBean updateInfoBean = UpdateInfoBean.fromMap(data);
        success(updateInfoBean);
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

  ///登录
  void login({
    required Map<String, String> params,
    required Function success,
    required Function failed,
    required Function error,
    required CancelToken token,
  }) {
    ApiStrategy.getInstance().post(
        "fUser/login",
        (data) {
          LoginBean loginBean = LoginBean.fromMap(data);
          if (loginBean.status == requestSucceed) {
            success(loginBean);
          } else {
            failed(loginBean);
          }
        },
        params: params,
        errorCallBack: (errorMessage) {
          error(errorMessage);
        },
        token: token);
  }

  ///修改用户名
  void changeUserName(
      {required Map<String, String> params,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken token}) {
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "fUser/updateUserName",
      token: token,
    );
  }

  ///上传头像
  void uploadAvatar(
      {required FormData params,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken token}) {
    ApiStrategy.getInstance().postUpload(
        "fUser/uploadAvatar",
        (data) {
          UploadAvatarBean bean = UploadAvatarBean.fromMap(data);
          if (bean.status == requestSucceed) {
            success(bean);
          } else {
            failed(bean);
          }
        },
        (count, total) {},
        formData: params,
        errorCallBack: (errorMessage) {
          error(errorMessage);
        });
  }

  ///邮箱验证码获取请求
  void getVerifyCode({
    required Map<String, String> params,
    required Function success,
    required Function failed,
    required Function error,
    required CancelToken token,
  }) {
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "fUser/identifyCodeSend",
      token: token,
    );
  }

  //邮箱验证码校验请求
  void postVerifyCheck(
      {required Map<String, String> params,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken token}) {
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "fUser/identifyCodeCheck",
      token: token,
    );
  }

  ///邮箱注册
  void postRegister(
      {required Map<String, String> params,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken token}) {
    ApiStrategy.getInstance().post(
      "fUser/register",
      (data) {
        RegisterBean registerBean = RegisterBean.fromMap(data);
        if (registerBean.status == requestSucceed) {
          success(registerBean);
        } else {
          failed(registerBean);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

  ///重设密码
  void postResetPassword({
    required Map<String, String> params,
    required Function success,
    required Function failed,
    required Function error,
    required CancelToken token,
  }) {
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "fUser/resetPassword",
      token: token,
    );
  }

  ///忘记密码
  void postForgetPassword(
      {required Map<String, String> params,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken token}) {
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "fUser/forgetPassword",
      token: token,
    );
  }

  ///上传一个Task
  void postCreateTask(
      {required String token,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken cancelToken,
      required TaskBean taskBean}) {
    ApiStrategy.getInstance().post(
      "oneDayTask/createTask",
      (data) {
        UploadTaskBean bean = UploadTaskBean.fromMap(data);
        if (bean.status == requestSucceed) {
          success(bean);
        } else {
          failed(bean);
        }
      },
      params: {
        'taskName': taskBean.taskName,
        'taskType': taskBean.taskType,
        'account': taskBean.account,
        'taskStatus': '${taskBean.taskStatus}',
        'taskDetailNum': '${taskBean.taskDetailNum}',
        'overallProgress': '${taskBean.overallProgress}',
        'changeTimes': '${taskBean.changeTimes}',
        'finishDate': taskBean.finishDate,
        'startDate': taskBean.startDate,
        'deadLine': taskBean.deadLine,
        'taskIconBean': jsonEncode(taskBean.taskIconBean.toMap()),
        'detailList':
            jsonEncode(List.generate(taskBean.detailList.length, (index) {
          return taskBean.detailList[index].toMap();
        })),
        'token': token,
      },
      errorCallBack: (errorMessage) {
        error("上传出错：$errorMessage");
      },
      token: cancelToken,
    );
  }

  ///获取所有task
  void getTasks(
      {required Map<String, String> params,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken token}) {
    ApiStrategy.getInstance().post(
      "oneDayTask/getTasks",
      (data) {
        CloudTaskBean bean = CloudTaskBean.fromMap(data);
        if (bean.status == requestSucceed) {
          success(bean);
        } else {
          failed(bean);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error("获取出错：$errorMessage");
      },
      token: token,
    );
  }

  ///更新一个task
  void postUpdateTask(
      {required String token,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken cancelToken,
      required TaskBean taskBean}) {
    postCommon(
      params: {
        'taskName': taskBean.taskName,
        'taskType': taskBean.taskType,
        'account': taskBean.account,
        'taskStatus': '${taskBean.taskStatus}',
        'taskDetailNum': '${taskBean.taskDetailNum}',
        'overallProgress': '${taskBean.overallProgress}',
        'changeTimes': '${taskBean.changeTimes}',
        'finishDate': taskBean.finishDate,
        'startDate': taskBean.startDate,
        'uniqueId': taskBean.uniqueId,
        'deadLine': taskBean.deadLine,
        'taskIconBean': jsonEncode(taskBean.taskIconBean.toMap()),
        'detailList':
            jsonEncode(List.generate(taskBean.detailList.length, (index) {
          return taskBean.detailList[index].toMap();
        })),
        'token': token,
      },
      success: success,
      failed: failed,
      error: error,
      url: "oneDayTask/updateTask",
      token: cancelToken,
    );
  }

  ///删除一个task
  void postDeleteTask(
      {required Map<String, String> params,
      required Function success,
      required Function failed,
      required Function error,
      required CancelToken token}) {
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "oneDayTask/deleteTask",
      token: token,
    );
  }
}
