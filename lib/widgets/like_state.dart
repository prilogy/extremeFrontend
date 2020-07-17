import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

class Like extends StatefulWidget {
  bool isLiked;
  Like({this.isLiked});
  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  IconData icon;
  Color iconColor;
  likeAction() {
    setState(() {
      widget.isLiked = !widget.isLiked;
      print(widget.isLiked);
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
      padding: EdgeInsets.all(Indents.md),
      icon: Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
      tooltip: 'Placeholder',
      onPressed: () {
        likeAction();
      },
    );
  }
}
