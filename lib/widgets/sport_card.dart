import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:flutter/material.dart';

import '../kindOfSport.dart';

class SportCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  SportCard(
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
                        image: ExactAssetImage("extreme2.jpg"),
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
                                child: Text("Вид спорта",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.playlist_play),
                                      Text(
                                        "45",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "10",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Icon(Icons.local_movies),
                                    ],
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KindOfSportScreen(),
                          ));
                    },
                  ),
                )),
              ],
            )),
      ),
    );
  }
}
