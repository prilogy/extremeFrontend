part of vimeoplayer;

//throw UnimplementedError();

class QualityLinks {
  String videoId;

  QualityLinks(this.videoId);

  getQualitiesSync() {
    return getQualitiesAsync();
  }

  Future<SplayTreeMap<String, String>?> getQualitiesAsync() async {
    try {
      var response = await http
          .get(Uri.parse('https://player.vimeo.com/video/' + videoId + '/config'));
      var jsonData =
          jsonDecode(response.body)['request']['files']['progressive'];
      SplayTreeMap<String, String> videoList = SplayTreeMap.fromIterable(jsonData,
          key: (item) => "${item['quality']} ${item['fps']}",
          value: (item) => item['url']);
      return videoList;
    } catch (error) {
      print('=====> REQUEST ERROR: $error');
      return null;
    }
  }
}
