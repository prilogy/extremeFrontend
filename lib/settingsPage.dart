import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Экран настроек

class SettingsScreen extends StatelessWidget {
  // receive data from the FirstScreen as a parameter
  SettingsScreen({
    Key key,
//    @required this.text
  }) : super(key: key);

  void _searchIconAction() {
    // Search some video function
    print('tapped');
  }

  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
//        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
        title: Text('Настройки'),
      ),
      body: Container(
        color: Color.fromRGBO(14, 11, 38, 1),
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[

            // Карточка язык и локализация
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
              color: Colors.transparent,
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print('Card tapped.');
                  },
                  child: Container(
                    width: screenWigth,
                    color: Colors.transparent,
                    child: Text(
                      "Язык и локализация",
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ),
            ),

            // Карточка управление уведомлениями
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: screenWigth,
                  color: Colors.transparent,
                  child: Text(
                    "Управление уведомлениями",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Карточка качество видео
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: screenWigth,
                  color: Colors.transparent,
                  child: Text(
                    "Качество видео",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Карточка очистить историю просмотров
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: screenWigth,
                  color: Colors.transparent,
                  child: Text(
                    "Очистить историю просмотров",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Карточка очистить историю поиска
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: screenWigth,
                  color: Colors.transparent,
                  child: Text(
                    "Очистить историю поиска",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(20, 25, 10, 0),
              child: Text(
                'Другое',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            // Карточка политика конфиденциальности
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: screenWigth,
                  color: Colors.transparent,
                  child: Text(
                    "Политика конфиденциальности",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Карточка обратная связь
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: screenWigth,
                  color: Colors.transparent,
                  child: Text(
                    "Обратная связь",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Карточка обратиться в поддержку
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: screenWigth,
                  color: Colors.transparent,
                  child: Text(
                    "Обратиться в поддержку",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Карточка о приложении
            Card(
              elevation: 0.0,
              margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: screenWigth,
                  color: Colors.transparent,
                  child: Text(
                    "О приложении",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(20, 35, 10, 0),
              child: Text(
                'Версия: 3.2.1.17',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 16.0,
                  color: Color.fromRGBO(182, 181, 189, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
