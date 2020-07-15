import 'package:extreme/settingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Экран профиля пользователя - Профиль

class AccountScreen extends StatelessWidget {
  final String text;

  // receive data from the FirstScreen as a parameter
  AccountScreen({Key key, @required this.text}) : super(key: key);


  void _searchIconAction() {
    // Search some video function
    print('tapped');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
        title: Text('Профиль'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ));
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(14, 11, 38, 1),
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(17, 15, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[

                  // Первый блок - имя, фамилия + почта
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          'Имя Фамилия',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'С Extreme Inseders с 15.05.2020',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 14.0,
                            color: Color.fromRGBO(182, 181, 189, 1),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'Email: example@gmail.com',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Первый блок - кнопка редактирования
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Color.fromRGBO(182, 181, 189, 1),
                          ),
                          tooltip: 'Placeholder',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Второй блок - подписка
            Container(
              margin: EdgeInsets.fromLTRB(17, 15, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          'Подписка',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'До истечения подписки 38 дней',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Третий блок - подписка на месяц
            Container(
              margin: EdgeInsets.fromLTRB(17, 15, 10, 0),
//              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //         <--- border radius here
                    ),
                border: Border.all(
                  color: Color.fromRGBO(242, 153, 74, 1),
                  width: 2, //                   <--- border width here
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 5, 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Подписка на месяц',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            'Идеальное решение для начала',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 13.0,
                              color: Color.fromRGBO(182, 181, 189, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 5, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            '200₽',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: RaisedButton(
                            color: Color.fromRGBO(242, 153, 74, 1),
                            onPressed: () {},
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              alignment: Alignment.center,
//                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: const Text('Продлить',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Четвертый блок - подписка на полгода
            Container(
              margin: EdgeInsets.fromLTRB(17, 15, 10, 0),
//              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //         <--- border radius here
                    ),
                border: Border.all(
                  color: Color.fromRGBO(39, 174, 96, 1),
                  width: 2, //                   <--- border width here
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 5, 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Подписка на полгода',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            'Много контента на долгое время!',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 13.0,
                              color: Color.fromRGBO(182, 181, 189, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 5, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            '1200₽',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: RaisedButton(
                            color: Color.fromRGBO(39, 174, 96, 1),
                            onPressed: () {},
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              alignment: Alignment.center,
//                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: const Text('Продлить',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Пятый блок - подписка на год
            Container(
              margin: EdgeInsets.fromLTRB(17, 15, 10, 0),
//              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //         <--- border radius here
                    ),
                border: Border.all(
                  color: Color.fromRGBO(34, 163, 210, 1),
                  width: 2, //                   <--- border width here
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 5, 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Подписка на месяц',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            'Идеальное решение для начала',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 14.0,
                              color: Color.fromRGBO(182, 181, 189, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 5, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            '2000₽',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: RaisedButton(
                            color: Color.fromRGBO(34, 163, 210, 1),
                            onPressed: () {},
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              alignment: Alignment.center,
//                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: const Text('Продлить',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            Container(
              padding: EdgeInsets.fromLTRB(17, 15, 10, 0),
              child: Text(
                'Подключенные аккаунты',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Подключенные аккаунты
            // Google
            Container(
              margin: EdgeInsets.fromLTRB(17, 15, 10, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: Icon(
                                  Icons.g_translate,
                                  color: Colors.white,
                                ),
                                tooltip: 'Placeholder',
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                'Google',
                                style: TextStyle(
                                  fontFamily: 'RobotoMono',
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {},
                            textColor: Colors.red,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: 120,
                              alignment: Alignment.center,
//                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: const Text('ОТКЛЮЧИТЬ',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
              ),
            ),

            // Vk
            Container(
              margin: EdgeInsets.fromLTRB(17, 15, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                Icons.g_translate,
                                color: Colors.white,
                              ),
                              tooltip: 'Placeholder',
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              'Vk',
                              style: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {},
                          textColor: Color.fromRGBO(39, 174, 96, 1),
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: 130,
                            alignment: Alignment.center,
//                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: const Text('ПОДКЛЮЧИТЬ',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Facebook
            Container(
              margin: EdgeInsets.fromLTRB(17, 15, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                Icons.g_translate,
                                color: Colors.white,
                              ),
                              tooltip: 'Placeholder',
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              'Facebook',
                              style: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {},
                          textColor: Color.fromRGBO(39, 174, 96, 1),
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: 130,
                            alignment: Alignment.center,
//                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: const Text('ПОДКЛЮЧИТЬ',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
