import 'package:extreme/models/main.dart';
import 'package:extreme/screens/playlist_screen.dart';
import 'package:extreme/screens/sport_screen.dart';
import 'package:extreme/services/api/main.dart';
import 'package:extreme/widgets/loader_or_content.dart';
import 'package:flutter/material.dart';

import 'custom_future_builder.dart';

class EntityNavChip extends StatefulWidget {
  final int? playlistId;
  final int? sportId;

  EntityNavChip({this.playlistId, this.sportId});

  @override
  _EntityNavChipState createState() => _EntityNavChipState();
}

class _EntityNavChipState extends State<EntityNavChip> {
  Playlist? _playlist;
  Sport? _sport;

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  Future asyncInitState() async {
    final playlist = widget.playlistId != null
        ? await Entities.getById<Playlist>(widget.playlistId)
        : null;

    final sportId = widget.sportId ?? playlist?.sportId;
    final sport =
        sportId != null ? await Entities.getById<Sport>(sportId) : null;

    setState(() {
      _playlist = playlist;
      _sport = sport;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _chip(String text, {MaterialPageRoute? pushTo}) => InkWell(
        child: Text(text),
        onTap: () {
          if (pushTo != null) Navigator.of(context).push(pushTo);
        });

    return LoaderOrContent(_playlist == null && _sport == null,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            if (_sport != null)
              _chip(_sport?.content?.name ?? '',
                  pushTo: MaterialPageRoute(
                      builder: (context) => SportScreen(model: _sport!))),
            Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
              if (_sport != null) Icon(Icons.chevron_right),
              if (_playlist != null)
                _chip(_playlist?.content?.name ?? '',
                    pushTo: MaterialPageRoute(
                        builder: (context) =>
                            PlaylistScreen(model: _playlist!))),
            ])
          ],
        ));
  }
}
