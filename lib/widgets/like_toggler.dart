import 'package:extreme/helpers/app_builder.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


// TODO: icon, iconColor должны быть локальны для build (пример в )
class LikeToggler extends StatelessWidget {
  final bool status;
  final int id;
  final String toolTip;

  LikeToggler({this.status, this.id, this.toolTip});

  @override
  Widget build(BuildContext context) {
    var color = status ? ExtremeColors.error : Colors.white;
    var toolTipText =
        toolTip ?? AppLocalizations.of(context).translate('tooltips.favorite');

    return IconButton(
      alignment: Alignment.topRight,
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.thumb_up,
        color: color,
        size: 30,
      ),
      tooltip: toolTipText,
      onPressed: () async {
        var userAction = await Api.User.toggleLike(id);
        if (userAction != null) {
          StoreProvider.of<AppState>(context)
              .dispatch(ToggleLike(userAction));
          var appb =AppBuilder.of(context);
          appb.rebuild();
        }
      },
    );
  }
}
