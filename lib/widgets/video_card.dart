import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:flutter_redux/flutter_redux.dart';

import '../screens/video_view_screen.dart';
import 'favorite_toggler.dart';

class VideoCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  final Models.Video? model;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? aspectRatio;

  VideoCard({
    @required this.model,
    this.margin,
    this.padding,
    this.aspectRatio = 16 / 9,
  });

  @override
  Widget build(BuildContext context) {
    var title =
        model?.content?.name ?? 'Blancpain GT3 - 3 hours Monza Race / Replay';

    return StoreConnector<AppState, Models.User>(
        converter: (store) => store.state.user!,
        builder: (context, state) => withIndents(
              child: Container(
                // padding: EdgeInsets.all(Indents.md),
                child: Column(
                  children: <Widget>[
                    withAspectRatio(
                        child: VideoCardWithoutCaption(
                      model: model!,
                    )),
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
                                Text(title,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                Text(
                                    dateTimeToStringInAgoFormat(
                                        model!.dateCreated!, context),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.merge(TextStyle(
                                            height: 1.4,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground
                                                .withOpacity(0.6))))
                              ],
                            ),
                          ),
                          // Removed as of current state
//                          IconButton(
//                            padding: EdgeInsets.zero,
//                            alignment: Alignment.topRight,
//                            icon: Icon(
//                              Icons.more_vert,
//                              color: Theme.of(context).colorScheme.onPrimary,
//                            ),
//                            tooltip: 'Placeholder',
//                            onPressed: () {},
//                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}

class VideoCardWithoutCaption extends StatelessWidget {
  final Models.Video? model;

  VideoCardWithoutCaption({@required this.model});

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
            image: NetworkImage(model?.content?.image?.path ??
                'https://img3.akspic.ru/image/20093-parashyut-kaskader-kuala_lumpur-vozdushnye_vidy_sporta-ekstremalnyj_vid_sporta-1920x1080.jpg'),
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
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                      builder: (context) => VideoViewScreen(
                        model: model!,
                      ),
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
                          FavoriteToggler(
                            status: model?.isFavorite,
                            id: model?.id,
                          ),
                        ]),
//Removed as of current state
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.end,
//                      children: <Widget>[
//                        VideoDuration(minutes: 7, seconds: 34),
//                      ],
//                    ),
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

class VideoDuration extends StatelessWidget {
  final int? hours;
  final int? minutes;
  final int? seconds;

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
    return Container(
      padding: EdgeInsets.all(Indents.sm / 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        _time(hours!, minutes!, seconds!),
        style: Theme.of(context).textTheme.overline,
      ),
    );
  }
}
