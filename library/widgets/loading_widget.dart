import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/i10n/localization_intl.dart';

class LoadingWidget extends StatelessWidget {
  final Color? progressColor;
  final Color? textColor;
  final double? textSize;
  final String? loadingText;
  final String? emptyText;
  final String? errorText;
  final String? idleText;
  final LoadingFlag flag;
  final VoidCallback? errorCallBack;
  final Widget? successWidget;
  final double size;

  const LoadingWidget({
    Key? key,
    this.progressColor,
    this.textColor,
    this.textSize,
    this.loadingText,
    this.flag = LoadingFlag.loading,
    this.errorCallBack,
    this.emptyText,
    this.errorText,
    this.size = 100,
    this.successWidget,
    this.idleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    switch (flag) {
      case LoadingFlag.loading:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size / 2,
                width: size / 2,
                child: CircularProgressIndicator(
                  strokeWidth: size / 10,
                  valueColor:
                      AlwaysStoppedAnimation(progressColor ?? primaryColor),
                ),
              ),
              SizedBox(
                height: size / 5,
              ),
              Text(
                loadingText ?? IntlLocalizations.of(context).loading,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textSize ?? size / 5,
                    color: textColor ?? primaryColor),
              )
            ],
          ),
        );
      case LoadingFlag.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "svgs/loading_error.svg",
                color: progressColor ?? primaryColor,
                width: size,
                height: size,
                semanticsLabel: 'loading error',
              ),
              TextButton(
                  onPressed: errorCallBack ?? () {},
                  child: Text(
                    "${errorText ?? ""}".isEmpty
                        ? IntlLocalizations.of(context).reLoading
                        : errorText!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: textSize ?? size / 5,
                        color: textColor ?? primaryColor),
                  )),
            ],
          ),
        );
      case LoadingFlag.success:
        return successWidget ?? SizedBox();
      case LoadingFlag.empty:
        return Center(
          child: Text(
            emptyText ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: textSize ?? size / 5,
                color: textColor ?? primaryColor),
          ),
        );
      case LoadingFlag.idle:
        return Center(
          child: Text(
            idleText ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: textSize ?? size / 5,
                color: textColor ?? primaryColor),
          ),
        );
    }
  }
}

enum LoadingFlag { loading, error, success, empty, idle }
