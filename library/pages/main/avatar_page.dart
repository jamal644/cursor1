import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/avatar_page_model.dart';
import 'package:todo_list/model/main_page_model.dart';

class AvatarPage extends StatelessWidget {
  final MainPageModel mainPageModel;

  const AvatarPage({Key? key, required this.mainPageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AvatarPageModel>(context);
    model.setMainPageModel(mainPageModel);
    model.setContext(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          IntlLocalizations.of(context).avatar,
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) => model.logic.onAvatarSelect(value, context),
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  value: AvatarType.local,
                  child: Container(
                    child: Text(IntlLocalizations.of(context).avatarLocal),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                PopupMenuItem(
                  value: AvatarType.history,
                  child: Container(
                    child: Text(IntlLocalizations.of(context).avatarHistory),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Hero(
            tag: "avatar",
            child: Container(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Crop(
                  key: model.cropKey,
                  image: model.logic.getAvatarProvider(),
                  aspectRatio: 1.0,
                  maximumScale: 1.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.8),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).primaryColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(IntlLocalizations.of(context).save),
              onPressed: model.logic.onSaveTap,
            ),
          )
        ],
      ),
    );
  }
}
