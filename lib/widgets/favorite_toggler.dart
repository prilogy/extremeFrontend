import 'package:extreme/helpers/app_builder.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// TODO: отрефакторить
// 0. виджет не Stateful
// 1. isLiked должен быть final (состояние будет изменяться из родительского виджета)
// 2. название файла должно соответстовать названию главного класса
// 3. название класса нужно более конкретное, ибо на других экранах есть похожие по семантике кнопки, (напр. OnCardLikeButton)

// TODO: icon, iconColor должны быть локальны для build (пример в )
class FavoriteToggler extends StatelessWidget {
  final bool status;
  final int id;
  final String toolTip;

  FavoriteToggler({this.status, this.id, this.toolTip});

  @override
  Widget build(BuildContext context) {
    var icon = status ? Icons.favorite : Icons.favorite_border;
    var color = status ? ExtremeColors.error : Colors.white;
    var toolTipText =
        toolTip ?? AppLocalizations.of(context).translate('tooltips.favorite');

    return IconButton(
      alignment: Alignment.topRight,
      padding: EdgeInsets.all(0),
      icon: Icon(
        icon,
        color: color,
        size: 30,
      ),
      tooltip: toolTipText,
      onPressed: () async {
        var userAction = await Api.User.toggleFavorite(id);
        if (userAction != null) {
          StoreProvider.of<AppState>(context)
              .dispatch(ToggleFavorite(userAction));
          var appb =AppBuilder.of(context);
          appb.rebuild();
        }
      },
    );
  }
}
