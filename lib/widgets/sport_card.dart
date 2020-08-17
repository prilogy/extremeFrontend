import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/screens/sport_screen.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/widgets/stats.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // Для случайных чисел (временно)

import 'package:extreme/models/main.dart' as Models;
import 'package:flutter_redux/flutter_redux.dart';

/// Создаёт карточку спорта.
class SportCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  final bool small;
  // TODO: переделать под модель sport
  final Models.Sport model;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double aspectRatio;

  SportCard(
      {this.margin,
      this.padding,
      this.aspectRatio,
      this.small = false,
      this.model});

  @override
  Widget build(BuildContext context) {
    String _title = model?.content?.name ?? 'Вид спорта';
    void onTap() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SportScreen(),
      ));
    }

    return StoreConnector<AppState, User>(
      converter: (store) => store.state.user,
      builder: (context, state) => withIndents(
        child: withAspectRatio(
          child: Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.all(0),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: ExactAssetImage(
                              "assets/images/extreme2.jpg"), // TODO: change hardcode image to var from db
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              ExtremeColors.base.withOpacity(0.0),
                              ExtremeColors.base.withOpacity(0.75)
                            ],
                            center: Alignment.center,
                            radius: 1.5,
                            stops: <double>[0, 1],
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Text(_title,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                              ),
                              if (!small)
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Stats(
                                        widgetMarginRight: 0,
                                        marginBetween: 0,
                                        icon: Icons.playlist_play,
                                        text: model?.playlistsIds?.length
                                                ?.toString() ??
                                            Random().nextInt(100).toString(),
                                      ),
                                      Stats(
                                        reversed: true,
                                        widgetMarginRight: 0,
                                        marginBetween: 0,
                                        icon: Icons.local_movies,
                                        text: model?.moviesIds?.length
                                                ?.toString() ??
                                            Random().nextInt(100).toString(),
                                      )
                                    ],
                                  ),
                                )
                            ]),
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                    ),
                  )),
                ],
              )),
        ),
      ),
    );
  }
}
