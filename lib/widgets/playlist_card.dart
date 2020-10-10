import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/screens/playlist_screen.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'favorite_toggler.dart';
import 'stats.dart';
import 'package:extreme/models/main.dart' as Models;

class PlayListCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  final Models.Playlist model;
  final bool small;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double aspectRatio;

  PlayListCard(
      {this.margin,
      this.padding,
      this.aspectRatio,
      this.small = false,
      this.model});

  @override
  Widget build(BuildContext context) {
    var title = model?.content?.name ?? 'Название плейлиста';
    var description = model?.content?.description ?? 'Какое то описание';
    var imageUrl = model?.content?.image?.path ??
        'https://img2.akspic.ru/image/1601-nebo-priklyucheniya-skachok-bejsdzhamping-kaskader-1920x1080.jpg';
    var videosAmount = (model?.videosIds?.length ?? 0).toString();
    var likesAmount = (model?.likesAmount ?? 0).toString();

    return StoreConnector<AppState, User>(
      converter: (store) => store.state.user,
      builder: (context, state) => withIndents(
        child: withAspectRatio(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: small
                  ? Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Indents.sm),
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.2),
                                Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.6),
                              ],
                              center: Alignment.center,
                              radius: 1.5,
                              stops: <double>[0, 1],
                            ),
                          ),
                        ),
                        Positioned.fill(
                            child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlaylistScreen(
                                  model: model,
                                ),
                              ));
                            },
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(Indents.sm),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                title,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .background
                                      .withOpacity(0.35),
                                  Theme.of(context)
                                      .colorScheme
                                      .background
                                      .withOpacity(0.7),
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlaylistScreen(
                                  model: model,
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
                                      id: model?.id,
                                      status: model?.isFavorite,
                                    ),
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Stats(
                                            icon: Icons.thumb_up,
                                            text: likesAmount,
                                            marginBetween: Indents.sm,
                                            widgetMarginRight: Indents.md,
                                          ),
                                        ),
                                        Stats(
                                            icon: Icons.local_movies,
                                            text: videosAmount,
                                            marginBetween: Indents.sm),
                                      ],
                                    ),
                                    Text(title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .merge(TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary))),
                                    Text(
                                      description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .merge(new TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary)),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
