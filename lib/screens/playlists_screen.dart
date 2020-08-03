import 'package:extreme/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';

class Playlists extends StatelessWidget {
  //const Playlists({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
      appBar: AppBar(title: Text('Плейлисты')),
      builder: (context) => [
        BlockBaseWidget(
                //header: "Популярные плейлисты",
                margin: EdgeInsets.zero,
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    for (var item in [
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: false,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: true,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: false,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: true,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: false,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: true,
                      ),
                    ])
                      item
                  ],
                ),
              ),
      ],
    );
  }
}
