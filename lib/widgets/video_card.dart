import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/duration_chip.dart';
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
  final VoidCallback? onClick;

  VideoCard({
    @required this.model,
    this.margin,
    this.padding,
    this.onClick,
    this.aspectRatio = 16 / 9,
  });

  @override
  Widget build(BuildContext context) {
    var title =
        model?.content?.name ?? 'Blancpain GT3 - 3 hours Monza Race / Replay';

    return StoreConnector<AppState, Models.User>(
        converter: (store) => store.state.user!,
        builder: (context, state) =>
            withIndents(
              child: Container(
                // padding: EdgeInsets.all(Indents.md),
                child: Column(
                  children: <Widget>[
                    withAspectRatio(
                        child: VideoCardWithoutCaption(
                          model: model!,
                          onClick: onClick
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
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle1),
                                Text(
                                    dateTimeToStringInAgoFormat(
                                        model!.dateCreated!, context),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.merge(TextStyle(
                                        height: 1.4,
                                        color: Theme
                                            .of(context)
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
  final VoidCallback? onClick;

  VideoCardWithoutCaption({@required this.model, this.onClick});

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
                        onClick?.call();
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                          builder: (context) =>
                              VideoViewScreen(
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
                    if (model?.content?.duration != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          DurationChip(content: model!.content!.duration!),
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
