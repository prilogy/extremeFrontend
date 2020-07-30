import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;

/// Создаёт окно поиска контента
class SearchScreen extends StatelessWidget {
  final String query;
  const SearchScreen({Key key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _query = query ?? 'Поиск Extreme Insiders';
    print('_query: ' + _query);
    TextEditingController _searchController = new TextEditingController();
    //_searchController.text = 'test';
    return ScreenBaseWidget(
      appBar: AppBar(
        title: TextField(
          decoration:
              // TODO: если переход был вместе с текстом запроса, то _query должен быть в _searchController, а не в hint
              InputDecoration.collapsed(hintText: _query),
          controller: _searchController,
          onSubmitted: (query) {
            Navigator.of(context, rootNavigator: true)
                .pushNamed('/search', arguments: query);
          },
        ),
      ),
      builder: (context) => [
        BlockBaseWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: Api.Search.global(query: _searchController.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return VideoCard(
                        aspectRatio: 16 / 9,
                        model: snapshot.data,
                      );
                    } else if (snapshot.hasError)
                      return (Text(snapshot.error.toString()));
                    return Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator());
                  })
            ],
          ),
        )
      ],
    );
  }
}
