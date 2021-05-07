class VimeoHelpers {
  static String? getVimeoIdFromLink(String? link) {
    if (link == null) return null;
    var splits = link.split('/');
    return splits.last;
  }
}
