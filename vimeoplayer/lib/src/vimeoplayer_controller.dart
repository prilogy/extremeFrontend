part of vimeoplayer;

class VimeoPlayerController extends VideoPlayerController {
  Map? qualityValues;
  String? qualityValue;

  static Future<VimeoPlayerController?> vimeo(String id,
      {VideoFormat? formatHint,
      Future<ClosedCaptionFile>? closedCaptionFile,
      VideoPlayerOptions? videoPlayerOptions,
      Map<String, String> httpHeaders = const {}}) async {
    var qualityValues = await QualityLinks(id).getQualitiesAsync();
    var qualityValue = qualityValues?[qualityValues.lastKey()];
    if (qualityValue == null) return null;

    var controller = VimeoPlayerController.network(qualityValue,
        formatHint: formatHint,
        closedCaptionFile: closedCaptionFile,
        videoPlayerOptions: videoPlayerOptions,
        httpHeaders: httpHeaders);

    controller.qualityValues = qualityValues;
    controller.qualityValue = qualityValue;
    return controller;
  }

  VimeoPlayerController.file(File file,
      {Future<ClosedCaptionFile>? closedCaptionFile,
      VideoPlayerOptions? videoPlayerOptions})
      : super.file(file,
            closedCaptionFile: closedCaptionFile,
            videoPlayerOptions: videoPlayerOptions);

  VimeoPlayerController.asset(String dataSource,
      {String? package,
      Future<ClosedCaptionFile>? closedCaptionFile,
      VideoPlayerOptions? videoPlayerOptions})
      : super.asset(dataSource,
            package: package,
            closedCaptionFile: closedCaptionFile,
            videoPlayerOptions: videoPlayerOptions);

  VimeoPlayerController.network(String dataSource,
      {VideoFormat? formatHint,
      Future<ClosedCaptionFile>? closedCaptionFile,
      VideoPlayerOptions? videoPlayerOptions,
      Map<String, String> httpHeaders = const {}})
      : super.network(dataSource,
            formatHint: formatHint,
            closedCaptionFile: closedCaptionFile,
            videoPlayerOptions: videoPlayerOptions,
            httpHeaders: httpHeaders);

// VimeoPlayerController.vimeo(String id,
//     {Future<ClosedCaptionFile>? closedCaptionFile,
//     VideoPlayerOptions? videoPlayerOptions})
//     : _qualityValues = QualityLinks(id).getQualitiesSync(),
//       super.network(_qualityValues[_qualityValues.keys.last])
//   QualityLinks(id).getQualitiesSync().then((v) {
//   _qualityValues = v;
//   _qualityValue = value[value.lastKey()];
//   dataSource = _qualityValue;
//
//   return v[v.lastKey()];
// }));

// VideoPlayerController.asset(this.dataSource,
//     {this.package, this.closedCaptionFile, this.videoPlayerOptions})
//
// VideoPlayerController.network(
//     this.dataSource, {
//       this.formatHint,
//       this.closedCaptionFile,
//       this.videoPlayerOptions,
//       this.httpHeaders = const {},
//     })
//
// VideoPlayerController.file(File file,
//     {this.closedCaptionFile, this.videoPlayerOptions})

}
