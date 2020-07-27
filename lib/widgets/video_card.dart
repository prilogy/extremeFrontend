import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;

import '../videoViewPage.dart';
import 'like_state.dart';

class VideoCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  Models.Video info;

  VideoCard({
    this.info,
    EdgeInsetsGeometry margin,
    EdgeInsetsGeometry padding,
    double aspectRatio,
  }) {
    this.margin = margin;
    this.padding = padding;
    this.aspectRatio = aspectRatio;
  }
  @override
  Widget build(BuildContext context) {
    String testText =
        info.content?.name ?? 'Blancpain GT3 - 3 hours Monza Race / Replay';
    return Container(
      // padding: EdgeInsets.all(Indents.md),
      child: Column(
        children: <Widget>[
          withIndents(
            child: withAspectRatio(
              child: VideoCardWithoutCaption(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Text('Blancpain GT3 - 3 hours Monza Race / Replay',
                  Text(testText, style: Theme.of(context).textTheme.subtitle1),
                  Text('5 дней назад',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .merge(TextStyle(color: ExtremeColors.base70[100]))),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerRight,
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                  color: ExtremeColors.base[100],
                ),
                tooltip: 'Placeholder',
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class VideoCardWithoutCaption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage("extreme2.jpg"),
          ),
        ),
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
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
                ),
              ),
              Positioned.fill(
                  child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(Indents.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Like(
                            isLiked: true,
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        VideoDuration(minutes: 7, seconds: 34),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoDuration extends StatelessWidget with IndentsMixin {
  final int hours;
  final int minutes;
  final int seconds;
  VideoDuration({this.hours = 0, this.minutes, this.seconds});
  String _time(int hours, int minutes, int seconds) {
    if (hours == 0) {
      return minutes.toString() + ':' + seconds.toString();
    } else {
      return hours.toString() +
          ':' +
          minutes.toString() +
          ':' +
          seconds.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return withIndents(
      child: Container(
        padding: EdgeInsets.all(Indents.sm / 2),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          _time(hours, minutes, seconds),
          style: Theme.of(context).textTheme.overline,
        ),
      ),
    );
  }
}
