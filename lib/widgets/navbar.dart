import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) setIndex;

  NavBar(this.selectedIndex, this.setIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: selectedIndex,
        unselectedItemColor: Color.fromRGBO(182, 181, 189, 1),
        selectedLabelStyle: TextStyle(
          color: Color.fromRGBO(182, 181, 189, 1),
        ),
        selectedItemColor: Colors.white,
        onTap: (int idx) {
          setIndex(idx);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            title: Text(
              'Browse',
              style: TextStyle(),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text(
              'News',
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
