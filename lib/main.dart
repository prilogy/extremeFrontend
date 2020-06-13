import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'package:simple_slider/simple_slider.dart';
//import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Extreme'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;
//  final _imageUrls = [
//    "https://png.pngtree.com/thumb_back/fw800/back_pic/00/03/35/09561e11143119b.jpg",
//    "https://png.pngtree.com/thumb_back/fw800/back_pic/04/61/87/28586f2eec77c26.jpg",
//    "https://png.pngtree.com/thumb_back/fh260/back_pic/04/29/70/37583fdf6f4050d.jpg",
//    "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg"
//  ];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _searchIconAction() {
    // Search some video function
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    return new Scaffold(
      body: new Stack(
          children: <Widget>[ Container( //My container or any other widget
            color: Color.fromRGBO(14, 11, 38, 1),
          ),
            SizedBox(
                height: 250.0,
                child: Carousel(
                  images: [
//                    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
//                    NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    ExactAssetImage("extreme1.jpg"),
                    ExactAssetImage("extreme1.jpg"),
                    ExactAssetImage("extreme1.jpg"),
                    ExactAssetImage("extreme1.jpg"),
                    AssetImage('extreme1.jpg'),
                  ],
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.indigo,
                  indicatorBgPadding: 1.0,
                  dotBgColor: Colors.purple.withOpacity(0.0),
                  borderRadius: true,
                  moveIndicatorFromBottom: 180.0,
                  noRadiusForIndicator: true,
                )
            ),
            new Positioned( //Place it at the top, and not use the entire screen
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child:
              AppBar(
                title: Text('Extreme'),
                actions: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.search),
                    onPressed: _searchIconAction,
                  ),
                ],
                backgroundColor: Colors.transparent, //No more green
                elevation: 0.0, //Shadow gone
              ),
            ),
//            new Container(
//              child: ImageSliderWidget(
//                imageUrls: _imageUrls,
//                imageBorderRadius: BorderRadius.circular(10.0),
//                imageHeight: 8,
//              ),
//            ),

          ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(47, 44, 71, 1),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          items: const < BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.playlist_play,
                color: Color.fromRGBO(182, 181, 189, 1)
                ),
              title: Text(
                'Browse',
                style: TextStyle(
                  color: Color.fromRGBO(182, 181, 189, 1),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
                color: Color.fromRGBO(182, 181, 189, 1)
                ),
              title: Text(
                'News',
                style: TextStyle(
                  color: Color.fromRGBO(182, 181, 189, 1),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
                color: Color.fromRGBO(182, 181, 189, 1)
                ),
              title: Text(
                  'Account',
                  style: TextStyle(
                    color: Color.fromRGBO(182, 181, 189, 1),
                  ),
              ),
            ),
          ],
        ),
    );
  }
}
