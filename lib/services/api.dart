import 'dart:convert';
import 'package:extreme/models/playlist.dart';
import 'package:http/http.dart' as http;

enum Type { Movie, Video, Sport, Playlist }

Future<dynamic> Login(String email, String pass) async {
  print('fetching');
  var response = await http.post('https://extreme.prilogy.ru/api/auth/login',
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: jsonEncode({"email": email, "password": pass}));
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(json.decode(response.body));

    //return User.fromJson(json.decode(response.body));
  } else {
    throw Exception(
        'Api fetch error. Status code: ' + response.statusCode.toString());
  }
}

Future<dynamic> FetchData() async {
  print('fetching');
  var response = await http.post('https://extreme.prilogy.ru/api/auth/login',
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: jsonEncode(
          {"email": "ar.luckjanov@yandex.ru", "password": "123456"}));
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    //  return User.fromJson(json.decode(response.body));
    //return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception(
        'Api fetch error. Status code: ' + response.statusCode.toString());
  }
}

Future<dynamic> Search(Type type, String query) async {
  print('fetching with body: ' + query);
  var response = await http.post(
    'https://extreme.prilogy.ru/api/search',
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json; charset=utf-8",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjYiLCJyb2xlIjoidXNlciIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZXhwaXJhdGlvbiI6IjgvMTQvMjAyMCA1OjUwOjMzIFBNIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbG9jYWxpdHkiOiJydSIsIkN1cnJlbmN5IjoiRVVSIiwibmJmIjoxNTk1Njc3MTk5LCJleHAiOjE1OTYyODE5OTksImlhdCI6MTU5NTY3NzE5OX0.n2IciappLewea8TNLpSrvbaRO6hpjdsqSVfwMvPdM58",
    },
    body: jsonEncode(query),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.statusCode.toString()));
    switch (type) {
      case Type.Playlist:
        print(Playlist(id: 1,videosIds: [3,4]));
        print(json.decode(response.body));
        return Playlist.fromJson(json.decode(response.body));
        break;
      default:
    }

    //return User.fromJson(json.decode(response.body));
    //return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception(
        'Api fetch error. Status code: ' + response.statusCode.toString());
  }
}
// Future<Playlist> getPlaylist(int id) async{
//   http.post('https://extreme.proligy.ru/api.search'){

//   }
// }
