import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';

import 'loading_widget.dart';

class NetLoadingWidget extends StatefulWidget {
  final LoadingController loadingController;
  final Widget? successWidget;
  final String? loadingText;
  final String? errorText;
  final String? successText;
  final String? emptyText;
  final String? idleText;
  final VoidCallback? onRequest;
  final CancelToken? cancelToken;
  final VoidCallback? onSuccess;

  const NetLoadingWidget({
    Key? key,
    required this.loadingController,
    this.successWidget,
    this.loadingText,
    this.errorText,
    this.successText,
    this.emptyText,
    this.idleText,
    this.onRequest,
    this.cancelToken,
    this.onSuccess,
  }) : super(key: key);

  @override
  _NetLoadingWidgetState createState() => _NetLoadingWidgetState();
}

class _NetLoadingWidgetState extends State<NetLoadingWidget> {
  LoadingFlag loadingFlag = LoadingFlag.loading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        body: Container(
          width: size.width,
          height: size.height,
          alignment: Alignment.center,
          child: Container(
            width: size.width / 3 * 2,
            height: size.height / 3,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: LoadingWidget(
                flag: loadingFlag,
                loadingText: getLoadingText(),
                successWidget: Container(
                  margin: EdgeInsets.all(10),
                  child: widget.successWidget ??
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                widget.successText ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: widget.onSuccess ?? () {},
                            child: Text(IntlLocalizations.of(context).ok),
                          )
                        ],
                      ),
                ),
                errorCallBack: widget.onRequest ?? () {},
                errorText: getLoadingText(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget?.loadingController?._setState(this);
    if (widget.onRequest != null) {
      widget.onRequest!();
    }
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget?.cancelToken?.cancel();
    super.dispose();
  }

  String getLoadingText() {
    switch (loadingFlag) {
      case LoadingFlag.loading:
        return widget.loadingText ?? IntlLocalizations.of(context).waitAMoment;
        break;
      case LoadingFlag.error:
        return widget.errorText ?? IntlLocalizations.of(context).submitAgain;
        break;
      case LoadingFlag.success:
        return widget.successText ??
            IntlLocalizations.of(context).submitSuccess;
        break;
      case LoadingFlag.empty:
        return widget.emptyText ?? "";
        break;
      case LoadingFlag.idle:
        return widget.idleText ?? "";
        break;
    }
    return "";
  }
}

//这里面的state没有去执行dispose，不知道会不会内存泄漏
class LoadingController {
  _NetLoadingWidgetState? _state;
  LoadingFlag _flag = LoadingFlag.loading;

  void setFlag(LoadingFlag loadingFlag) {
    if (_state != null) {
      _state!.loadingFlag = loadingFlag;
      _flag = loadingFlag;
      _state!.refresh();
      print("设置: " + _state!.loadingFlag.toString());
    }
  }

  void _setState(_NetLoadingWidgetState state) {
    _state = state;
    print("设置了: " + _state.toString());
  }

  LoadingFlag get flag => _flag;
}
