import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QualityLinks {
  String videoId;

  QualityLinks(this.videoId);

  getQualitiesSync() {
    return getQualitiesAsync();
  }

  Future<SplayTreeMap> getQualitiesAsync() async {
    try {
      var response = await http.get('https://player.vimeo.com/video/' + videoId + '/config');
      var jsonData =
      jsonDecode(response.body)['request']['files']['progressive'];
      print(response.body.toString());
      SplayTreeMap videoList = SplayTreeMap.fromIterable(jsonData,
          key: (item) => "${item['quality']} ${item['fps']}",
          value: (item) => item['url']);
      return videoList;
    } catch (error) {
      print('=====> REQUEST ERROR: $error');
      return null;
    }
  }
}