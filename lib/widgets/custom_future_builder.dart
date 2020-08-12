import 'package:flutter/material.dart';

typedef WidgetBuilderGeneric<T> = Widget Function(T model);

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final WidgetBuilderGeneric<T> builder;

  CustomFutureBuilder({this.future, this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}
