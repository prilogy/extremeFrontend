import 'package:extreme/widgets/playlist_card.dart';
import 'package:flutter/material.dart';

class ListGenerator<T> extends StatelessWidget {
  final List<T>? models;
  List<Widget>? _cards;

  ListGenerator({this.models});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          var _widgets;
          _widgets = models!
              .map((e) => PlayListCard(
                    // model: e,
                    aspectRatio: 16 / 9,
                  ))
              .toList();
          _cards = [..._widgets];
          if (i >= _widgets.length) {
            return Container();
          }
          return _cards![i];
        });
  }
}
