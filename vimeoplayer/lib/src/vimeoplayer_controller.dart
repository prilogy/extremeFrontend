part of vimeoplayer;

class VimeoPlayerController extends VideoPlayerController {
  Map<String, String>? qualityValues;
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

  VimeoPlayerController.fromVimeo(
      VimeoPlayerController controller, String dataSource)
      : qualityValues = controller.qualityValues,
        qualityValue =
            controller.qualityValues?.containsValue(dataSource) ?? false
                ? dataSource
                : null,
        super.network(dataSource,
            videoPlayerOptions: controller.videoPlayerOptions,
            closedCaptionFile: controller.closedCaptionFile,
            httpHeaders: controller.httpHeaders,
            formatHint: controller.formatHint);

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
}
