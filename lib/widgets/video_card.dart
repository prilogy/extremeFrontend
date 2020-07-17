import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

import '../videoViewPage.dart';
import 'like_state.dart';


class VideoCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  VideoCard(
      {EdgeInsetsGeometry margin,
      EdgeInsetsGeometry padding,
      double aspectRatio}) {
    this.margin = margin;
    this.padding = padding;
    this.aspectRatio = aspectRatio;
  }
  @override
  Widget build(BuildContext context) {
    return withIndents(
      child: withAspectRatio(
        child: Column(
          children: <Widget>[
            Card(
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
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Blancpain GT3 - 3 hours Monza Race / Replay',
                  style: TextStyle(
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  '5 дней назад',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .merge(new TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
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
        child: Text(_time(hours, minutes, seconds)),
      ),
    );
  }
}
// class VideoCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final double screenWigth = MediaQuery.of(context).size.width;
//     final double cardHeigth = 200;
//     return Card(
//       elevation: 0.0,
//       margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
//       color: Colors.transparent,
//       child: Container(
//         width: screenWigth / 2,
//         color: Colors.transparent,
//         child: Column(
//           children: <Widget>[
//             Stack(
//               children: <Widget>[
//                 InkWell(
//                   splashColor: Colors.blue.withAlpha(30),
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => VideoViewScreen(),
//                         ));
//                     print('Card tapped.');
//                   },
//                   child: Container(
//                     width: screenWigth,
//                     height: cardHeigth,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: ExactAssetImage("extreme2.jpg"),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: Like(isLiked: false),
//                 ),
//                 Positioned(
//                   bottom: 15,
//                   right: 10,
//                   child: Container(
//                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                     alignment: Alignment.center,
//                     color: Colors.black54,
//                     child: Text(
//                       "7:34",
//                       style: TextStyle(
//                         fontFamily: 'RobotoMono',
//                         fontSize: 12.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
//               color: Colors.transparent,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             child: Text(
//                               'Blancpain GT3 - 3 hours Monza Race / Replay',
//                               style: TextStyle(
//                                 fontFamily: 'RobotoMono',
//                                 fontSize: 14.0,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Text(
//                               '5 дней назад',
//                               style: TextStyle(
//                                 fontFamily: 'RobotoMono',
//                                 fontSize: 12.0,
//                                 color: Color.fromRGBO(182, 181, 189, 1),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       IconButton(
//                         padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                         alignment: Alignment.centerRight,
//                         icon: Icon(
//                           Icons.more_vert,
//                           size: 20,
//                           color: Color.fromRGBO(182, 181, 189, 1),
//                         ),
//                         tooltip: 'Placeholder',
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
