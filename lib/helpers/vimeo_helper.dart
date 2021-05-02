import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QualityLinks {
  String videoId;

  QualityLinks(this.videoId);

  getQualitiesSync() {
    return getQualitiesAsync();
  }

  Future<Map<String, String>> getQualitiesAsync() async {
    try {
      var response = await http.get(Uri.parse('https://player.vimeo.com/video/' + videoId + '/config'));
      var jsonData =
      jsonDecode(response.body)['request']['files']['progressive'];
      Map<String, String> videoList = Map.fromIterable(jsonData,
          key: (item) => "${item['quality']} ${item['fps']}",
          value: (item) => item['url']);
      var keys = videoList.keys.toList()..sort();
      keys = keys.reversed.toList();
      if(keys.last.contains("1080"))
        keys.insert(0, keys.removeLast());
      var newMap = Map<String, String> ();
      for(var key in keys) {
        newMap[key] = videoList[key];
      }
      return newMap;
    } catch (error) {
      return null;
    }
  }
}