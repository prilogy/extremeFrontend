import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/screens/movie_view_screen.dart';
import 'package:extreme/screens/playlist_screen.dart';
import 'package:extreme/screens/sport_screen.dart';
import 'package:extreme/screens/video_view_screen.dart';
import 'package:extreme/services/api/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

class HeadBanner extends StatelessWidget {
  final List<Models.Banner> data;

  final TextStyle _spacedText = const TextStyle(letterSpacing: 0.8);

  HeadBanner(this.data);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    final gradient = Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
              colors: [
                theme.colorScheme.background.withOpacity(1),
                theme.colorScheme.background.withOpacity(0.65),
                theme.colorScheme.background.withOpacity(0),
              ],
              stops: [
                0,
                0.5,
                1
              ]),
        ),
      ),
    );
    Widget contentBuilder(Models.Banner e) {
      final heading = e.content?.name ?? e.entityContent?.name;
      final description =
          e.content?.description ?? e.entityContent?.description;

      return Positioned(
        child: Center(
            child: Column(
          children: [
            if (heading != null)
              Padding(
                padding: const EdgeInsets.only(bottom: Indents.sm),
                child: Text(heading,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline5
                        ?.merge(TextStyle(fontWeight: FontWeight.w600))
                        .merge(_spacedText)),
              ),
            if (description != null)
              Text(description, textAlign: TextAlign.center, style: _spacedText)
          ],
        )),
        bottom: Indents.lg,
        left: Indents.lg,
        right: Indents.lg,
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
          height: 300, aspectRatio: 1, viewportFraction: 1, autoPlay: true),
      items: data
          .map((e) => Builder(builder: (context) {
                final imageUrl = e.content?.image?.path ??
                    e.entityContent?.image?.path ??
                    null;

                return GestureDetector(
                  onTap: e.entityId != null && e.entityType != null
                      ? () async {
                          openEntity(e.entityId!, e.entityType!, context);
                        }
                      : null,
                  child: Container(
                    width: screenWidth,
                    decoration: imageUrl != null
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover),
                          )
                        : null,
                    child: Stack(
                      children: [gradient, contentBuilder(e)],
                    ),
                  ),
                );
              }))
          .toList(),
    );
  }

  void openEntity(int entityId, String type, BuildContext context) async {
    switch (type) {
      case 'video':
        var model = await Entities.getById<Models.Video>(entityId);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoViewScreen(
                model: model as Models.Video,
              ),
            ));
        break;
      case 'playlist':
        var model = await Entities.getById<Models.Playlist>(entityId);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaylistScreen(
                model: model as Models.Playlist,
              ),
            ));
        break;
      case 'movie':
        var model = await Entities.getById<Models.Movie>(entityId);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieViewScreen(
                model: model as Models.Movie,
              ),
            ));
        break;
      case 'sport':
        var model = await Entities.getById<Models.Sport>(entityId);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SportScreen(
                model: model as Models.Sport,
              ),
            ));
        break;
    }
  }
}
// class BannerInformation extends StatelessWidget {
//   final int? id;
//   final Models.Banner? banner;
//
//   const BannerInformation({Key? key, this.id, this.banner}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//               banner?.content?.name ?? banner?.entityContent?.name ?? 'No name',
//               style: Theme.of(context).textTheme.headline6),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 vertical: Indents.sm, horizontal: Indents.xl),
//             child: Text(
//               banner?.content?.description ??
//                   banner?.entityContent?.description ??
//                   'No description',
//               maxLines: 4,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           // Text(content?.description ?? 'No description provided',
//           //     style: Theme.of(context).textTheme.bodyText2?.merge(TextStyle(
//           //         color: Theme.of(context)
//           //             .colorScheme
//           //             .onPrimary
//           //             .withOpacity(0.7)))),
//           Container(
//             height: 25,
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class HeadBanner extends StatefulWidget {
//   final List<Models.Banner>? banners;
//
//   HeadBanner({this.banners});
//
//   @override
//   _HeadBannerState createState() => _HeadBannerState();
// }
//
// class _HeadBannerState extends State<HeadBanner> {
//   int index = 0;
//   List<Models.Banner>? banners;
//
//   @override
//   Widget build(BuildContext context) {
//     banners = widget.banners;
//
//     return SizedBox(
//       height: MediaQuery.of(context).size.height / 2.5,
//       child: Stack(
//         children: [
//           Carousel(
//             images: banners!
//                 .map((e) => NetworkImage(e.content?.image?.path ??
//                 'https://img3.akspic.ru/image/20093-parashyut-kaskader-kuala_lumpur-vozdushnye_vidy_sporta-ekstremalnyj_vid_sporta-1920x1080.jpg'))
//                 .toList(),
//             dotSize: Indents.md / 2,
//             dotSpacing: Indents.lg,
//             dotColor: Theme.of(context).backgroundColor,
//             dotBgColor: Colors.white.withOpacity(0),
//             indicatorBgPadding: 10.0,
//             borderRadius: false,
//             moveIndicatorFromBottom: 180.0,
//             noRadiusForIndicator: true,
//             overlayShadow: true,
//             overlayShadowColors: Theme.of(context).colorScheme.background,
//             overlayShadowSize: 1,
//
//             onImageTap: (index) async {
//
//             },
//             onImageChange: (previous, current) {
//               setState(() {
//                 index = current;
//               });
//             },
//           ),
//           BannerInformation(
//             id: index,
//             banner: banners![index],
//           ),
//         ],
//       ),
//     );
//   }
// }
