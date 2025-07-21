import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_list/i10n/localization_intl.dart';
export 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

class PermissionReqUtil {
  static final PermissionReqUtil _instance = PermissionReqUtil._internal();

  static PermissionReqUtil getInstance() {
    return _instance;
  }

  PermissionReqUtil._internal();

  void requestPermission(
    Permission reqPermissions, {
    bool showDialog = true,
    required BuildContext context,
    required VoidCallback granted,
    VoidCallback? denied,
    VoidCallback? disabled,
    VoidCallback? restricted,
    VoidCallback? unknown,
    String? deniedDes,
    String? disabledDes,
    String? restrictedDes,
    String? unknownDes,
    String? openSetting,
  }) async {
    Map<Permission, PermissionStatus> output = await PermissionHandlerPlatform
        .instance
        .requestPermissions([reqPermissions]);

    switch (output[reqPermissions]) {
      case PermissionStatus.granted:
        granted();
        break;
      case PermissionStatus.denied:
        if (denied != null) denied();
        toShow(
          showDialog,
          context,
          reqPermissions,
          deniedDes ?? IntlLocalizations.of(context).deniedDes,
          openSetting ?? IntlLocalizations.of(context).openSystemSetting,
          showOpenSettingButton: true,
        );
        break;
      case PermissionStatus.permanentlyDenied:
        debugPrint("disabled权限: $reqPermissions");
        if (disabled != null) disabled();
        toShow(showDialog, context, reqPermissions, disabledDes, openSetting);
        break;
      case PermissionStatus.restricted:
        debugPrint("restricted权限: $reqPermissions");
        if (restricted != null) restricted();
        toShow(showDialog, context, reqPermissions, restrictedDes, openSetting,
            showOpenSettingButton: true);
        break;
      case PermissionStatus.limited:
        debugPrint("未知权限: $reqPermissions");
        if (unknown != null) unknown();
        toShow(showDialog, context, reqPermissions, unknownDes, openSetting);
        break;
      default:
        break;
    }
  }

  void toShow(bool showDialog, BuildContext context, Permission reqPermissions,
      String? description, String? openSetting,
      {bool showOpenSettingButton = false}) {
    if (showDialog) {
      toShowDialog(
        context,
        "$reqPermissions",
        description ?? '',
        openSetting ?? '',
        showOpenSettingButton: showOpenSettingButton,
      );
    }
  }

  void toShowDialog(BuildContext context, String permissionName,
      String description, String openSetting,
      {bool showOpenSettingButton = false}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("$permissionName $description"),
            actions: <Widget>[
              showOpenSettingButton
                  ? TextButton(
                      onPressed: () {
                        openAppSettings();
                      },
                      child: Text(openSetting))
                  : SizedBox(),
            ],
          );
        });
  }
}
