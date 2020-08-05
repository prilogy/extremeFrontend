import 'package:extreme/widgets/playlist_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;

class ListGenerator<T> extends StatelessWidget {
  final List<T> models;
  ListGenerator({this.models});
  @override
  List<Widget> _cards;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
        //   if (i >= _cards.length) {
          var _widgets;
             _widgets = models
                .map((e) => PlayListCard(
                     // model: e,
                      aspectRatio: 16 / 9,
                    ))
                .toList();
            _cards = [..._widgets];
          if (i >= _widgets.length )
          {
            return null;
          }
          // }
          return _cards[i];
        });
  }
}

