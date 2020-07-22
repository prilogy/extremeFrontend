import 'package:extreme/helpers/interfaces.dart';
import 'package:flutter/material.dart';

class SomeScreen extends StatelessWidget implements IWithNavigatorKey {
  final String description;

  SomeScreen(this.description);
  Key navigatorKey;
  VoidCallback onNavigation;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text("SomeScreen"), backgroundColor: Colors.red),
            body: Center(
              child: Container(
                child: ListView(
                  children: [0, 1, 2, 3, 4, 5, 6]
                      .map<Widget>((int e) => InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SomeScreen2()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 100,
                      color: Colors.red,
                      child: Center(
                        child: Text(e.toString()),
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SomeScreen2 extends StatelessWidget {
  SomeScreen2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("kekek"),),
      body: Text("asdads"),
    );
  }
}