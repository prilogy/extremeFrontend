class VimeoHelpers {
  static String? getVimeoIdFromLink(String link) {
    var splits = link.split('/');
    return splits[splits.length - 1];
  }
}