import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/screens/movie_view_screen.dart';
import 'package:extreme/screens/playlist_screen.dart';
import 'package:extreme/screens/sport_screen.dart';
import 'package:extreme/screens/video_view_screen.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/head_banner.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;

/// Домашняя страница пользователя - Главная

class HomeScreen extends StatelessWidget implements IWithNavigatorKey {
  final Key? navigatorKey;

  HomeScreen({Key? key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)?.withBaseKey('home_screen');

    return ScreenBaseWidget(
      padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
      appBar: AppBar(
        title: Text('Extreme Insiders'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/search');
            },
          ),
        ],
      ),
      navigatorKey: navigatorKey,
      builder: (context) => <Widget>[
        CustomFutureBuilder<List<Models.Banner>?>(
          future: Api.Helper.getBanner(),
          builder: (data) {
            // print(data![0].entityContent?.image?.path.toString());
            if ((data?.length ?? 0) > 0)
              return Container(
                  margin: EdgeInsets.only(bottom: Indents.md),
                  child: HeadBanner(data!)
              );
            else {
              return Container();
            }
          },
        ),
        BlockBaseWidget.forScrollingViews(
          header: loc!.translate('interesting_sports'),
          child: CustomFutureBuilder<List<Models.Sport>?>(
              future: Api.Entities.recommended<Models.Sport>(1, 6),
              builder: (data) => CustomListBuilder(
                  type: CustomListBuilderTypes.horizontalList,
                  height: 60,
                  items: data,
                  itemBuilder: (item) => SportCard(
                      model: item as Models.Sport,
                      aspectRatio: 2.5 / 1,
                      small: true))),
        ),
        BlockBaseWidget(
          header:
              AppLocalizations.of(context)?.translate('helper.users_choice'),
          child: CustomFutureBuilder<List<Models.Video>?>(
            future: Api.Entities.recommended<Models.Video>(1, 2),
            builder: (data) {
              return CustomListBuilder(
                  items: data,
                  itemBuilder: (item) => VideoCard(
                        model: item as Models.Video,
                        aspectRatio: 16 / 9,
                      ));
            },
          ),
        ),
        BlockBaseWidget.forScrollingViews(
          margin: EdgeInsets.zero,
          header: loc.translate('last_updates'),
          child: CustomFutureBuilder<List<Models.Playlist>?>(
            future: Api.Entities.getAll<Models.Playlist>(1, 6, 'desc'),
            builder: (data) {
              return CustomListBuilder<Models.Playlist>(
                  type: CustomListBuilderTypes.horizontalList,
                  height: 100,
                  items: data,
                  itemBuilder: (item) => PlayListCard(
                      model: item, aspectRatio: 16 / 9, small: true));
            },
          ),
        ),
      ],
    );
  }
}
