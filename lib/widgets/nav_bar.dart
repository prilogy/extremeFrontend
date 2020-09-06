import 'package:extreme/store/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) setIndex;
  final Function(int) toRootScreenOfRoute;

  static const double height = 54.0;

  NavBar(this.selectedIndex, this.setIndex, this.toRootScreenOfRoute);

  @override
  Widget build(BuildContext context) {
    var isSubscribed = StoreProvider.of<AppState>(context).state.user.isSubscribed;
    
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: selectedIndex,
        unselectedItemColor: isSubscribed ? Colors.white.withOpacity(0.7) : Colors.white.withOpacity(0.3),
        selectedItemColor: Colors.white,
        onTap: (int idx) {
          if(selectedIndex == idx)
            this.toRootScreenOfRoute(idx);
          if(isSubscribed)
            setIndex(idx);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            title: Text(
              'Browse',
              style: TextStyle(),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text(
              'Account',
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
