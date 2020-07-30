import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/screens/sport_screen.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/stats.dart';
import 'package:flutter/material.dart';


class SportCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  final bool small;
  // TODO: переделать под модель sport
  final int playlists;
  final int videos;
  final String title;

  SportCard(
      {EdgeInsetsGeometry margin,
      EdgeInsetsGeometry padding,
      double aspectRatio,
      this.small = false,
      this.playlists,
      this.videos,
      this.title}) {
    this.margin = margin;
    this.padding = padding;
    this.aspectRatio = aspectRatio;
  }

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SportScreen(),
          ));
    }

    return withIndents(
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
                            "extreme2.jpg"), // TODO: change hardcode image to var from db
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
                                child: Text(title,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                            if (small != true)
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Stats(
                                      widgetMarginRight: 0,
                                      marginBetween: 0,
                                      icon: Icons.playlist_play,
                                      text: playlists.toString(),
                                    ),
                                    Stats(
                                      reversed: true,
                                      widgetMarginRight: 0,
                                      marginBetween: 0,
                                      icon: Icons.local_movies,
                                      text: videos.toString(),
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
    );
  }
}
