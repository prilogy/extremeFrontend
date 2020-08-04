import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;

import '../screens/video_view_screen.dart';
import 'like_state.dart';

class VideoCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  final Models.Video model;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double aspectRatio;

  VideoCard({
    this.model,
    this.margin,
    this.padding,
    this.aspectRatio,
  });


  @override
  Widget build(BuildContext context) {
    String testText = model?.content?.name ??
        'Blancpain GT3 - 3 hours Monza Race / Replay';
    return withIndents(
      child: Container(
        // padding: EdgeInsets.all(Indents.md),
        child: Column(
          children: <Widget>[
            withAspectRatio(child: VideoCardWithoutCaption()),
            Container(
              margin: EdgeInsets.only(top: Indents.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Text('Blancpain GT3 - 3 hours Monza Race / Replay',
                        // TODO: добавить перенос строки
                        Text(testText,
                            style: Theme.of(context).textTheme.subtitle1),
                        Text('5 дней назад',
                            style: Theme.of(context).textTheme.subtitle2.merge(
                                TextStyle(height: 1.4,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)))),
                      ],
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.topRight,
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    tooltip: 'Placeholder',
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
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
            image: ExactAssetImage("assets/images/extreme2.jpg"),
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoViewScreen(),
                        ));
                  },
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(Indents.md),
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

class VideoDuration extends StatelessWidget{
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
    return  Container(
        padding: EdgeInsets.all(Indents.sm / 2),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          _time(hours, minutes, seconds),
          style: Theme.of(context).textTheme.overline,
        ),
    );
  }
}
