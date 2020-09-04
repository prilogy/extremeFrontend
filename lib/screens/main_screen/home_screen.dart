import 'package:carousel_pro/carousel_pro.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/screens/movie_view_screen.dart';
import 'package:extreme/screens/playlist_screen.dart';
import 'package:extreme/screens/sport_screen.dart';
import 'package:extreme/screens/video_view_screen.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;
import 'package:scroll_app_bar/scroll_app_bar.dart';

// Домашняя страница пользователя - Главная

class HomeScreen extends StatelessWidget implements IWithNavigatorKey {
  final Key navigatorKey;

  HomeScreen({Key key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('home_screen');
    var store = StoreProvider.of<AppState>(context);

    return ScreenBaseWidget(
      padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
      appBarComplex: (ctx, c) => ScrollAppBar(
        controller: c,
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
        CustomFutureBuilder(
          future: Api.Helper.getBanner(),
          builder: (data) {
            return Container(
              margin: EdgeInsets.only(bottom: Indents.md),
              child: HeadBanner(
                banners: data,
              ),
            );
          },
        ),
        BlockBaseWidget.forScrollingViews(
          header: loc.translate('interesting_sports'),
          child: CustomFutureBuilder<List<Models.Sport>>(
              future: Api.Entities.recommended<Models.Sport>(1, 6),
              builder: (List<Models.Sport> data) => CustomListBuilder(
                  type: CustomListBuilderTypes.horizontalList,
                  height: 60,
                  items: data,
                  itemBuilder: (item) =>
                      SportCard(model: item, aspectRatio: 2.5 / 1, small: true))),
        ),
        BlockBaseWidget(
          header: AppLocalizations.of(context).translate('helper.users_choice'),
          child: CustomFutureBuilder<List<Models.Video>>(
            future: Api.Entities.recommended<Models.Video>(1, 2),
            builder: (data) {
              return CustomListBuilder(
                  items: data,
                  itemBuilder: (item) => VideoCard(
                        model: item,
                        aspectRatio: 16 / 9,
                      ));
            },
          ),
        ),
        BlockBaseWidget.forScrollingViews(
          margin: EdgeInsets.zero,
          header: loc.translate('last_updates'),
          child: CustomFutureBuilder(
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

class BannerInformation extends StatelessWidget {
  final int id;
  final Models.Banner banner;

  const BannerInformation({Key key, this.id, this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              banner?.content?.name ?? banner?.entityContent?.name ?? 'No name',
              style: Theme.of(context).textTheme.headline6),
          // Text(content?.description ?? 'No description provided',
          //     style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
          //         color: Theme.of(context)
          //             .colorScheme
          //             .onPrimary
          //             .withOpacity(0.7)))),
          Container(
            height: 25,
          )
        ],
      ),
    );
  }
}

class HeadBanner extends StatefulWidget {
  final List<Models.Banner> banners;

  HeadBanner({this.banners});

  @override
  _HeadBannerState createState() => _HeadBannerState();
}

class _HeadBannerState extends State<HeadBanner> {
  int index = 0;
  List<Models.Banner> banners;

  @override
  Widget build(BuildContext context) {
    banners = widget.banners;
    return SizedBox(
      height: 250.0,
      child: Stack(
        children: [
          Carousel(
            images: banners
                .map((e) => NetworkImage(e?.entityContent?.image?.path ??
                    'https://img3.akspic.ru/image/20093-parashyut-kaskader-kuala_lumpur-vozdushnye_vidy_sporta-ekstremalnyj_vid_sporta-1920x1080.jpg'))
                .toList(),
            dotSize: Indents.md / 2,
            dotSpacing: Indents.lg,
            dotColor: Theme.of(context).backgroundColor,
            dotBgColor: Colors.white.withOpacity(0),
            indicatorBgPadding: 10.0,
            borderRadius: false,
            moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
            overlayShadow: true,
            overlayShadowColors: Theme.of(context).scaffoldBackgroundColor,
            overlayShadowSize: 1,
            onImageTap: (index) async {
              switch (banners[index].entityType) {
                case 'video':
                  var model = await Api.Entities.getById<Models.Video>(
                      banners[index].entityId);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoViewScreen(
                          model: model,
                        ),
                      ));
                  break;
                case 'playlist':
                  var model = await Api.Entities.getById<Models.Playlist>(
                      banners[index].entityId);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaylistScreen(
                          model: model,
                        ),
                      ));
                  break;
                case 'movie':
                  var model = await Api.Entities.getById<Models.Movie>(
                      banners[index].entityId);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieViewScreen(
                          model: model,
                        ),
                      ));
                  break;
                case 'sport':
                  var model = await Api.Entities.getById<Models.Sport>(
                      banners[index].entityId);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SportScreen(
                          model: model,
                        ),
                      ));
                  break;
                default:
                  null;
              }
            },
            onImageChange: (previous, current) {
              setState(() {
                index = current;
              });
            },
          ),
          BannerInformation(
            id: index,
            banner: banners[index],
          ),
        ],
      ),
    );
  }
}
