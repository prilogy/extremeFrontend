import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

// TODO: отрефакторить
// 0. виджет не Stateful
// 1. isLiked должен быть final (состояние будет изменяться из родительского виджета)
// 2. название файла должно соответстовать названию главного класса
// 3. название класса нужно более конкретное, ибо на других экранах есть похожие по семантике кнопки, (напр. OnCardLikeButton)
class Like extends StatefulWidget {
  bool isLiked;
  Like({this.isLiked});
  @override
  _LikeState createState() => _LikeState();
}

// TODO: icon, iconColor должны быть локальны для build (пример в )
class _LikeState extends State<Like> {
  IconData icon;
  Color iconColor;
  likeAction() {
    setState(() {
      widget.isLiked = !widget.isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLiked) {
      icon = Icons.favorite;
      iconColor = ExtremeColors.error;
    } else {
      icon = Icons.favorite_border;
      iconColor = Colors.white;
    }
    return IconButton(
      alignment: Alignment.topRight,
      padding: EdgeInsets.all(0),
      icon: Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
      tooltip: 'Добавить в избранное',
      onPressed: () {
        likeAction();
      },
    );
  }
}
