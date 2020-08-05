import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

typedef ItemBuilder<T> = Widget Function(T model);

enum CustomListBuilderTypes { verticalList, grid, horizontalList }

class CustomListBuilder<T> extends StatelessWidget {
  final List<T> items;
  final ItemBuilder<T> itemBuilder;
  final CustomListBuilderTypes type;
  final double height;
  // isGrid                 ------|
  // isScrollableList (типа вбок)-| Вообще это все можно объединить в enum чисто для удобства,
  // isSmth ещё что то и тд   ----| чтобы всегда конкретно один тип задавался
  // itemMargin                   \ напр enum CustomListBuilderTypes { verticalList, grid, scrollableList }

  CustomListBuilder(
      {@required this.items,
      @required this.itemBuilder,
      this.type = CustomListBuilderTypes.verticalList,
      this.height = 100});

  @override
  Widget build(BuildContext context) {
    var widgetItems = items.map<Widget>((e) => itemBuilder(e)).toList();

    // if(isGrid) GridView...
    // else if()
    switch (type) {
      case CustomListBuilderTypes.verticalList:
        {
          return ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              for (var item in widgetItems)
                Container(
                  margin: EdgeInsets.only(
                      bottom: widgetItems.last == item ? 0 : Indents.md),
                  child: item,
                )
            ],
          );
        }
        break;
      case CustomListBuilderTypes.grid:
        {
          return GridView.count(
            primary: false,
            crossAxisSpacing: Indents.md,
            mainAxisSpacing: Indents.sm,
            childAspectRatio: 16 / 9,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: <Widget>[
              for (var item in widgetItems) item,
            ],
          );
        }
        break;
      case CustomListBuilderTypes.horizontalList:
        {
          return Container(
            height: height,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: Indents.sm),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                for (var item in widgetItems)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Indents.sm),
                    child: item,
                  )
              ],
            ),
          );
        }
        break;
      default:
    }
  }
}
