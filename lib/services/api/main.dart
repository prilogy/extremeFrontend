library api;

//TODO: сюда весь апи из ../api.dart (по примеру ./user.dart)

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:extreme/models/main.dart' as Models;
import '../api/../dio.dart';
import 'package:http/http.dart' as http;

part 'user.dart';

part 'authentication.dart';

enum EntityType { Movie, Video, Sport, Playlist }

Future<dynamic> Search(EntityType type, String query) async {
  print('fetching with body: ' + query);

  var response = await dio.post(
    '/auth/login',
    options: Options(headers: {
      "Accept": "application/json",
      "Content-Type": "application/json; charset=utf-8",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjYiLCJyb2xlIjoidXNlciIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZXhwaXJhdGlvbiI6IjgvMTQvMjAyMCA1OjUwOjMzIFBNIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbG9jYWxpdHkiOiJydSIsIkN1cnJlbmN5IjoiRVVSIiwibmJmIjoxNTk1Njc3MTk5LCJleHAiOjE1OTYyODE5OTksImlhdCI6MTU5NTY3NzE5OX0.n2IciappLewea8TNLpSrvbaRO6hpjdsqSVfwMvPdM58",
    }),
    data: jsonEncode(query),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.statusCode.toString()));
    switch (type) {
      case EntityType.Playlist:
        print(response.statusMessage);
        return Models.Playlist.fromJson(json.decode(response.toString()));
        break;
      default:
    }
  } else {
    throw Exception(
        'Api fetch error. Status code: ' + response.statusCode.toString());
  }
}

Future<dynamic> Recomended(int page, int pageSize) async {
  Map<String, int> data = Map<String, int>();
  data['page'] = page;
  data['pageSize'] = pageSize;
  var response = await dio.get(
    '/video/recommended',
    options: Options(headers: {
      "Accept": "application/json",
      "Content-Type": "application/json; charset=utf-8",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjYiLCJyb2xlIjoidXNlciIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZXhwaXJhdGlvbiI6IjgvMTQvMjAyMCA1OjUwOjMzIFBNIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbG9jYWxpdHkiOiJydSIsIkN1cnJlbmN5IjoiRVVSIiwibmJmIjoxNTk1Njc3MTk5LCJleHAiOjE1OTYyODE5OTksImlhdCI6MTU5NTY3NzE5OX0.n2IciappLewea8TNLpSrvbaRO6hpjdsqSVfwMvPdM58",
    }),
    queryParameters: data,
  );
  //int videoId = response.data[0]['id'];
  int videoId = 3;
  print('response data: ' + response.data[0].toString());

  /* Возврат всех рекомендаций */
  // return response.data;
  /* */
  var model = await dio.get(
    '/video/' + videoId.toString(),
    options: Options(headers: {
      "Accept": "application/json",
      "Content-Type": "application/json; charset=utf-8",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjYiLCJyb2xlIjoidXNlciIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZXhwaXJhdGlvbiI6IjgvMTQvMjAyMCA1OjUwOjMzIFBNIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbG9jYWxpdHkiOiJydSIsIkN1cnJlbmN5IjoiRVVSIiwibmJmIjoxNTk1Njc3MTk5LCJleHAiOjE1OTYyODE5OTksImlhdCI6MTU5NTY3NzE5OX0.n2IciappLewea8TNLpSrvbaRO6hpjdsqSVfwMvPdM58",
    }),
  );
  print(model.data);
  return model.data;
}

Future<dynamic> VideoByID(int id) async {
  Map<String, int> data = Map<String, int>();
  data['id'] = id;
  var response = await dio.get(
    '/video/' + id.toString(),
    options: Options(headers: {
      "Accept": "application/json",
      "Content-Type": "application/json; charset=utf-8",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjYiLCJyb2xlIjoidXNlciIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZXhwaXJhdGlvbiI6IjgvMTQvMjAyMCA1OjUwOjMzIFBNIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbG9jYWxpdHkiOiJydSIsIkN1cnJlbmN5IjoiRVVSIiwibmJmIjoxNTk1Njc3MTk5LCJleHAiOjE1OTYyODE5OTksImlhdCI6MTU5NTY3NzE5OX0.n2IciappLewea8TNLpSrvbaRO6hpjdsqSVfwMvPdM58",
    }),
    queryParameters: data,
  );
  print(response.data);
  return response.data;
}
